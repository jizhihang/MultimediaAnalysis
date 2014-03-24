function [ shotBoundary ] = Cal_sb( continuitySignal,video )
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
if(con_threshHold<1.5)        % if the threshhold is too low ,set it to a empirical value
    con_threshHold = 1.5;
end

disp(['continuity thresh hold ' num2str(con_threshHold)]);
shotBoundary = zeros(1,n);

% first mark the value which below the thresh-hold as primiry cut
index = continuitySignal<con_threshHold;
shotBoundary(index) = 1;
shotBoundary = remark_sb_type(shotBoundary);       % remark the shotBoundary with its' type

disp('edge change ratio check for wrong recall');
hardCutIdx = find(shotBoundary==1);
dilate = 3;
ecr_dif_thresh = 2.0e-01;      % the dif-threshhold for edge change ratio
num = numel(hardCutIdx);
for i = 1:num
    tmpIndex = hardCutIdx(i);
    if(tmpIndex==1||tmpIndex==n)
        continue;
    end
    previous = rgb2gray(read(video,tmpIndex-1));
    current = rgb2gray(read(video,tmpIndex));
    next = rgb2gray(read(video,tmpIndex+1));
    ecr1 = edge_change_ratio(previous,current,dilate);
    ecr2 = edge_change_ratio(current,next,dilate);
    ecr_dif = abs(ecr2 - ecr1) / ecr1;
    if(ecr_dif<=ecr_dif_thresh)
        shotBoundary(hardCutIdx(i)) = 0;         % eliminate the wrong recall
%         disp(['cut' num2str(index(i))]);
    end
end
shotBoundary = merge_hard_cut(shotBoundary,continuitySignal);
end

