function [t, Joints, Orientations, state ] = LoadJointsFromAtxtWithState(text_file )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
% read first txt
M = dlmread(text_file);
t=M(:,2);
M =M(:,3:end);
[samples, joints]=size(M);

state = M(:,1:8:end); % calculated vs inferred or non-tracked
% Inferred	Joint data is inferred by calculating it from other tracked joints. Since the data is calculated, confidence in the data is very low.
% NotTracked	Joint data is not tracked; there is no joint data available.
% Tracked	Joint data is tracked and available. Since the data is tracked, confidence in the data is very high.

X=M(:,2:8:end);
Y=M(:,3:8:end);
Z=M(:,4:8:end);


oX=M(:,5:8:end);
oY=M(:,6:8:end);
oZ=M(:,7:8:end);
oW=M(:,8:8:end);



%% plot skeleton
 % substract joint 
X=bsxfun(@minus,X,X(:,1));
Y=bsxfun(@minus,Y,Y(:,1));
Z=bsxfun(@minus,Z,Z(:,1));


% filter
X = sgolayfilt(X,3,15);
Y = sgolayfilt(Y,3,15);
Z  = sgolayfilt(Z,3,15);


% orientations
% filter
oW = sgolayfilt(oW,3,5);
oY = sgolayfilt(oY,3,5);
oZ = sgolayfilt(oZ,3,5);
oX = sgolayfilt(oX,3,5);

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

