function [ XYZ ] = filterJoints( XYZ)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
XYZ.X = medfilt1(XYZ.X,8);
XYZ.Y = medfilt1(XYZ.Y,8);
XYZ.Z = medfilt1(XYZ.Y,8);
end

