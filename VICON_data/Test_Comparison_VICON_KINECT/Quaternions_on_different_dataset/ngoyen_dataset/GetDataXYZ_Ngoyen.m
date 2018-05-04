% read data function
function [XYZ] = GetDataXYZ_Ngoyen(address)
%check what is in this folder
M = dlmread(address);
Joints = M(:, 1:end);
[samples, joints]=size(M);
X=Joints(:,1:3:end);
Y=Joints(:,2:3:end);
Z=Joints(:,3:3:end);

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



% with the position of the root joint [xroot(t), yroot(t), zroot(t)]? for any t . 
% root is the hip joint --> we take the spin base joint
X=bsxfun(@minus,X,X(:,1));
Y=bsxfun(@minus,Y,Y(:,1)); % check if the order was actually preserved !
Z=bsxfun(@minus,Z,Z(:,1));
%% TO DO ?
%   Determine  the  normalising  length as  the  average Euclidean
%   distance between the joints and the centroid C and normalize

XYZ = struct; 
XYZ.X=X;
XYZ.Y=Y;
XYZ.Z=Z;


end