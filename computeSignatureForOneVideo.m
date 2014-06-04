function video_signature = computeSignatureForOneVideo( video_path,dictionary,options,skip_options )
%CALCULATESIGNATUREFORONEVIDEO : compute a signature for a single video
% @param video_path : the path of the video
% @param dictionary : the visual word dictionary
% @param options : the options for calculate the signature form dictionary

[path,name,~] = fileparts(video_path);
tmp_data_dir = fullfile(path,name);
if(~exist(tmp_data_dir,'dir'))
    mkdir(tmp_data_dir);
end

if(~exist('skip_options','var'))
    skip_options.extract_kf = false;
    skip_options.kf_folder = tmp_data_dir;
    skip_options.compute_sift = false;
    skip_options.sift_folder = tmp_data_dir;
    skip_options.compute_sift_sig = false;
    skip_options.kf_sig_folder = tmp_data_dir;
end

if(~isfield(skip_options,'extract_kf'))
    skip_options.extract_kf = false;
    skip_options.kf_folder = tmp_data_dir;
end

if(~isfield(skip_options,'compute_sift'))
    skip_options.compute_sift = false;
    skip_options.sift_folder = tmp_data_dir;    
end

if(~isfield(skip_options,'compute_sift_sig'))
    skip_options.compute_sift_sig = false;
    skip_options.kf_sig_folder = tmp_data_dir;    
end

if(~skip_options.extract_kf)
    fprintf('extract key frames...\n');
    if(~exist(skip_options.kf_folder,'dir'))
        mkdir(skip_options.kf_folder);
    end
    extractOneVideoKeyFrames(video_path,skip_options.kf_folder);  % extract the key frames
end
if(~skip_options.compute_sift)
    fprintf('compute sift features for key frames...\n');
    if(~exist(skip_options.sift_folder,'dir'))
        mkdir(skip_options.sift_folder);
    end
    computeSiftForOneFolder(skip_options.kf_folder,skip_options.sift_folder,1000,'_sift.mat');    % compute the sift feature for the video
end
if(~skip_options.compute_sift_sig)
    fprintf('compute signature for key frames...\n');
    if(~exist(skip_options.kf_sig_folder,'dir'))
        mkdir(skip_options.kf_sig_folder);
    end
    computeSiftSigForOneFolder(skip_options.sift_folder,skip_options.kf_sig_folder,dictionary,options,'_sig.mat'); % compute signature from the sift
end
fprintf('compute signature for video...\n');
video_signature = generateVideoSignature(skip_options.kf_sig_folder,'*_sig.mat');

end

