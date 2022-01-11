% MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;

% Step-1: Load input image
I = imread('Zebra.jpg');
%figure;
%imshow(I);
%title('Step-1: Load input image');

% Step-2: Conversion of input image to grey-scale image
IG = rgb2gray(I);
figure;

imshow(IG);
title('Original image, to be expanded');
figure;


% Step-3


%Nearest neighbour

originalWidth = 556;
originalHeight = 612;

newWidth = 1668;
newHeight = 1836;

scaleWidth = newWidth / originalWidth;
scaleHeight = newHeight / originalHeight;


x = zeros(newWidth,newHeight,'uint8');
 
 
for p = 1:scaleWidth:newWidth 
    for q = 1:scaleHeight:newHeight
        
        origX = ceil(p/scaleWidth);
        origY = ceil(q/scaleHeight);
               
        Temp = IG(origX,origY);
        
        for n1 = 0:1:scaleWidth-1
            for m1 = 0:1:scaleHeight-1
                
                x(p+n1,q+m1) = Temp;
             
            end
        end
           
        
    end
end

%Linear Interpolation

x1 = zeros(newWidth,newHeight,'uint8');


origX1= 1;
origY1 = 1;


        for m = 1:1:newHeight
        for n = 1:3:newWidth     
            
               origX1 = floor((n/scaleWidth)+0.99);
               origY1 = floor((m/scaleHeight)+0.99);
            
               
               if (n < 1666) 
                   if(m < 1834)
                lintemp = IG(origX1, origY1);
                lintemp1 = ((2/3) * IG(origX1,origY1)) + ((1/3) * IG(origX1+1,origY1));
                lintemp2 = ((1/3) * IG(origX1,origY1)) + ((2/3) * IG(origX1+1,origY1));
                
                
                    x1(n,m) = lintemp;
                    x1(n+1,m) = lintemp1;
                    x1(n+2,m) = lintemp2;
                   end
               end
               if (n >= 1666 || m >= 1833)
                   
                lintemp = IG(origX1, origY1);
                lintemp1 = IG(origX1, origY1);
                lintemp2 = IG(origX1, origY1);
                 
                   x1(n,m) = lintemp;
                    x1(n+1,m) = lintemp1;
                    x1(n+2,m) = lintemp2;
                   
               end
      
        end          
        end

 

        %Bilinear Interpolation
        x2 = zeros(newWidth,newHeight,'uint8');
         for j = 1:scaleHeight:newHeight
        for i = 1:scaleWidth:newWidth
           
           
               origX2 = floor((i/scaleWidth)+0.99);
               origY2 = floor((j/scaleHeight)+0.99);
          
                
               if (i < 1666) 
                   if(j < 1834)
                temp = IG(origX2, origY2);                                            %i, j
                temp1 = ((2/3) * IG(origX2,origY2)) + ((1/3) * IG(origX2+1,origY2));  %i+1, j
                temp2 = ((1/3) * IG(origX2,origY2)) + ((2/3) * IG(origX2+1,origY2));  %i+2, j           
                temp3 = ((2/3) * IG(origX2,origY2)) + ((1/3) * IG(origX2,origY2+1));  %i, j+1
                valForTemp4 = ((2/3) * IG(origX2,origY2+1)) + ((1/3) * IG(origX2+1,origY2+1)); %i+1, j+3           
                temp4 = ((1/3) * valForTemp4) + ((2/3) * temp1);                      %i+1, j+1        
                valForTemp5 = ((1/3) * IG(origX2,origY2+1)) + ((2/3) * IG(origX2+1,origY2+1)); %i+2, j+3  
                temp5 = ((2/3) * temp2) + ((1/3) * valForTemp5);                      %i+2, j+1      
                temp6 = ((2/3) * IG(origX2,origY2+1)) + ((1/3) * IG(origX2,origY2));  %i, j+2
                temp7 =  ((2/3) * valForTemp4) + ((1/3) * temp1);                     %i+1, j+2                        
                temp8 = ((1/3) * temp2) + ((2/3) * valForTemp5);                      %i+2, j+2
                
                
                    x2(i,j) = temp;
                    x2(i+1,j) = temp1;
                    x2(i+2,j) = temp2;
                    x2(i,j+1) = temp3;
                    x2(i+1,j+1) = temp4;
                    x2(i+2,j+1) = temp5;
                    x2(i,j+2) = temp6;
                    x2(i+1,j+2) = temp7;
                    x2(i+2,j+2) = temp8;
                   end
               end
               
               if (i >= 1666 || j >= 1833)
                               
                    temp = IG(origX2, origY2);  
                    x2(i,j) = temp;
                    x2(i+1,j) = temp;
                    x2(i+2,j) = temp;
                    x2(i,j+1) = temp;
                    x2(i+1,j+1) = temp;
                    x2(i+2,j+1) = temp;
                    x2(i,j+2) = temp;
                    x2(i+1,j+2) = temp;
                    x2(i+2,j+2) = temp;
                                
               end
              
                
        end          
         end
               



imshow(x);
title('Nearest Neighbour Interpolation');
figure;

imshow(x2);
title('Bilinear Interpolation');



