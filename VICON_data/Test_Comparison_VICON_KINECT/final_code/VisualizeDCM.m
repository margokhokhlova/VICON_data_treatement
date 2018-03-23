function [] = VisualizeDCM(Joints, Orientations, index, color, secOr)
if (nargin<4)
    color='r';
end
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% hip,  knee  ankle: 13,17    14,18    15,19 
ow=Orientations.W;
oX=Orientations.X;
oY=Orientations.Y;
oZ=Orientations.Z;

x=Joints.X;
y=Joints.Y;
z=Joints.Z;


[N,O] = size(ow);
PRW = zeros (3,N);
figure 
for i = 1:O
    quaternion = [ow(index,i) oX(index,i) oY(index,i) oZ(index,i) ];
    dcm_k = quat2dcm(quaternion);
    X=zeros(3,1); Y=zeros(3,1); Z=zeros(3,1);
    X(1,1) = x(index,i);  X(2,1) =x(index,i); X(3,1)=x(index,i);
    Y(1,1)=y(index,i);Y(2,1) = y(index,i); Y(3,1)=y(index,i);
    Z(3,1)=z(index,i);Z(1,1)=z(index,i);Z(2,1)=z(index,i);
  
   
quiver3(X, Y, Z, dcm_k(:,1), dcm_k(:,2), dcm_k(:,3), 0.1,color);


hold on 
scatter3(X(1,1),Y(1,1),Z(1,1))
hold on

end
X=Joints.X(index,:);
Y=Joints.Y(index,:);
Z=Joints.Z(index,:);

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
hold on;

if (nargin==5)
    color='r';
    Orientations = secOr;
    ow=Orientations.W;
    oX=Orientations.X;
    oY=Orientations.Y;
    oZ=Orientations.Z;
    [N,O] = size(ow);

    for i = 1:O
        quaternion = [ow(index,i) oX(index,i) oY(index,i) oZ(index,i) ];
        dcm_k = quat2dcm(quaternion);
        X=zeros(3,1); Y=zeros(3,1); Z=zeros(3,1);
        X(1,1) = x(index,i);  X(2,1) =x(index,i); X(3,1)=x(index,i);
        Y(1,1)=y(index,i);Y(2,1) = y(index,i); Y(3,1)=y(index,i);
        Z(3,1)=z(index,i);Z(1,1)=z(index,i);Z(2,1)=z(index,i);
  
   
        quiver3(X, Y, Z, dcm_k(:,1), dcm_k(:,2), dcm_k(:,3), 0.1,color);
    end
 end
end
% 
% yaw = pi/6;
% x_v1 = RPY_2_DCM(0,0,yaw)*x_v; %Draw vehicle-1 coordinate frame obtained by right-handed rotation of F_v around z_v
% y_v1 = RPY_2_DCM(0,0,yaw)*y_v;
% z_v1 = RPY_2_DCM(0,0,yaw)*z_v;
% o_v1 = [x_v1'; y_v1'; z_v1'];
% quiver3(zeros(3,1), zeros(3,1), zeros(3,1), o_v1(:,1), o_v1(:,2), o_v1(:,3))