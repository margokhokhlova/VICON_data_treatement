function [rkL_v,rkR_v,rhL_v, rhR_v] = getViconangles(angles);

rkL_v = angles.LKneeAngles';
rkR_v  =  angles.RKneeAngles';

rhL_v =angles.LHipAngles';
rhR_v  = angles.RHipAngles';
end

