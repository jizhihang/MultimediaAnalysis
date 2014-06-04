function extractOneVideoKeyFrames( video_path,key_frame_path )
%EXTRACT_KEY_FRAMES extract the key frame to be frame stored in the path
% @param video_path : the path of the input video
% @param key_frame_path : the path to store the key frames

video = VideoReader(video_path);
num_frame = video.NumberOfFrames;
interval = 150;
num_key_frames = floor(num_frame/interval);

if(~strcmp(video.VideoFormat,'RGB24'))
    fprintf('%s is not the format supported\n',video_path);
    return;
end

bar = round(num_key_frames/10);
for f = 1:num_key_frames
    if(rem(f,bar)==0)
        ret = f/bar;
        fprintf('%d%%...\n',ret*10);
    end
    frame_idx = f*interval;
    frame = read(video,frame_idx);
    path = [key_frame_path '\' num2str(frame_idx) '.jpg'];
    imwrite(frame,path,'jpg');
end

end

