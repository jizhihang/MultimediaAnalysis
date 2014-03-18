function [ cut ] = Cal_sb( continuitySignal )
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

% calculate the probability of the continuity value as a non-boundary value
p = (2*pi*sigma2)^(-0.5)*exp(-0.5/sigma2*signalSubtractMu.^2);
cut = zeros(1,n);

% set the anomal thresh hold of probability(epsilon) to 0.05 and get the cut position
epsilon = 0.05;
for i = 1:n
    if(p(i)<epsilon)
        cut(i) = 1;
    end
end
end

