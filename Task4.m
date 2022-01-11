% MATLAB script for Assessment Item-1
% Task-4
clear; close all; clc;

% Step-1: Load input image
I = imread('Starfish.jpg');
IG = rgb2gray(I);


% Step-2: Apply morphological operation + adjust to make stars stand out
% more
se = strel('disk',2);
x = imclose(IG,se);
d = imadjust(x);


% Step-3: put image into black/white, then reset colours to make stars
% white on black background

IG = imbinarize(d);

IG = imcomplement(IG);

% Step-4: fill in holes with imclose to make stars more solid, and apply median filter
% with a 3x3 kernal to remove noise

IG = medfilt2(IG,[3,3]);
IG = imclose(IG,se);

% Step-5: get boundaries of each object in the image

[B,L] = bwboundaries(IG);  

imshow(label2rgb(L, @jet, [.5 .5 .5]));
title('IS IT THIS?');
hold on

for k = 1:length(B)
  bound = B{k};
  plot(bound(:,2), bound(:,1), 'w', 'LineWidth', 2)
end

stats = regionprops(L,'Area','Centroid');

minArea = 750;
maxArea = 900;
minRoundness = 0.1;
maxRoundness = 0.3;


for k = 1:length(B)

  bound = B{k};
  delta_sq = diff(bound).^2;    
  imgPer = sum(sqrt(sum(delta_sq,2)));
  areaNum = stats(k).Area;
  roundnessNum = 4*pi*areaNum/imgPer^2;
  roundnessString = sprintf('%2.2f',roundnessNum);
  areaString = sprintf('%2.2f',areaNum);

  
  % Step-6: if object is within limit of area/roundness, it is a star

  if roundnessNum > minRoundness && roundnessNum < maxRoundness && areaNum > minArea && areaNum < maxArea
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),'ko');
    text(bound(1,2)-35,bound(1,1)+13,roundnessString,'Color','y',...
   'FontSize',14,'FontWeight','bold');
  end
   
end

% Step-7: find/remove objects smaller than stars

starsOutput = bwareaopen(IG, 790);
starsOutputFinal = starsOutput - bwareaopen(IG,900);

figure, 
imshow(I);
figure,
imshow(starsOutputFinal);
title('Found Starfish');