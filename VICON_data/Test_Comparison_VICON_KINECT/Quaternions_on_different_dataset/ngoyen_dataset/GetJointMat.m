function [covmat] = GetJointMat(XYZ,m,n)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
% as Li
X= XYZ.X;
Y=XYZ.Y;
Z=XYZ.Z;
num_frames = n-m;

X_window = X(m:n,:);
Y_window = Y(m:n,:);
Z_window = Z(m:n,:);

covmat_frame = zeros(24,24);
mu =[ mean(X_window); mean(Y_window); mean(Z_window)];
mu=mu(:,2:end);
for i = 1 : num_frames
    frame = [X_window(i,2:end); Y_window(i,2:end); Z_window(i,2:end)];
    covmat_frame =covmat_frame + ((frame' - mu')*transpose(frame' - mu'));
   
end

covmat = covmat_frame/(num_frames-1);
% 
% figure
%  imagesc(covmat);
%  colorbar
%  pause();
end