function [ Normalized_Xa ] = NormalizeCovarianceMatrix( X )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[O N]=size(X);
X=X*.1000;
Normalized_Xa=zeros(O,N);
for i=1:O
    for j=1:N
        Normalized_Xa(i,j)=X(i,j)/( sqrt(X(i,i)*X(j,j)) ) ;
    end
end



end

