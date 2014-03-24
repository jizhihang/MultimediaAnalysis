function get_key_frame(filepath,imgfolder)
%GET_KEY_FRAME extract key frame from the video and store it in a file
%  param filepath : the video path
%  param imgfolder : the path to store the key frames

tic

video = VideoReader(filepath);
nFrame = video.NumberOfFrames;

% calculate the continuity signal of the video 
disp('calculate the continuity signal...');
conSig = Get_continuity_signal(video,1);
disp('find boundary with the signal,pleas wait...');
sb = Cal_sb(conSig,video);
cut = find(sb==1);
dissolve = find(sb==3);
disp('extract video to key frames');

mkdir(imgfolder);
cutNum = numel(cut);
dissolveNum = numel(dissolve);
for i = 1:cutNum
    frame = read(video,cut(i));
    path = [imgfolder '/' num2str(cut(i)) '.jpg'];
    imwrite(frame,path,'jpg');
end

for i = 1:dissolveNum
    frame = read(video,dissolve(i));
    path = [imgfolder '/' num2str(dissolve(i)) '_dis.jpg'];
    imwrite(frame,path,'jpg');
end


fprintf('extract (cut=%d,dissolve=%d) from the video %s(frames=%d)\n',cutNum,dissolveNum,filepath,nFrame);
disp('time cost');
toc
end

