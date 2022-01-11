% MATLAB script for Assessment Item-1
% Task-4

a = imread('Starfish.jpg');

se = strel('disk',2);

b = rgb2gray(a);

j = imadjust(b);

x = imclose(j,se);
d = imadjust(x);

bw = imbinarize(d);

imshow(bw)


for i=1:size(bw,1)
    for j=1:size(bw,2)
        if bw(i,j) == 0
            bw(i,j) = 1;
        
        else
            bw(i,j) = 0;
        end
    end
end

f = imclose(bw,se);


f = bwareaopen(f,50);

f = medfilt2(f,[3,3]);

imshow(f);


%f = imfill(f,'holes');
[B,L] = bwboundaries(f,'noholes');

imshow(label2rgb(L, @jet, [.5 .5 .5]));

hold on

for k = 1:length(B)
  imgBoundary = B{k};
  plot(imgBoundary(:,2), imgBoundary(:,1), 'w', 'LineWidth', 2)
end

imgStats = regionprops(L,'Area','Centroid');

lowerThreshold = 0.18;
upperThreshold = 0.24;
lowerAreaThreshold = 789;
upperAreaThreshold = 900;

% loop over the boundaries
for k = 1:length(B)

  % obtain (X,Y) imgBoundary coordinates corresponding to label 'k'
  imgBoundary = B{k};

  % compute a simple estimate of the object's imgPer
  delta_sq = diff(imgBoundary).^2;    
  imgPer = sum(sqrt(sum(delta_sq,2)));
  
  % obtain the area calculation corresponding to label 'k'
  area = imgStats(k).Area;
  
  % compute the roundness metricResult
  metricResult = 4*pi*area/imgPer^2;
  
  % display the results
  metricResult_string = sprintf('%2.2f',metricResult);
  area_string = sprintf('%2.2f',area);

  % mark objects above the threshold with a black circle
  if metricResult > lowerThreshold && metricResult < upperThreshold && area < upperAreaThreshold && area > lowerAreaThreshold
    centroid = imgStats(k).Centroid;
    plot(centroid(1),centroid(2),'ko');
  end
  
  text(imgBoundary(1,2)-35,imgBoundary(1,1)+13,metricResult_string,'Color','y',...
   'FontSize',14,'FontWeight','bold');
   
end

finalImageBeta = bwareaopen(f, 789);

finalImageAlpha = finalImageBeta - bwareaopen(f,900);

figure,
imshow(finalImageAlpha);
title('Starfish Located');