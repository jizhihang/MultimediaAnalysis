function [ cut ] = Cal_sb( continuitySignal,video )
% this function calculate the whether the signal i is a cut or not
% param continuitySignal : the continuity value vector,continuitySignal(i)
%                          descripe the continuity between frame i and frame i+1
% cut : a vector with 0 or 1 as its' value .if 0 ,the position is not
%       cut. otherwise , the current position should be a shot boundary.

% show the histogram of the continuity signal
% x = [0:0.01:2];
% figure('numbertitle','off','name','sinal_histogram');
% hist(continuitySignal,x);       

% estimate gaussian parameter
n = numel(continuitySignal);
mu = mean(continuitySignal);
signalSubtractMu = continuitySignal-mu;
sigma2 = 1/n*sum(signalSubtractMu.^2);
con_threshHold = mu-sigma2^0.5;     % set the thresh hold as mu-sigma

disp(['continuity thresh hold ' num2str(con_threshHold)]);
cut = zeros(1,n);

dilate = 3;
ecr_dif_thresh = 2.0e-01;      % the dif-threshhold for edge change ratio
index = find(continuitySignal<con_threshHold);
num = numel(index);
for i = 1:num
    tmpIndex = index(i);
    if(tmpIndex==1||tmpIndex==n)
        continue;
    end
    previous = rgb2gray(read(video,tmpIndex-1));
    current = rgb2gray(read(video,tmpIndex));
    next = rgb2gray(read(video,tmpIndex+1));
    ecr1 = edge_change_ratio(previous,current,dilate);
    ecr2 = edge_change_ratio(current,next,dilate);
    ecr_dif = abs(ecr2 - ecr1) / ecr1;
    if(ecr_dif>ecr_dif_thresh)
        cut(index(i)) = 1;
%         disp(['cut' num2str(index(i))]);
    end
end
end

