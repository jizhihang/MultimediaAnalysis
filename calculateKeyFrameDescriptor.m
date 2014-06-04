function calculateKeyFrameDescriptor(sift_dir,signature_dir,sig_suffix,dictionary,options)
% calculateKeyFrameDescriptor : calculate the key_frame_signature from the
% sift file of the key frame 
% @param key_frame_sift_path : the path stored the sift file for the key
%       frames
% @param key_frame_signature_path : to store the signature 

disp('Calculate frames signature...');
subfolders = dir(sift_dir);

for i = 1:length(subfolders)
    subname = subfolders(i).name;
    is_folder = subfolders(i).isdir;
    tic
    if(is_folder && ~strcmp(subname,'.') && ~strcmp(subname,'..'))
        sift_folder = fullfile(sift_dir,subname);
        signature_folder = fullfile(signature_dir,subname);  
        computeSiftSigForOneFolder(sift_folder,signature_folder,dictionary,options,sig_suffix);
        toc
        fprintf('finish calculating the key frames signature for %s\n',subname);
    end   
end

end