clc;
clear all;
% Implementation shot boundary detection framework in paper( rule based algorithm)
% (cf. "A Formal Study of Shot Boundary Detection",Jinhui Yuan, IEEE Transactions on, 2007) 
% the feature for video is block-histogram (Using the adaptive thresh-hold)
% and edge change ratio(ECR) is used to eliminate the disturbance of abrupt
% illumination change 

% see param   conSigStored  : whether the video continuity value has been stored
%     param   skip_video2frames : extract video to frames 

% the path of the data and the output

tic
data_folder = '../videos';
videoname = 'HVC006045.mp4';
[path,name,ext] = fileparts(videoname);
imgfolder = fullfile(data_folder,name);
filepath = fullfile(data_folder,videoname);
cutOut = fullfile(data_folder,[name '.txt']);

conSigStored = false;
dataPath = fullfile(data_folder,name);
% this is used to control whether to extract the movie to images
skip_video2frames = false;
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
if ~conSigStored
    conSig = Get_continuity_signal(video,1);
    disp(dataPath);
    save(dataPath,'conSig');
else
    load(dataPath);
end
disp('find boundary with the signal');
sb = Cal_sb(conSig,video);
cut = find(sb==1);
dissolve = find(sb==3);

% X = 1:nFrame-1;               % plot the data 
% figure('numbertitle','off','name','continuitySignal');
% plot(X,conSig,'b+:');

% print the result out
disp(strcat('result is display in ',cutOut));
fid = fopen(cutOut,'w');
fprintf(fid,'hard cut:\n');
fprintf(fid,'%d \n',cut);
fprintf(fid,'dissolve:\n');
fprintf(fid,'%d %d\n',dissolve);
fclose(fid);
toc             % disp the time elapsed


