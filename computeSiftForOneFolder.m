function [image_num,sift_path] = computeSiftForOneFolder( img_dir,sift_dir,max_img_size,suffix )
%COMPUTESIFTFORONEDIR : compute the sift feature for the image in the
%img_dir(it is a folder contain several image in it)
% @param 

fprintf('extracting sift feature for %s...\n',img_dir);
image_format = '*.jpg';
images = dir(fullfile(img_dir,image_format));

image_num = length(images);
sift_path = cell(image_num,1);

bar = round(image_num/10);
for i = 1:image_num
    if(rem(i,bar)==0)   % the processing bar
        ret = round(i/bar);
        fprintf('%d%%...\n',ret*10);
    end
    
    img_path = fullfile(img_dir,images(i).name);
    image = imread(img_path);
    if(ndims(image)==3)
        image = rgb2gray(image);
    end
    image = im2single(image);
    [im_h,im_w] = size(image);
    if(max(im_h, im_w) > max_img_size)
        image = imresize(image, max_img_size/max(im_h, im_w), 'bicubic');
        [im_h, im_w] = size(image);
    end
    binSize = 8 ;
    magnif = 3 ;
    step = 3;
    image_smooth = vl_imsmooth(image, sqrt((binSize/magnif)^2 - .25)) ;
    [sift_kp, sift_des] = vl_dsift(image_smooth, 'size', binSize,'step',step) ;     % using the dense sift to extract the sift feature

    fea_set.sift_kp = sift_kp;
    fea_set.x = sift_kp(1,:);
    fea_set.y = sift_kp(2,:);
    fea_set.sift_des = sift_des;
    fea_set.width = im_w;
    fea_set.height = im_h;
    % save the sift feature out
    [~, fname] = fileparts(images(i).name);                        
    fpath = fullfile(sift_dir, [fname, suffix]);
    save(fpath, 'fea_set');
    sift_path(i) = {fpath};
end


end

