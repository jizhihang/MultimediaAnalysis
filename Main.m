clear;
videos_dir = './videos';    % the path of the video data
data_dir = './data';      % the path to store the metadata for the videos
dic_path = fullfile(data_dir,'dictionary.mat');
addpath('./pca');
skip_extract_key_frame = true;
skip_extract_sift = true;
skip_extract_dictionary = true;
skip_compute_kf_sig = false;
% skip_compute_video_sig = true;
%%%%%%%%%%%%%%%%%%%%%%%%--meta data generator--%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% video_path = './videos/HVC000451.mp4';
% [path_str,name,ext] = fileparts(video_path);
% key_frame_path = [path_str '/' name];
% mkdir(key_frame_path);
% sift_data_path = key_frame_path;
if(~skip_extract_key_frame)     
    extractAllKeyFrames(videos_dir,data_dir); % extract key frames for all videos
%%% extractOneVideoKeyFrames(video_path,key_frame_path);
end


% extract or retrieval sift feature from all key frames
max_image_size = 1024;
feature_num_dictionary_train = 200000;
if(~skip_extract_sift)
    sift_database = calculateSiftDescriptor(data_dir,data_dir,1024,'_sift.mat');
else
    sift_database = retrievalDatabase(data_dir,'*_sift.mat');
end

% training the visual word dictionary
if(~skip_extract_dictionary)
    fprintf('sampling sift from the database...\n');
    sift_features = randSampling(sift_database,feature_num_dictionary_train);
    % principle component analysis for the sift_features
    k_principle_component = 64;
    [eigen_vector,eigen_value] = pca(sift_features);
    sift_k_pc = projectData(sift_features,eigen_vector,k_principle_component);
    options.pca = true;
    options.eigen_vector = eigen_vector;
    options.pc_num = k_principle_component;
    % sift_origin = recoverData(sift_pca,eigen_vector,k_principle_component);
    dictionary_size = 200;
    fprintf('compute the visual words from local features...\n');
    tic
    dictionary = getDictionary(sift_k_pc,dictionary_size);
    toc
    save(dic_path,'dictionary','options');
    fprintf('save the dictionary out in file %s\n',dic_path);
else
    fprintf('load the dictionary %s in\n',dic_path);
    load(dic_path);
end

% get the signature for the image
% load('./videos/HVC000451/1050_sift.mat');
% image_signature = computeImgSignature(fea_set,dictionary,options);      % compute a signature for a single image
if(~skip_compute_kf_sig)
    calculateKeyFrameDescriptor(data_dir,data_dir,'_sig.mat',dictionary,options);    % calculate the signature for all frame
else
    signatures_database = retrievalDatabase(data_dir,'*_sig.mat');
end
%{
% get the signature for video
% video_sig = generateVideoSignature('./videos/HVC000149','*_sig.mat');
calculateVideoDescriptor(data_dir,data_dir,'_vsig.mat');
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%--classifier train--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%