clc;
clear all;
% Implementation shot boundary detection framework in paper( rule based algorithm)
% (cf. "A Formal Study of Shot Boundary Detection",Jinhui Yuan, IEEE Transactions on, 2007) 
% the feature for video is block-histogram (Using the adaptive thresh-hold)
% and edge change ratio(ECR) is used to eliminate the disturbance of abrupt
% illumination change 

% the path of the data and the output
data_folder = '../data';
videoname = 'foo.avi';
[path,name,ext] = fileparts(videoname);
imgfolder = fullfile(data_folder,name);
filepath = fullfile(data_folder,videoname);
cutOut = fullfile(data_folder,[name '.txt']);
% this is used to control whether to extract the movie to images
skip_video2frames = false;
video = VideoReader(filepath);
nFrame = video.NumberOfFrames;

% write the frames out to the containing folder
if ~skip_video2frames
    mkdir(imgfolder);
    for iter = 1:nFrame
        frame =  read(video,iter);
        path = [imgfolder '/' num2str(iter) '.jpg'];
        imwrite(frame,path,'jpg');
    end
end

% calculate the continuity signal of the video 
conSig = Get_continuity_signal(video,3);
cut = Cal_sb(conSig);
sb = find(cut==1);

X = 1:nFrame-1;               % plot the data 
figure('numbertitle','off','name','continuitySignal');
plot(X,conSig,'b+:');

% print the result out
fid = fopen(cutOut,'w');
fprintf(fid,'shot_boundary at %d \n',sb);
fclose(fid);

