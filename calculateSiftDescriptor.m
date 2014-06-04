function [database_sift] = calculateSiftDescriptor(img_dir, data_dir, max_img_size,sift_suffix)
%==========================================================================
% usage: calculate the sift descriptors given the image directory
%
% inputs
% img_dir    -image database root path
% data_dir   -feature database root path
% max_img_size     -maximum size of the input image
% outputs
% database      -directory for the calculated sift features
%
% VL_SIFT is used 
%
% written by Jianchao Yang
% Mar. 2009, IFP, UIUC
% changed by huangying April,2014
% usage :
% img_dir = 'image';  %  every subfolder contains images from one class
% data_dir = 'data'; % this data folder to store the extracted sift in images
% max_img_size = 1024;
% database_sift = calculateSiftDescriptor(img_dir, data_dir, max_img_size);
%==========================================================================

disp('Extracting SIFT features...');
% pay attention to the image format,all image of this format will be used
% to calculate the sift feature

subfolders = dir(img_dir);

database_sift.img_num = 0; % total image number of the database
database_sift.path = {}; % contain the pathes for each image of each class

for i = 1:length(subfolders),
    subname = subfolders(i).name;
    is_folder = subfolders(i).isdir;
    tic
    if is_folder && ~strcmp(subname, '.') && ~strcmp(subname, '..')
        frame_dir = fullfile(img_dir,subname);
        sift_dir = fullfile(data_dir,subname);
        [num_img_in_folder,sift_paths] = computeSiftForOneFolder(frame_dir,sift_dir,max_img_size,sift_suffix);
        database_sift.img_num = database_sift.img_num + num_img_in_folder;
        database_sift.path = [database_sift.path,sift_paths(:)'];
        toc
        fprintf('Processing for %s finished!\n',subname);
    end;
end;