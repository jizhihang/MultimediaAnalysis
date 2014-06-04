function video_sig_database = calculateVideoDescriptor(kf_sig_path,videos_sig_path,suffix)
% calculate the video descriptor for all the videos from their key frame
% signatures
% @param kf_sig_path :
% @param videos_sig_path : 
% @param suffix :

disp('compute video signature...');
subfolders = dir(kf_sig_path);
kf_sig_suffix = '*_sig.mat';
video_sig_database.video_num = 0;
video_sig_database.path = {};
for i = 1 :length(subfolders)
    is_folder = subfolders(i).isdir;
    subname = subfolders(i).name;
    if(is_folder && ~strcmp(subname,'.') && ~strcmp(subname,'..'))
        kf_single_video = fullfile(kf_sig_path,subname);
        video_sig = generateVideoSignature(kf_single_video,kf_sig_suffix);
        spath = fullfile(videos_sig_path,[subname suffix]);
        save(spath,'video_sig');
        video_sig_database.path = [video_sig_database.path,spath];
        video_sig_database.video_num = video_sig_database.video_num + 1;
    end
end
end