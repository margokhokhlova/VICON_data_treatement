function [data] = Downsample_vicon_angles(data, cycle_size )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
        %% downsample
        
       data = resizem(data, [12, cycle_size]);

end

