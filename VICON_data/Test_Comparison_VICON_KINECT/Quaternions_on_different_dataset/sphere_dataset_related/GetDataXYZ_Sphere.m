% read data function
function [XYZ] = GetDataXYZ_Sphere(address)
%check what is in this folder
M = dlmread(address);
Joints = M(:, 3:end);
[samples, joints]=size(M);
X=Joints(:,1:4:end);
Y=Joints(:,2:4:end);
Z=Joints(:,3:4:end);

% just 15 joints in this one -- to be checked
% 1 hip center 1  % spine_base   1 = LPSI+RPSE
% 2 spine 2       % mid_spine    2 = STRN
% 3               % neck         3
% 4 shoulder center 3   
% 5 head 4         % head         4 = RFHD + LFHD
% 6 shoulder left 5 % ShoulderLeft 5 = LSHO
% 7 elbow left 6    % ElbowLeft	   6 = LELB
% 8 wrist left 7    % WristLeft	   7 = LWRA
% 9 hand left 8     % HandLeft	   8
% 10 shoulder right 9  % ShoulderRgt  9 = RSHO
% 11 Elbow Right 10   % ElbowRight  10 = RELB
% 12 wrist right 11   % WristRight  11 = RWRA
% 13 hand right 12    % HandRight   12 
% 14 hip left 13      % HipLeft	  13 = LASI 
% 15 knee left 14     % KneeLeft	  14 = LKNE
% 16 ankle left 15    % AnkleLeft	  15 = LANK
% 17 foot left 16     % FootLeft	  16 = LTOE
% 18 hip right 17     % HipRight	  17 = RASI     
% 29 knee right 18    % KneeRight	  18 = RKNE
% 20 ankle right 19   % AnkleRight  19 = RANK 
% 21 foot right 20    % FootRight	  20 = RTOE
                      % SpineShldr  21 = CLAV
                      hip_centerX = (X(:,10)+X(:,11))/2;
                      hip_centerY =  (Y(:,10)+Y(:,11))/2;
                      hip_centerZ=(Z(:,10)+Z(:,11)+Z(:,2))/3;
% new fixed X, Y Z
Xnew = [hip_centerX, X(:,9), NaN(size(X,1),1), X(:,1), X(:,3), X(:,5), X(:,7), NaN(size(X,1),1), X(:, 4), X(:,6), X(:, 8), NaN(size(X,1),1), X(:,10),X(:,12), X(:,14),  NaN(size(X,1),1), X(:,11),X(:,13), X(:,15),  NaN(size(X,1),1), X(:,2)];
Ynew =  [hip_centerY, Y(:,9), NaN(size(Y,1),1), Y(:,1), Y(:,3), Y(:,5), Y(:,7), NaN(size(Y,1),1), Y(:, 4), Y(:,6), Y(:, 8), NaN(size(Y,1),1), Y(:,10), Y(:,12), Y(:,14),  NaN(size(X,1),1), Y(:,11),Y(:,13), Y(:,15), NaN(size(X,1),1), Y(:,2)];
Znew =  [hip_centerZ, Z(:,9), NaN(size(Z,1),1), Z(:,1), Z(:,3), Z(:,5), Z(:,7), NaN(size(Z,1),1), Z(:, 4), Z(:,6), Z(:, 8), NaN(size(Z,1),1), Z(:,10),Z(:,12), Z(:,14),  NaN(size(X,1),1), Z(:,11),Z(:,13), Z(:,15),  NaN(size(X,1),1), Z(:,2)];
%% Pre-processing of the data
% As  a  common  preprocessing  steps,  we  compute  the  relative  
% difference  of  each  joint’  triplets [xi(t), yi(t), zi(t)]?
 % with the position of the root joint [xroot(t), yroot(t), zroot(t)]? for any t . 
% root is the hip joint --> we take the spin base joint
X=bsxfun(@minus,Xnew,Xnew(:,1));
Y=bsxfun(@minus,Ynew,Ynew(:,1)); % check if the order was actually preserved !
Z=bsxfun(@minus,Znew,Znew(:,1));
%% TO DO ?
%   Determine  the  normalising  length as  the  average Euclidean
%   distance between the joints and the centroid C and normalize

XYZ = struct; 
XYZ.X=X;
XYZ.Y=Y;
XYZ.Z=Z;

%PlotData(XYZ); % Nx3
end