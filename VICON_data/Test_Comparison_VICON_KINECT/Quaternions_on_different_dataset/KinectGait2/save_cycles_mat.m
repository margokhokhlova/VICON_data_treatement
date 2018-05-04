% one cycle based cov matrix calculation

cycles = load('Kinect_gait2_cycles_right.mat');
data=cycles.cycle_data;

cov_mat_save =[];
for i=1:numel(data)
    angles =  data{i};
    Xa = nancov(angles');
    cov_mat_save = [cov_mat_save; [1,Xa(:)']];
end