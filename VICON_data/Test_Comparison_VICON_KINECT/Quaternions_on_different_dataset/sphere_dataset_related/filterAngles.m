function [ rkL,rkR,rhL, rhR ] = filterAngles( rkL,rkR,rhL, rhR, n )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

rkL=medfilt1(rkL',n)';
rkR = medfilt1(rkR',n)';
rhL = medfilt1(rhL',n)';
rhR = medfilt1(rhR', n)';
end

