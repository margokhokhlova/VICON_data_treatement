function result = MirrowData( joints )
%UNTITLED4 Summary of this function goes here
XYZ=joints;
joints=[];
for i=1:size(XYZ.X,2)
joints = [joints, XYZ.X(:,i),XYZ.Y(:,i), XYZ.Z(:,i)];
end
joints = joints';    

     AnkleLeft = joints([14*3+1:14*3+3],:);
     AnkleRigth=joints([18*3+1:18*3+3],:);
     ElbowLeft=joints([5*3+1:5*3+3],:);
     ElbowRight=joints([9*3+1:9*3+3],:);
     FootLeft=joints([15*3+1:15*3+3],:);		
     FootRight=joints([19*3+1:19*3+3],:);
     HandLeft=joints([7*3+1:7*3+3],:);
     HandRight=joints([11*3+1:11*3+3],:);
     HandTipLeft=joints([21*3+1:21*3+3],:);
     HandTipRight=joints([23*3+1:23*3+3],:);
     HipLeft=joints([12*3+1:12*3+3],:);
     HipRight=joints([16*3+1:16*3+3],:);
     KneeLeft=joints([13*3+1:13*3+3],:);
     KneeRight=joints([17*3+1:17*3+3],:);
     ShoulderLeft=joints([4*3+1:4*3+3],:);	
     ShoulderRight=joints([8*3+1:8*3+3],:);
     ThumbLeft=joints([22*3+1:22*3+3],:);%	22 	Left thumb
     ThumbRight=joints([24*3+1:24*3+3],:);%	24 	Right thumb
     WristLeft=joints([6*3+1:6*3+3],:); %	6 	Left wrist
     WristRight=joints([10*3+1:10*3+3],:);%	10 
joints([14*3+1:14*3+3],:)=bsxfun(@times,AnkleRigth,[-1,1,1]');
joints([18*3+1:18*3+3],:)=bsxfun(@times,AnkleLeft,[-1,1,1]');
% joints([5*3+1:5*3+3],:) = ElbowRight;
% joints([9*3+1:9*3+3],:)=ElbowLeft;
joints([15*3+1:15*3+3],:)=bsxfun(@times,FootRight,[-1,1,1]');
joints([19*3+1:19*3+3],:)=bsxfun(@times,FootLeft,[-1,1,1]');
% joints([7*3+1:7*3+3],:)=HandRight;
% joints([11*3+1:11*3+3],:)=HandLeft;
% joints([21*3+1:21*3+3],:)=HandTipRight;
% joints([23*3+1:23*3+3],:)=HandTipLeft;
joints([12*3+1:12*3+3],:)=bsxfun(@times,HipRight,[-1,1,1]');
joints([16*3+1:16*3+3],:)=bsxfun(@times,HipLeft,[-1,1,1]');
joints([13*3+1:13*3+3],:)=bsxfun(@times,KneeRight,[-1,1,1]');
joints([17*3+1:17*3+3],:)=bsxfun(@times,KneeLeft,[-1,1,1]');
% joints([4*3+1:4*3+3],:)=ShoulderRight;
% joints([8*3+1:8*3+3],:)=ShoulderLeft;
% joints([22*3+1:22*3+3],:)=ThumbRight;
% joints([24*3+1:24*3+3],:)=ThumbLeft;
% joints([6*3+1:6*3+3],:)=WristRight;
% joints([10*3+1:10*3+3],:)=WristLeft;
result=struct;
m=1;

joints = joints';
for i=1:3:63
result.X(:,m) = joints(:,i);
result.Y(:,m) = joints(:,i+1);
result.Z(:,m) = joints(:,i+2);
m=m+1;
end


end

%% nkleLeft	14 	Left ankle
% AnkleRight	18 	Right ankle
% ElbowLeft	5 	Left elbow
% ElbowRight	9 	Right elbow
% FootLeft	15 	Left foot
% FootRight	19 	Right foot
% HandLeft	7 	Left hand
% HandRight	11 	Right hand
% HandTipLeft	21 	Tip of the left hand
% HandTipRight	23 	Tip of the right hand
% Head	3 	Head
% HipLeft	12 	Left hip
% HipRight	16 	Right hip
% KneeLeft	13 	Left knee
% KneeRight	17 	Right knee
% Neck	2 	Neck
% ShoulderLeft	4 	Left shoulder
% ShoulderRight	8 	Right shoulder
% SpineBase	0 	Base of the spine
% SpineMid	1 	Middle of the spine
% SpineShoulder	20 	Spine at the shoulder
% ThumbLeft	22 	Left thumb
% ThumbRight	24 	Right thumb
% WristLeft	6 	Left wrist
% WristRight	10 

