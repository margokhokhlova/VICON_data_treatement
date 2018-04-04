function [ cycles ] = Segment_sequence( Joints )
%SEGMENT_SEQUENCE Summary of this function goes here
%   Gait cycle segmentation as it is proposed in paper by Ngoen
% The extraction process is performed with the support of a parameter that has the same periodicity as the gait cycle.  
% The spatial distance between the two feet/ankles is employed in our approach with a smoothing filter to remove noise.
% After getting the waveform values, each gait cycle is estimated by a pair of two consecutive local maxima, which are determined using a sliding window of fixed length
% At time t , the sliding window considers a sequence of smoothed distances, which consists of values from time(tn+1)tot ,
% in which n is the window length. If the center value is the maximum of this sequence, the corresponding human posture 
%is assumed as a starting/ending point of a cycle
cycles = [];
% calculate distance
[O N]= size(Joints.X);
for i=1:O
    point1 = [Joints.X(i,16), Joints.Y(i,16), Joints.Z(i,16)]; % foot
    point2 =[Joints.X(i,20), Joints.Y(i,20), Joints.Z(i,20)];
    if (sum(any(point1))<1 || sum(any(point1))<1)
         point1 = [Joints.X(i,16), Joints.Y(i,16), Joints.Z(i,16)]; % ankle
         point2 =[Joints.X(i,20), Joints.Y(i,20), Joints.Z(i,20)];
    end
    dist(i) = EuclideanDist(point1, point2);
end

dist=medfilt1(dist, 5);

% then sliding window to find mimimums
[pks,locs] = findpeaks(dist, 'MinPeakDistance',8); % minimum 10 frames per cycle
y=(1:size(dist,2));
plot(y, dist, locs,  dist(locs),   'or');
title('Distance between 2 feet and located peaks');
axis tight
pause(0.1);
%sort out possible values below average
average = mean(dist);
locs(pks<average) = [];
pks(pks<average) = [];
if (locs>=2)
    cycles = locs;
end
% idea - we can then simply change the positions - to augment the number of
% dat
end
% % AnkleLeft	  15 = LANK
% FootLeft	  16 = LTOE
% HipRight	  17 = RASI 
% KneeRight	  18 = RKNE
% AnkleRight  19 = RANK 
% FootRight	  20 = RTOE
