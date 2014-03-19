clc;
clear all;
% Implementation shot boundary detection framework in paper( rule based algorithm)
% (cf. "A Formal Study of Shot Boundary Detection",Jinhui Yuan, IEEE Transactions on, 2007) 
% the feature for video is block-histogram (Using the adaptive thresh-hold)
% and edge change ratio(ECR) is used to eliminate the disturbance of abrupt
% illumination change 

% the path of the data and the output
start = cputime;
data_folder = '../data';
videoname = 'senses111.mpg';
[path,name,ext] = fileparts(videoname);
imgfolder = fullfile(data_folder,name);
filepath = fullfile(data_folder,videoname);
cutOut = fullfile(data_folder,[name '.txt']);
% this is used to control whether to extract the movie to images
skip_video2frames = true;
video = VideoReader(filepath);
nFrame = video.NumberOfFrames;

% write the frames out to the containing folder
if ~skip_video2frames
    disp('extract video to image');
    bar = round(nFrame/10);
    mkdir(imgfolder);
    for iter = 1:nFrame
        if(rem(iter,bar)==0)
            ret = iter/bar;
            disp(strcat(num2str(ret*10),'% ...'));
        end
        frame =  read(video,iter);
        path = [imgfolder '/' num2str(iter) '.jpg'];
        imwrite(frame,path,'jpg');
    end
end

% calculate the continuity signal of the video 
disp('calculate the continuity signal...');
conSig = Get_continuity_signal(video,1);
disp('find boundary with the signal');
cut = Cal_sb(conSig,video);
sb = find(cut==1);

X = 1:nFrame-1;               % plot the data 
figure('numbertitle','off','name','continuitySignal');
plot(X,conSig,'b+:');

% print the result out
disp(strcat('result is display in ',cutOut));
fid = fopen(cutOut,'w');
fprintf(fid,'shot_boundary at %d \n',sb);
fclose(fid);
times = cputime-start;
disp(['Elapsed time' num2str(times)]);

