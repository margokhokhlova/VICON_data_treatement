function [t, Joints, Orientations ] = LoadJointsFromAtxt(text_file )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
% read first txt
M = dlmread(text_file);
t=M(:,2);
M =M(:,3:end);
[samples, joints]=size(M);
X=M(:,1:7:end);
Y=M(:,2:7:end);
Z=M(:,3:7:end);

oX=M(:,4:7:end);
oY=M(:,5:7:end);
oZ=M(:,6:7:end);
oW=M(:,7:7:end);

%% plot skeleton
 % substract joint 
X=bsxfun(@minus,X,X(:,1));
Y=bsxfun(@minus,Y,Y(:,1));
Z=bsxfun(@minus,Z,Z(:,1));
Joints = struct;
Orientations = struct;
Joints.X=X;
Joints.Y=Y;
Joints.Z=Z;
Orientations.W=oW;
Orientations.X=oX;
Orientations.Y=oY;
Orientations.Z=oZ;

end

