function [ PRW ] = rotationMatrixToEulerAngles( R )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
 
% Calculates rotation matrix to euler angles
% The result is the same as MATLAB except the order
% of the euler angles ( x and z are swapped ).
     
    sy = sqrt(R(1,1) * R(1,1) +  R(2,1) * R(2,1));
     
    singular = sy < 1e-6;
 
    if  ~singular
        x = atan2d(R(3,2) , R(3,3));
        y = atan2d(-R(3,1), sy);
        z = atan2d(R(2,1), R(1,1));
    else 
        x = atan2d(-R(2,3), R(2,2));
        y = atan2d(-R(3,1), sy);
        z = 0;
    end
   PRW=[x, y, z];

end
%         x = math.atan2(R[2,1] , R[2,2])
        %y = math.atan2(-R[2,0], sy)
        %z = math.atan2(R[1,0], R[0,0])
   % else :
    %    x = math.atan2(-R[1,2], R[1,1])
     %   y = math.atan2(-R[2,0], sy)
