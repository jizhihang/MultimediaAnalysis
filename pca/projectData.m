function Z = projectData(X, U, K)
%PROJECTDATA Computes the reduced data representation when projecting only 
%on to the top k eigenvectors
%   Z = projectData(X, U, K) computes the projection of 
%   the normalized inputs X into the reduced dimensional space spanned by
%   the first K columns of U. It returns the projected examples in Z.
% @param X : a dim*num data matrix
% @param U : the eigen vector of the feature
% @param K : the principle component number

Z = U(:,1:K)'*X;

% =============================================================

end
