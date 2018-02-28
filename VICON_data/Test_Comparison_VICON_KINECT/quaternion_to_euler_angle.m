function [X,Y, Z] =quaternion_to_euler_angle( w, x, y, z )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
	ysqr = y * y;
	
	t0 = +2.0 * (w * x + y * z);
	t1 = +1.0 - 2.0 * (x * x + ysqr);
	X =57* atan2(t0, t1);
	
	t2 = +2.0 * (w * y - z * x)
    if t2 > +1.0
        t2 = +1.0; 
    else
        t2=t2;
    end
	if t2 < -1.0
    t2 = -1.0; 
    else
        tw=t2;
    end
	Y = 57*asin(t2)
	
	t3 = +2.0 * (w * z + x * y);
	t4 = +1.0 - 2.0 * (ysqr + z * z);
	Z = 57*atan2(t3, t4);

end

