function [ calculated_coeff, LB, UB] = CalculateICC( Kinect, Vicon )
%UNTITLED2 Summary of this function goes here
% Fucntion which calculate ICC for each data point separately and returns
% the average values for a joint as a result
% Kinect and Vicon should have the same size
% Kinect - the data from kinect
% Vicon - the data from the optotrac ! IMPORTANT !

if size(Kinect,2)~=size(Vicon,2)
    display('Error in the size, should be same')
end
newVicon = Vicon;

Vicon=newVicon;
newdata1=Kinect;
newdata1(7,:) = Kinect(8,:);
newdata1(8,:) = Kinect(7,:);
newdata1(9,:) = Kinect(9,:)-25;
newdata1(12,:) = Kinect(12,:)-25;
newdata1(10,:) =Kinect(11,:);
newdata1(11,:) = Kinect(10,:);
Kinect=newdata1;
%% small test
i =7
figure
subplot(1,3,1)
plot(Kinect(i,:));
hold on
plot(Vicon(i,:));
subplot(1,3,2)
plot(Kinect(i+1,:));
hold on
plot(Vicon(i+1,:));
subplot(1,3,3)
plot(Kinect(i+2,:));
hold on
plot(Vicon(i+2,:));
pause();
%%

[m,n]=size(Kinect);
subplot(2,2,1)
plot(Kinect(1:3,:)');title('Angle Knee Left');
hold on
plot(Vicon(1:3,:)','--');
subplot(2,2,2)
plot(Kinect(4:6,:)');title('Angle Knee Right');
hold on
plot(Vicon(4:6,:)','--');
subplot(2,2,3);
plot(Kinect(7:9,:)'); title('Angle Hip Left');
hold on
plot(Vicon(7:9,:)','--');
subplot(2,2,4);
plot(Kinect(10:12,:)'); title('Angle Hip Right');
hold on
plot(Vicon(10:12,:)','--');
str = sprintf('Vicon (dash) and Kinect angles');
 
suptitle(str);
pause();



for i=1:m
    data_XYZ=[Kinect(i,:); Vicon(i,:)];
    [calculated_coeff(i,1), LB(i,1), UB(i,1)]=ICC(data_XYZ', 'C-1', 0.05);

    end

    end
    

