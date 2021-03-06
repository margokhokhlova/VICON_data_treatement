function [ Wr, Xr, Yr, Zr ] = QuatornianMultiplication(w0, x0, y0, z0, w1, x1, y1, z1  )
% implementation of the multiplication of two quatornions function
% as explained in the Quaternion Algebra Analysis
Wr = (w0*w1 - x0*x1 - y0*y1 - z0*z1);
Xr = (w0*x1 + x0*w1 + y0*z1 - z0*y1);
Yr = (w0*y1 - x0*z1 + y0*w1 + z0*x1);
Zr = (w0*z1 + x0*y1 - y0*x1 + z0*w1);

end

