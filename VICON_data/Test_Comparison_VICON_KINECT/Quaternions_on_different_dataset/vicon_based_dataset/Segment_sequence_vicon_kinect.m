function [ cycles, cycles_v] = Segment_sequence_vicon_kinect( Joints, Vicon )
%SEGMENT_SEQUENCE Summary of this function goes here
%   Gait cycle segmentation as it is proposed in paper by Ngoen
% The extraction process is performed with the support of a parameter that has the same periodicity as the gait cycle.  
% The spatial distance between the two feet/ankles is employed in our approach with a smoothing filter to remove noise.
% After getting the waveform values, each gait cycle is estimated by a pair of two consecutive local maxima, which are determined using a sliding window of fixed length
% At time t , the sliding window considers a sequence of smoothed distances, which consists of values from time(tn+1)tot ,
% in which n is the window length. If the center value is the maximum of this sequence, the corresponding human posture 
%is assumed as a starting/ending point of a cycle
cycles = [];
cycles_v=[];
% calculate distance
[O N]= size(Joints.X);
for i=1:O
         point1 = [Joints.X(i,16), Joints.Y(i,16), Joints.Z(i,16)]; % ankle
         point2 =[Joints.X(i,20), Joints.Y(i,20), Joints.Z(i,20)];
    dist(i) = point1(3);
end

dist=medfilt1(dist, 5);


[O N]= size( Vicon.X);
for i=1:O
      point1 = [ Vicon.X(i,16),  Vicon.Y(i,16),  Vicon.Z(i,16)]; % ankle
     point2 =[ Vicon.X(i,20),  Vicon.Y(i,20), Vicon.Z(i,20)];
     dist_v(i) = point1(3);
end
dist_v=dist_v*1000;



 %then sliding window to find mimimums
 [pks,locs] = findpeaks(dist, 'MinPeakDistance',40); % minimum 10 frames per cycle
 average = mean(dist);
 locs(pks<average) = [];
 pks(pks<average) = [];
 y=(1:size(dist,2));

 figure
 subplot(2,1,1);
 plot(y, dist, locs,  dist(locs),   'or');

 title('Distance between 2 feet and located peaks Kinect');
 axis tight
 [pks_v,locs_v] = findpeaks(dist_v, 'MinPeakDistance',40); % minimum 10 frames per cycle
  average = mean(dist_v);
 locs_v(pks_v<average) = [];
 pks_v(pks_v<average) = [];

 y_v=(1:size(dist_v,2));
 subplot(2,1,2);
 plot(y_v, dist_v, locs_v,  dist_v(locs_v),   'or');

 title('Distance between 2 feet and located peaks Vicon');

 axis tight
locs
locs_v
prompt = 'How many cycles correspond one to the other?: ';
Keep = input(prompt);
prompt = 'The last two?: ';
Last_two = input(prompt);
if Last_two
     cycles=locs(end-2:end);
     cycles_v=locs_v(end-2:end);
else
    for j = 1:Keep
       prompt = 'and which frames first-last';
       period(1)=input(prompt);
       period(2)=input(prompt);
       cycles= [cycles, period];
       period(1)=input(prompt);
       period(2)=input(prompt);
       cycles_v = [cycles_v, period];
     end
 
 cycles=unique(cycles);
 cycles_v = unique(cycles_v);
end

% if (locs>=2)
%     cycles = locs;
% end
% 
% 
% % idea - we can then simply change the positions - to augment the number of
% dat
end
% % AnkleLeft	  15 = LANK
% FootLeft	  16 = LTOE
% HipRight	  17 = RASI 
% KneeRight	  18 = RKNE
% AnkleRight  19 = RANK 
% FootRight	  20 = RTOE
