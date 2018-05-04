%clc
%clear
%close all
%%
% load data
train_data = load('cycles_normal_sphere.mat');
train_data = train_data.cycle_data; 
persons=numel(train_data);
num_persons=numel(persons);

%%
Norm_data=[];



    for  j=1:num_persons
        data=train_data{j};
        XYZ = data;
        % the part to segment
        %[XYZ] = RemoveDataWithErrors( XYZ, d );
        %cycles = Segment_sequence(XYZ);
        

        [rkL,rkR,rhL, rhR]= CalculateAnglesfromJoints(XYZ);
        [ rkL,rkR,rhL, rhR ] = filterAngles( rkL,rkR,rhL, rhR, 5 );
            figure 
            hold on
        
 
            subplot(2,2,1)
            plot(rkL');title('Angle Knee Left');
            subplot(2,2,2)
            plot(rkR');title('Angle Knee Right');
            subplot(2,2,3);
            plot(rhL'); title('Angle Hip Left');
            subplot(2,2,4);
            plot(rhR'); title('Angle Hip Right');
            str = sprintf('No cycles detected. Plot of %s %d ', persons{ii}, j);
            suptitle(str)
        pause(1);
        hold off;
  
        close all;
        input=[rkL(1,:); rkR(1,:); rhL(1,:); rhR(1,:)]; %  
        [N T]=size(input);
        input = MakeSpeedVariationMetric(input);
         Xa = nancov(input');
         Norm_data = [Norm_data;   Xa(:)']; %  nonzeros
%         figure
         imagesc(upper_part_of_matrix);suptitle(str);

         pause(0.1);
        end



%% to visualize staff
% imagesc(Norm_data)
% hold on
% line('XData', [0 100], 'YData', [21.5 21.5], 'LineStyle', '-', ...
%     'LineWidth', 0.8, 'Color','m')
% line('XData', [0 100], 'YData', [28.5 28.5], 'LineStyle', '-', ...
%     'LineWidth', 0.8, 'Color','r')

