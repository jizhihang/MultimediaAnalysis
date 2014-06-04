function computeSiftSigForOneFolder( sift_folder,signature_folder,dictionary,options,sig_suffix)
%COMPUTESIGFORONEFOLDER Summary of this function goes here
%   Detailed explanation goes here

sift_format = '*_sift.mat';
frames = dir(fullfile(sift_folder,sift_format));
num_img_in_folder = length (frames);

fprintf('compute key frame signature for %s\n',sift_folder);
sig_kf_path = fullfile(signature_folder);
if(~exist(sig_kf_path,'dir'))
    mkdir(sig_kf_path);
end
for f = 1:num_img_in_folder
    path = fullfile(sift_folder,frames(f).name);
    load(path);
    signature = computeImgSignature(fea_set,dictionary,options);
    [~,fname] = fileparts(frames(f).name);
    spath = fullfile(sig_kf_path,[fname sig_suffix]);
    save(spath,'signature');
end

end

