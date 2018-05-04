function [ XYZ ] = Downsample_vicon( XYZ, samp_r )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
        %% downsample
        samp_r = round(120/samp_r); 
       XYZ.X= downsample(XYZ.X,samp_r);
        XYZ.Y= downsample(XYZ.Y,samp_r);
         XYZ.Z= downsample(XYZ.Z,samp_r);

end

