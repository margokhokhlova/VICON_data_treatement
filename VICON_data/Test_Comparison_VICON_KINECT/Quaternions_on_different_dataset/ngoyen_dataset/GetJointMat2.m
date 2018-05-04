function [covmat] = GetJointMat2(XYZ,m,n)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

X= XYZ.X;
Y=XYZ.Y;
Z=XYZ.Z;
num_frames = n-m;

X_window = X(m:n,:);
Y_window = Y(m:n,:);
Z_window = Z(m:n,:);
[T O] = size(X_window);
input = [];
for f=1:O
    input = [input; X_window(:,f)'; Y_window(:,f)'; Z_window(:,f)'];
end
covmat=1/(T-1)*input*(1/T* eye(T)-ones(T,T))*transpose(input);

% 
%figure
 %%colorbar
%  pause();
end