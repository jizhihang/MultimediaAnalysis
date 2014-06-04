function samples = randSampling( database,num_samples)
%RAND_SAMPLING sampling the sift feature from the database
%   the database is a struct with field 
%   'img_num'     % the total image number of the database
%   'class_name'  % name of each class
%   'label'       % label of each class
%   'path'        % the pathes stored the sift feature for each image
%   'num_class'   % how many class of image is the database
%    the path relate to a mat file in which a struct fea_set 
%     with field 'sift_kp' 'sift_des' stored
%  example :
%  [samples,samples_labels] = randSampling( database,100)
%  this will return a 128*100 matrix which was sampled from the database

num_images = database.img_num;
% num_per_image = round(num_samples/num_images);
num_per_image = ceil(num_samples/num_images);
num_samples = num_per_image*num_images;

load(database.path{1});
dim_feature = size(fea_set.sift_des,1);
samples = zeros(dim_feature,num_samples);

total_smp = 0;  
current = 1;

for i = 1:num_images
    fpath = database.path{i};
    load(fpath);
    actual_extracted_num = num_per_image;
    num_feature = size(fea_set.sift_des,2);
    if(num_feature<num_per_image) % if the feature number in image is smaller than extract needed
        actual_extracted_num = num_feature;
    end
    rand_idx = randperm(num_feature);
    samples(:,current:current+actual_extracted_num-1) = fea_set.sift_des(:,rand_idx(1:actual_extracted_num));
    current = current+actual_extracted_num;
    total_smp = total_smp+actual_extracted_num;
end
if(total_smp<num_samples)
    samples = samples(:,1:total_smp);
end

end

