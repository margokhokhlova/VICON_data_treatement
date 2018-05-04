function [ cycles ] = Segment_sequence_right_foot( Joints )
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
         point1 = [Joints.X(i,15), Joints.Y(i,15), Joints.Z(i,15)]; % ankle
         point2 =[Joints.X(i,19), Joints.Y(i,19), Joints.Z(i,19)];
    end
    dist(i) =point1(3);
end

dist=medfilt1(dist, 10);
dist(dist<-1.0) = NaN;
dist=featureNormalize(dist);
% then sliding window to find mimimums
[pks,locs] = findpeaks(dist, 'MinPeakDistance',9); % minimum 10 frames per cycle
figure
y=(1:size(dist,2));
plot(y, dist, locs,  dist(locs),   'or');
title('Z joint position');
axis tight

%sort out possible values below average

y=(1:size(dist,2));
plot(y, dist, locs,  dist(locs),   'or');
title('Z joint position');
axis tight
pause();


if (numel(locs)>=2)
    cycles = locs;
end
% idea - we can then simply change the positions - to augment the number of
% dat
close
end
% % AnkleLeft	  15 = LANK
% FootLeft	  16 = LTOE
% HipRight	  17 = RASI 
% KneeRight	  18 = RKNE
% AnkleRight  19 = RANK 
% FootRight	  20 = RTOE