% one cycle based cov matrix calculation

cycles = load('normal_kinect_chu.mat');
data=cycles.cycle_data;

cov_mat_save =[];
for i=1:numel(data)
    angles =  data{i};
    Xa = nancov(angles');
    imagesc(Xa);
    pause(0.2);
    cov_mat_save = [cov_mat_save; [1,Xa(:)']];
end