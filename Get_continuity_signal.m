function [ContinuitySignal] = Get_continuity_signal(mov,nNeighbors)
% This function calculate the continuity of video with its' nNeighbors
% nNerghbors  : the radius of involved neighborhood when calculating the content continuity
%               this paramter is the parameter d in the paper equation 2(page 3)
%              (cf. "A Formal Study of Shot Boundary Detection",Jinhui Yuan, IEEE Transactions on, 2007)
% video       : the video which needed to detect shot,it is a VideoReader object
% histCSignal : the continuity signal of video

data = read(mov);
[~,~,channel,nFrames] = size(data);
histogram = zeros(nFrames,256);
for iter = 1:nFrames
    histogram(iter,:) = imhist(data(:,:,1,iter))';
end
ContinuitySignal = zeros(nFrames-1,1);
similarityMatrix = zeros(nFrames,nFrames);
sigmaSquare = 150^2;
for i = 1:nFrames
    for j = i-nNeighbors:i
        if(j<1)
            continue;
        else
            histInterSec = Cal_histogram_intersection_dis(histogram(i,:),histogram(j,:));
            similarity = histInterSec*exp(-(i-j)^2/sigmaSquare);
            similarityMatrix(i,j) = similarity;
            similarityMatrix(j,i) = similarity;
        end
    end
end
if(nNeighbors==1)
    for iter = 1:nFrames-1
        ContinuitySignal(iter,1) = similarityMatrix(iter,iter+1);
    end
end
%%
% for iter = 1:nFrames-1
%     frame = read(mov,iter);
%     %    [histInterSec,~] = Cal_frame_distance(preFrame,frame);
%     if nChannels == 3
%         preFrame = rgb2gray(preFrame);
%         curFrame = rgb2gray(curFrame);
%     end
%     hist = imhist(curFrame,256);
%     preHist = imhist(preFrame,256);
%     histDis = sum(min(preHist,hist));
%     histDis = histDis/sum(hist1);         % normalize the intersection value
%     ContinuitySignal(iter-1,1) = histDis;
%     preFrame = frame;
% end
end