function [ContinuitySignal] = Get_continuity_signal(mov,nNeighbors)
% This function calculate the continuity of video with its' nNeighbors
% nNerghbors  : the radius of involved neighborhood when calculating the content continuity
%               this paramter is the parameter d in the paper equation 2(page 3)
%              (cf. "A Formal Study of Shot Boundary Detection",Jinhui Yuan, IEEE Transactions on, 2007)
% video       : the video which needed to detect shot,it is a VideoReader object
% histCSignal : the continuity signal of video

nFrames = mov.NumberOfFrames;
histogram = zeros(nFrames,256);

% every time read 200 frame in the buffer , use histogram to represent the frame
buf = 200;
readTimes = floor(nFrames/buf)-1;         % read 200 frames everyTime
remainder = rem(nFrames,buf);
histJ = 1;
disp('calculate image histogram feature...');
for iRead = 0:readTimes
    data = read(mov,[iRead*buf+1 (iRead+1)*buf]);
    for iter = 1:buf
        dataI = rgb2gray(data(:,:,:,iter));
        histogram(histJ,:) = imhist(dataI)';
        histJ = histJ+1;
    end
end
if(remainder>0)     % if the frame can not be divisible by buffer size ,read in the rest data
    data = read(mov,[(readTimes+1)*buf+1 (readTimes+1)*buf+remainder]);
    for iter = 1:remainder
        dataI = rgb2gray(data(:,:,:,iter));
        histogram(histJ,:) = imhist(dataI)';
        histJ = histJ+1;
    end
end

disp('calculate similarity between frames...');
ContinuitySignal = zeros(nFrames-1,1);
similarityMatrix = spalloc(nFrames,nFrames,3*nNeighbors*nFrames);  % this matrix is a sparse matrix only the elements around the diagonal is nonzero
sigmaSquare = 150^2;
for i = 1:nFrames
    for j = i-2*nNeighbors+1:i
        if(j<1)
            continue;
        else
            histInterSec = Cal_histogram_intersection(histogram(i,:),histogram(j,:));
            similarity = histInterSec*exp(-(i-j)^2/sigmaSquare);
            similarityMatrix(i,j) = similarity;
            similarityMatrix(j,i) = similarity;
        end
    end
end
disp('calculate continuity function...');   
% calculate the continuity signal
for iter = 1:nFrames-1
    subLeft = iter-nNeighbors+1;
    subRight = iter+nNeighbors;
    subTop = iter-nNeighbors+1;
    subBottom = iter+nNeighbors;
    if(iter-nNeighbors+1<=0)
        subLeft = 1;
        subTop = 1;
    end
    if(iter+nNeighbors>nFrames)
        subRight = nFrames;
        subBottom = nFrames;
    end
    % the frames in radius 2d are divide into 2 region A ,B ; and calculate
    % the Mcut(A,B) as the continuity score between frame i and frame
    % i+1(see paper for detail)
    A = similarityMatrix(subTop:iter,subLeft:iter);
    B = similarityMatrix(iter+1:subBottom,iter+1:subRight);
    AB = similarityMatrix(iter+1:subBottom,subLeft:iter);
    cutAB = sum(sum(AB))/numel(AB);
    assocA = sum(sum(A))/numel(A);
    assocB = sum(sum(B))/numel(B);
    McutAB = cutAB/assocA+cutAB/assocB;
    ContinuitySignal(iter,1) = McutAB;
end
end