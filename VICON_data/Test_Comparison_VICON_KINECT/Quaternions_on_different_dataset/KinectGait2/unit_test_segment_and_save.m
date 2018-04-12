clc
clear
close all
%%
% load data
train_data = load('Kinect_GaitK2_seq.mat');
train_data = train_data.data_save; 
persons=fieldnames(train_data);
num_persons=numel(persons);
d = load('distances_h_k_a.mat');
d=d.distance_for_save;
%%
%Norm_data=[];

m = 1; % tosave cycles
cycle_data = {};
for ii=1:num_persons
%for each person
    person=train_data.(persons{ii});
    for  j=1:size(person,2)
        data=person{j};
        XYZ = data;
        % the part to segment
       % [XYZ] = RemoveDataWithErrors( XYZ, d );
        cycles = Segment_sequence(XYZ);
        

        [rkL,rkR,rhL, rhR]= CalculateAnglesfromJoints(XYZ);
        [ rkL,rkR,rhL, rhR ] = filterAngles( rkL,rkR,rhL, rhR, 5 );
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
 % pause();
        hold off;
        else
            
        figure 
        hold on
        for l=2:size(cycles,2)
            cycle_data{m}=[rkL(:,cycles(l-1):cycles(l));rkR(:,cycles(l-1):cycles(l));rhL(:,cycles(l-1):cycles(l)); rhR(:,cycles(l-1):cycles(l))];
            m=m+1;
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
            pause(0.4);
        end
        hold off;
        
        close all;
%% optional filtering 
       %  [ rkL,rkR,rhL, rhR ] = filterAngles( rkL,rkR,rhL, rhR, 7 )
   
%    
% 
%         % features based on the angles data
%         %take angles and make correlation matrix
%         
%         % reshape angles to imput
%         strName = sprintf('C://Users//margo_kat//Pictures//some_plots_matrices//flextion//normal%s%d.png ', persons{ii}, j);
%         input=[rkL(1,:); rkR(1,:); rhL(1,:); rhR(1,:)]; %  
%         [N T]=size(input);
%         %Xa=1/(T-1)*input*(1/T* eye(T)-ones(T,T))*transpose(input);
%         % ovariance is a measure of how much two random variables vary together. It’s similar to variance, but where variance tells you how a single variable varies, co variance tells you how two variables vary together.
%         % Cov(X,Y) = ? E((X-?)E(Y-?)) / n-1 
%         Xa = nancov(input');
%         Xa_norm = NormalizeCovarianceMatrix(Xa);
%         upper_part_of_matrix = triu(Xa);
%         Norm_data = [Norm_data;  Xa(:)'];
%         figure
%         imagesc(upper_part_of_matrix);suptitle(str);
%         %Xa
%         %Xa_norm
%        % saveas(gcf,strName);
%         pause();
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

