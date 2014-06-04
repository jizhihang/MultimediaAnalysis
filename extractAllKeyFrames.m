function extractAllKeyFrames(video_dir,key_frame_dir)
%EXTRACTALLKEYFRAMES extract key frame for all the video
% @param video_dir : the directory for the videos file
% @param key_frame_dir : the directory to store the key frames for videos

disp('extract key frames...');
video_format = '*.mp4';
videos = dir(fullfile(video_dir,video_format));

for v = 1:length(videos)
    tic
    v_name = videos(v).name;
    [~,fname] = fileparts(v_name);
    key_frames_path = fullfile(key_frame_dir,fname);
    if(~exist(key_frames_path,'dir'))
        mkdir(key_frames_path);
    end
    v_path = fullfile(video_dir,v_name);
    extractOneVideoKeyFrames(v_path,key_frames_path);
    toc
    fprintf('extract key frames for %s finished\n',v_path);
end
end

