function [ histDis ,edgeChangeRatio] = Cal_frame_distance( preFrame,curFrame )
%   this function calculate the hist distance  of two frame
%   preFrame : the previous frame
%   curFrame : current frame
%   histDis : the histogram distance of the two frame
%   edgeChangeRatio : the edge change ratio  
[row,col,nChannels] = size(preFrame);
if nChannels == 3
    preFrame = rgb2gray(preFrame);
    curFrame = rgb2gray(curFrame);
end

hist = imhist(curFrame,256);
preHist = imhist(preFrame,256);
histDis = Cal_histogram_intersection_dis(preHist,hist);
edgeChangeRatio = Cal_edge_distance(preFrame,curFrame,1);
end

