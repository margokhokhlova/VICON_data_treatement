%clc
%clear
%%
% load data
train_data = load('training.mat');
train_data = train_data.data_save; 
persons=fieldnames(train_data);
num_persons=numel(persons);

final_mat=[];

person_saved = struct;
for ii=1:num_persons
%for each person
  Joint_mat =[];
  persons{ii}
    person=train_data.(persons{ii});

     m = 1; % tosave cycles 
    for  j=1:size(person,2)
   
        data=person{j};
        XYZ = data{1};
       % the part to segment
       cycles =1:89:1200;

        for l=2:size(cycles,2)
          
            % get matrices
            Xa = GetJointMat2(XYZ, cycles(l-1), cycles(l));
            Joint_mat = [Joint_mat; [ii,Xa(:)']];
        end
  
     end
        
     
final_mat = [final_mat; Joint_mat];   % '_', int2str(j)) 
end


%% to visualize staff
% imagesc(Norm_data)
% hold on
% line('XData', [0 100], 'YData', [21.5 21.5], 'LineStyle', '-', ...
%     'LineWidth', 0.8, 'Color','m')
% line('XData', [0 100], 'YData', [28.5 28.5], 'LineStyle', '-', ...
%     'LineWidth', 0.8, 'Color','r')

