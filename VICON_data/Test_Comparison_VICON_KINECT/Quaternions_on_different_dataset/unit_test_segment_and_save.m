%clc
%clear
%%
% load data
train_data = load('training.mat');
train_data = train_data.data_save; 
persons=fieldnames(train_data);
num_persons=numel(persons);
d = load('distances_h_k_a.mat');
d=d.distance_for_save;
%%
%Norm_data=[];
Label =[];
m = 1; % tosave cycles
cycle_data = {};
for ii=1:num_persons
%for each person
    person=train_data.(persons{ii});
    for  j=1:size(person,2)
        if (j==size(person,2)-1)
            label = 1 ;
        else
            label =2 ;
        end
     
        data=person{j};
        XYZ = data{1};
        Orientations = data{2};
        Orientations_New = reOrientHip(Orientations, XYZ);
        % the part to segment
        cycles = Segment_sequence(XYZ);
       
        %[Orientations_New, XYZ] = RemoveDataWithErrors( XYZ, Orientations_New, d );
        % filter out Joints and Orientations in order to remove some
        % outliers
        %VisualizeDCM(XYZ, Orientations_New, j, 'b', Orientations);
        [rkL,rkR,rhL, rhR] = CalculateAngles(Orientations_New);
        [ rkL,rkR,rhL, rhR ] = filterAngles( rkL,rkR,rhL, rhR, 4 );
        if isempty(cycles)
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
            prompt = 'no section were detected, decide if you want to keep it : ';
            Keep = input(prompt);
            Keep
            %pause();
            if (Keep == 1)
                size(rkL)
                prompt = 'and which frames first-last';
                period(1)=input(prompt);
                period(2)=input(prompt);
                cycle_data{m}=[rkL(:,period(1):period(2));rkR(:,period(1):period(2));rhL(:,period(1):period(2)); rhR(:,period(1):period(2))];
                m=m+1;
                Label = [Label; label];
            end
        hold off;
        close all
        else
            
        figure 
        hold on
        for l=2:size(cycles,2)
            cycle_data{m}=[rkL(:,cycles(l-1):cycles(l));rkR(:,cycles(l-1):cycles(l));rhL(:,cycles(l-1):cycles(l)); rhR(:,cycles(l-1):cycles(l))];
            m=m+1;
             Label = [Label; label];
            subplot(2,2,1)
            plot(rkL(:,cycles(l-1):cycles(l))');title('Angle Knee Left');
            subplot(2,2,2)
            plot(rkR(:,cycles(l-1):cycles(l))');title('Angle Knee Right');
            subplot(2,2,3);
            plot(rhL(:,cycles(l-1):cycles(l))'); title('Angle Hip Left');
            subplot(2,2,4);
            plot(rhR(:,cycles(l-1):cycles(l))'); title('Angle Hip Right');
            str = sprintf('Plot of %s %d. Cycle %d ', persons{ii}, j,l-1);
            
            suptitle(str);
            pause();
        end
        hold off;
        close all;
        end
    end
end


%% to visualize staff
% imagesc(Norm_data)
% hold on
% line('XData', [0 100], 'YData', [21.5 21.5], 'LineStyle', '-', ...
%     'LineWidth', 0.8, 'Color','m')
% line('XData', [0 100], 'YData', [28.5 28.5], 'LineStyle', '-', ...
%     'LineWidth', 0.8, 'Color','r')

