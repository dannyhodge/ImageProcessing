% MATLAB script for Assessment Item-1
% Task-2
clear; close all; clc;

% Step-1: Load input image
I = imread('SC.png');

I1 = I;



% Step-2

for i = 1:1:size(I,1)
    for j = 1:1:size(I,2)
        temp = I(i,j);
        if(80 <= temp && temp <= 100) 
           
        I1(i,j) = 220;
        else
            
            I1(i,j) = I(i,j);
            
        end
        
    end
end

imshow(I1);
figure;
imshow(I);






