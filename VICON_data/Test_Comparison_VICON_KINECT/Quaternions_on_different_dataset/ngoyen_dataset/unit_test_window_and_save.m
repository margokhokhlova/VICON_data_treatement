%clc
%clear
%%
% load data
train_data = load('training.mat');
train_data = train_data.data_save; 
persons=fieldnames(train_data);
num_persons=numel(persons);

%Norm_data=[];

person_saved = struct;
for ii=1:num_persons
%for each person
 
  persons{ii}
    person=train_data.(persons{ii});
    figure
     m = 1; % tosave cycles 
    for  j=1:size(person,2)
   
        data=person{j};
        XYZ = data{1};
       % the part to segment
       cycles =1:104:1200;
       
        %[Orientations_New, XYZ] = RemoveDataWithErrors( XYZ, Orientations_New, d );
        % filter out Joints and Orientations in order to remove some
        % outliers
        %VisualizeDCM(XYZ, Orientations_New, j, 'b', Orientations);
        [rkL,rkR,rhL, rhR] = CalculateAnglesfromJoints(XYZ);
        [ rkL,rkR,rhL, rhR ] = filterAngles( rkL,rkR,rhL, rhR, 4 );
        if isempty(cycles)
             %figure 
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
            pause();
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
            end
        %hold off;
        %close all
        else
            
        figure 
        hold on
        for l=2:size(cycles,2)
            cycle_data{m}=[rkL(:,cycles(l-1):cycles(l));rkR(:,cycles(l-1):cycles(l));rhL(:,cycles(l-1):cycles(l)); rhR(:,cycles(l-1):cycles(l))];
            %prompt = 'Keep the cycle?';
            %Keep = input(prompt);
           
            Keep=0;
%             Keep = (cycles(l)-cycles(l-1))>28;
%              prompt = 'no section were detected, decide if you want to keep it : ';
%             Keep = input(prompt);
            if Keep==1
             % do nothing           
            else
              m=m+1;  
            end
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
          %  pause(0.05);
        end
        hold off;
        close all;
        end
        
     end
person_saved.(persons{ii}) = cycle_data;   % '_', int2str(j)) 
end


%% to visualize staff
% imagesc(Norm_data)
% hold on
% line('XData', [0 100], 'YData', [21.5 21.5], 'LineStyle', '-', ...
%     'LineWidth', 0.8, 'Color','m')
% line('XData', [0 100], 'YData', [28.5 28.5], 'LineStyle', '-', ...
%     'LineWidth', 0.8, 'Color','r')

