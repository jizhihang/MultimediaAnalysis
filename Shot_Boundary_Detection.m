clc;
clear all;
% the name of the movie and the folder to store the frames extracted from
% the movie
filename = 'anni005.mpg';
folder = 'anni005';
% this is used to control whether to extract the movie to images
skip_video2frames = true;
video = VideoReader(filename);
nFrame = video.NumberOfFrames;

% write the frames out to the containing folder
if ~skip_video2frames
    for iter = 1:nFrame
        frame =  read(video,iter);
        path = [folder '/' num2str(iter) '.jpg'];
        imwrite(frame,path,'jpg');
    end
end

% calculate the frame distance 

histD = zeros(nFrame-1,1);
% ECR = zeros(nFrame-1,1);
preFrame = read(video,1);
cut = zeros(nFrame-1,1);
for iter = 2:nFrame
   frame = read(video,iter);
%    [histInterSec,edgeChangeRatio] = Cal_frame_distance(preFrame,frame);
   [histInterSec,~] = Cal_frame_distance(preFrame,frame);
   histD(iter-1,1) = histInterSec;
   if(histInterSec<0.6)
       cut(iter) = 1;
   end
%    ECR(iter-1,1) = edgeChangeRatio;
   preFrame = frame;
end

cutIndex = find(cut==1);

% X = 1:nFrame-1;               % plot the data 
% figure('numbertitle','off','name','histogram');
% plot(X,histD,'b+:');
% figure('numbertitle','off','name','edge change ratio');
% plot(X,ECR,'r*-');