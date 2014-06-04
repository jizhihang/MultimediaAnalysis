function image_signature = computeImgSignature(fea_set,dictionary,options)
% calculateImgSignature : compute the image signature from the image
% features and the visual word dictionary,some option like pyramid can be
% set for it for better representation
% @param image_feature :
% @param dictionary : 
% @param options :
% @return image_signature

if(exist('options','var'))
    if(isfield(options,'pca'))  % the principle component analysis turn on
        pca_analysis = true;
        eigen_vector = options.eigen_vector;
        k_pc = options.pc_num;
    end
end

sift_feature = double(fea_set.sift_des);
if(pca_analysis)    % get the principle component of the data
   sift_feature = projectData(sift_feature,eigen_vector,k_pc);
end

means = dictionary.means;
covariances = dictionary.covariances;
priors = dictionary.priors;
image_signature = vl_fisher(sift_feature,means,covariances,priors);

end