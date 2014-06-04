function [U, S] = pca(X)
%PCA Run principal component analysis on the dataset X
%   [U, S, X] = pca(X) computes eigenvectors of the covariance matrix of X
%   Returns the eigenvectors U, the eigenvalues (on diagonal) in S
% @param X : a dim*num data matrix

% Useful values
[dim,num] = size(X);

U = zeros(dim);
S = zeros(dim);

% Note: When computing the covariance matrix, remember to divide by m (the
%       number of examples).
%

sigma = 1/num*(X*X');
[U,S,~] = svd(sigma);
S = diag(S);

end
