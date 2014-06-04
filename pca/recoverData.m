function X_rec = recoverData(Z, U, K)
%RECOVERDATA Recovers an approximation of the original data when using the 
%projected data
%   X_rec = RECOVERDATA(Z, U, K) recovers an approximation the 
%   original data that has been reduced to K dimensions. It returns the
%   approximate reconstruction in X_rec.
% @param Z : the k_pc*num projected data
% @param U : the eigen vector matrix ,every column is a eigen vector
% @param K : the number of eigen vector

% You need to return the following variables correctly.
X_rec = U(:,1:K)*Z;

% =============================================================

end
