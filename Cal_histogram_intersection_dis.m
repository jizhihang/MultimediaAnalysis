function [ Dis ] = Cal_histogram_intersection_dis( hist1,hist2 )
% this function compute the histogram intersection distance using the
% formula d(h1,h2) = sum(min(h1(I),h2(I)))
% hist1 : the Nx1 histogram of the image 1
% hist2 : the Nx1 histogram of the image 2
% Dis : the histogram intersection distance 

Dis = sum(min(hist1,hist2));
Dis = Dis/sum(hist1);         % normalize the intersection value
end

