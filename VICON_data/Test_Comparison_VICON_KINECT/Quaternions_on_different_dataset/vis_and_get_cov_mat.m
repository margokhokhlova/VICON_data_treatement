% small visualization normal
P = load('dai_train_scheme1_cycles.mat');
person_saved =P.cycle_data;

num_persons=numel(person_saved);

covmat =[];
for ii=1:num_persons
      data_a = person_saved{ii};
      rkL = data_a(1,:); 
      rkR=data_a(2,:);
      rhL=data_a(3,:);
      rhR=data_a(4,:);
      input = [rkL; rkR; rhL; rhR];
      Xa=nancov(input');
                % imagesc(Xa);
                 %pause(1);
                 covmat = [covmat; [1, Xa(:)']];
            
end


save('covmat_scheme1_dai_train.mat', 'covmat');