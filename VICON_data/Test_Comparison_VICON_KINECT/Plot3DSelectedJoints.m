function [] = Plot3DSelectedJoints( X,Y,Z )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
% in total 21, so
figure
scatter3(X, Y, Z, 'or' );
hold on
line(X([2 21]), Y([2 21]), Z([2 21]));
line(X([1 2]), Y([1 2]), Z([1 2]));
line(X([4 21]), Y([4 21]), Z([4 21]));
line(X([1 17]), Y([1 17]), Z([1 17]));
line(X([1 13]), Y([1 13]), Z([1 13]));
line(X([21 5]), Y([21 5]), Z([21 5]));
line(X([21 9]), Y([21 9]), Z([21 9]));
line(X(5:7),Y(5:7), Z(5:7)); %left hand
line(X(9:11),Y(9:11), Z(9:11));
line(X(13:16), Y(13:16), Z(13:16));
line(X(17:20), Y(17:20),Z(17:20));
end

% spine_base   1 = LPSI+RPSE
% mid_spine    2 = STRN
% neck         3
% head         4 = RFHD + LFHD
% ShoulderLeft 5 = LSHO
% ElbowLeft	   6 = LELB
% WristLeft	   7 = LWRA
% HandLeft	   8
% ShoulderRgt  9 = RSHO 
% ElbowRight  10 = RELB 
% WristRight  11 = RWRA

% HipLeft	  13 = LASI 
% KneeLeft	  14 = LKNE
% AnkleLeft	  15 = LANK
% FootLeft	  16 = LTOE
% HipRight	  17 = RASI 
% KneeRight	  18 = RKNE
% AnkleRight  19 = RANK 
% FootRight	  20 = RTOE
% SpineShldr  21 = CLAV