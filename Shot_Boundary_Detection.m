clc;
clear all;
% Implementation shot boundary detection framework in paper( rule based algorithm)
% (cf. "A Formal Study of Shot Boundary Detection",Jinhui Yuan, IEEE Transactions on, 2007) 
% the feature for video is block-histogram (Using the adaptive thresh-hold)
% and edge change ratio(ECR) is used to eliminate the disturbance of abrupt
% illumination change 

% the name of the movie and the folder to store the frames extracted from
% the movie
filename = 'data/foo.avi';
folder = 'data/foo';
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

% calculate the continuity signal of the video 
conSig = Get_continuity_signal(video,3);

X = 1:nFrame-1;               % plot the data 
figure('numbertitle','off','name','histogram');
plot(X,conSig,'b+:');
% figure('numbertitle','off','name','edge change ratio');
% plot(X,ECR,'r*-');