% MATLAB script for Assessment Item-1
% Task-3

clear; close all; clc;

% Step-1: Load input image
I = imread('Noisy.png');

% Step-2: Conversion of input image to grey-scale image
IG = rgb2gray(I);
figure;
imshow(IG);

IG2 = IG;
IG3 = IG;
% Step-3: Averaging filter


val = int32(0);
totAmm = int32(0);

for i = 1:1:size(IG,1) 
    
for j = 1:1:size(IG,2) 
    
   
       if(i>2 && j > 2 && i < size(IG,1) -1 && j < size(IG,2) - 1 )
            
             for n = -2:1:2
    
               for m = -2:1:2
     
                totAmm = totAmm + int32(IG(i+n,j+m));
    
               end
               
             end
                
             val = totAmm / 25;
             totAmm = int32(0);
             IG2(i,j) = val;
       else
           
             IG2(i,j) = 0;
             
       end
       
         
   
end
  
end



val1 = int32(0);
totAmm1 = int32(0);
getVals = int32.empty(0,25);
ordered = 0;


for i1 = 1:1:size(IG,1) 
    
for j1 = 1:1:size(IG,2) 
    
   counter = 1;
       if(i1>2 && j1 > 2 && i1 < size(IG,1) -1 && j1 < size(IG,2) - 1 )
         
             for n1 = -2:1:2
    
               for m1 = -2:1:2    
                getVals(counter) = int32(IG(i1+n1,j1+m1));
                counter = counter + 1;
               end
               
             end
             
             
             newIG = sort(getVals);
             
             
             val1 = newIG(13);
             IG3(i1,j1) = val1;
             
       else
           IG3(i1,j1) = 0;
       end
       
       
   
end
  
end

imshow(IG2);
figure,
imshow(IG3);


