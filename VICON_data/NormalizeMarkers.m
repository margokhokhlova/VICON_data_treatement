function [ m_X, m_Y, m_Z] = NormalizeMarkers( M )
%UNTITLED6 Summary of this function goes here
%   Select only the joints we are going to use later.
% normalize them towards the base spine joint
X = [];
Y = [];
Z = [];

spine_base = (markers.LPSI+markers.RPSI) ./2;
head = (markers.LFHD+markers.RFHD)./2;
[T,N]=size(head);

X=[spine_base(:,1), markers.T10(:,1), zeros(T,1), head(:,1),markers.LSHO(:,1), markers.LELB(:,1), markers.LWRA(:,1), zeros(T,1),...
   markers.RSHO(:,1), markers.RELB(:,1), markers.RWRA(:,1),zeros(T,1), markers.LASI(:,1),  markers.LKNE(:,1), markers.LANK(:,1), markers.LTOE(:,1), ...
   markers.RASI(:,1), markers.RKNE(:,1), markers.RANK(:,1),markers.RTOE(:,1), markers.CLAV(:,1)];

Y=[spine_base(:,2), markers.T10(:,2), zeros(T,1), head(:,2),markers.LSHO(:,2), markers.LELB(:,2), markers.LWRA(:,2), zeros(T,1),...
   markers.RSHO(:,2), markers.RELB(:,2),markers.RWRA(:,2), zeros(T,1), markers.LASI(:,2),  markers.LKNE(:,2), markers.LANK(:,2), markers.LTOE(:,2), ...
   markers.RASI(:,2), markers.RKNE(:,2), markers.RANK(:,2),markers.RTOE(:,2), markers.CLAV(:,2)];

Z=[spine_base(:,3), markers.T10(:,3), zeros(T,3), head(:,3),markers.LSHO(:,3), markers.LELB(:,3), markers.LWRA(:,3), zeros(T,1),...
   markers.RSHO(:,3), markers.RELB(:,3), markers.RWRA(:,3), zeros(T,1), markers.LASI(:,3),  markers.LKNE(:,3), markers.LANK(:,3), markers.LTOE(:,3), ...
   markers.RASI(:,3), markers.RKNE(:,3), markers.RANK(:,3),markers.RTOE(:,1), markers.CLAV(:,3)];

m_X=bsxfun(@minus,X,X(:,1));
m_Y=bsxfun(@minus,Y,Y(:,1));
m_Z=bsxfun(@minus,Z,Z(:,1));




end

% spine_base   1 = LPSI+RPSE
% mid_spine    2 = T10
% neck         3
% head         4 = RFHD + LFHD
% ShoulderLeft 5 = LSHO
% ElbowLeft	   6 = LELB
% WristLeft	   7 = LWRA
% HandLeft	   8
% ShoulderRgt  9 = RSHO 
% ElbowRight  10 = RELB 
% WristRight  11 = RWRA
% HandRight	  12 
% HipLeft	  13 = LASI 
% KneeLeft	  14 = LKNE
% AnkleLeft	  15 = LANK
% FootLeft	  16 = LTOE
% HipRight	  17 = RASI 
% KneeRight	  18 = RKNE
% AnkleRight  19 = RANK 
% FootRight	  20 = RTOE
% SpineShldr  21 = CLAV















%% old list
% 
%RFHD + LFHD
%CLAV
%T10
%LPSI+RPSE
%LASI
%RASI
%LKNE
%RKNE
%LANK
%RANK
%LTOE
%RTOE
%LSHO
%RSHO
%LELB
%RELB
%LWRA
%RWRA

