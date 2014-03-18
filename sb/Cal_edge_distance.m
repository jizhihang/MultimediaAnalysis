function ECR = Cal_edge_distance(im1,im2,dilateParam)
%
% this function is used to calculate the edge change ratio between im1 and
% im2 , this tow image should be gray scale image
% im1 : image 1
% im2 : image 2
% dilateParam : the parameter used to set the distance used in calculating
%               edge change ratio
%

% black background image
bw1 = edge(im1, 'sobel'); 
bw2 = edge(im2, 'sobel'); 

% invert image to white background
ibw2 = 1-bw2; 
ibw1 = 1-bw1; 

s1 = size(find(bw1),1);
s2 = size(find(bw1),1);

% dilate 
% set the distance r by speicify the dilate parameter
se = strel('square',dilateParam);
dbw1 = imdilate(bw1, se);
dbw2 = imdilate(bw2, se);

imIn = dbw1 & ibw2;
imOut = dbw2 & ibw1;
    
ECRIn = size(find(imIn),1)/s2;
ECROut = size(find(imOut),1)/s1;
    
ECR = max(ECRIn, ECROut);

end
