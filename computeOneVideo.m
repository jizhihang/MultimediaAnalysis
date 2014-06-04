function v_signature = computeOneVideo(video_path,data_dir,dictionary,options)
% video_path = './videos/HVC000149.mp4';    % the path of the video data
% data_dir = './data/HVC000149';      % the path to store the metadata for the videos
% load(fullfile('./data','dictionary.mat'));
% addpath('./pca');
skip_extract_key_frame = false;
skip_extract_sift = false;
skip_compute_kf_sig = false;

skip_options.extract_kf = skip_extract_key_frame;
skip_options.kf_folder = data_dir;
skip_options.compute_sift = skip_extract_sift;
skip_options.sift_folder = data_dir;
skip_options.compute_sift_sig = skip_compute_kf_sig;
skip_options.kf_sig_folder = data_dir;

v_signature = computeSignatureForOneVideo(video_path,dictionary,options,skip_options);

end