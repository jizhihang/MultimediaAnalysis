function dictionary = getDictionary(features,num_words)
% this function calculate a visual dictionary from the random selecte
% features
% @param features : a d*N matrix, d is the dimension of the feature,N is
%                   the size of the train data
% @param size : how many words the dictionary should be
% @return dictionary : 

numClusters = num_words;
dimension = size(features,1);

% Run KMeans to pre-cluster the data
[initMeans, assignments] = vl_kmeans(features, numClusters,'Algorithm','ANN','MaxNumIterations',5);

initCovariances = zeros(dimension,numClusters);
initPriors = zeros(1,numClusters);

% Find the initial means, covariances and priors
for i=1:numClusters
    data_k = features(:,assignments==i);
    initPriors(i) = size(data_k,2) / numClusters;

    if(size(data_k,1) == 0 || size(data_k,2) == 0)
        initCovariances(:,i) = diag(cov(features'));
    else
        initCovariances(:,i) = diag(cov(data_k'));
    end
end

% Run EM starting from the given parameters
[means,covariances,priors] = vl_gmm(features, numClusters, ...
    'initialization','custom', ...
    'InitMeans',initMeans, ...
    'InitCovariances',initCovariances, ...
    'InitPriors',initPriors);

dictionary.means = means;
dictionary.covariances = covariances;
dictionary.priors = priors;

end