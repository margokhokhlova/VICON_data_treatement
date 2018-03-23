% read data function
function [XYZ, Orientations] = GetDataXYZ_Orientations(address)
%check what is in this folder
file_to_read = strcat(address, '\skeleton.txt');
M = dlmread(file_to_read);

Joints = M(:, 4:end);
[samples, joints]=size(M);
X=Joints(:,1:7:end);
Y=Joints(:,2:7:end);
Z=Joints(:,3:7:end);
oW=Joints(:,4:7:end);
oX=Joints(:,5:7:end);
oY=Joints(:,6:7:end);
oZ=Joints(:,7:7:end);
%% Pre-processing of the data
% As  a  common  preprocessing  steps,  we  compute  the  relative  
% difference  of  each  joint’  triplets [xi(t), yi(t), zi(t)]?
 % with the position of the root joint [xroot(t), yroot(t), zroot(t)]? for any t . 
% root is the hip joint --> we take the spin base joint
X=bsxfun(@minus,X,X(:,1));
Y=bsxfun(@minus,Y,Y(:,1));
Z=bsxfun(@minus,Z,Z(:,1));
%% TO DO ?
%   Determine  the  normalising  lengthLi as  the  average Euclidean
%   distance between the joints and the centroid C and normalize

XYZ = struct; Orientations = struct;
XYZ.X=X;
XYZ.Y=Y;
XYZ.Z=Z;
Orientations.W=oW;
Orientations.X=oX;
Orientations.Y=oY;
Orientations.Z=oZ;

%PlotData(XYZ); % Nx3
end