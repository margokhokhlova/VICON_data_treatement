clc
clear
close all
%%
% load data
train_data = load('training_kinect.mat');
train_data = train_data.data_save; 
persons=fieldnames(train_data);
num_persons=numel(persons);

train_vicon = load('training_vicon.mat');
train_vicon = train_vicon.data_save; 
persons_vicon=fieldnames(train_vicon);
num_persons_vicon=numel(persons_vicon);


%%
%Norm_data=[];

m = 1; % tosave cycles
cycle_data = {}; 
for ii=1:num_persons
%for each person
    person=train_data.(persons{ii});
    person_vicon = train_vicon.(persons_vicon{ii});
    
    for  j=1:size(person,2)
        data=person{j};
        XYZ = data{1};
        Orientations = data{2};
        Orientations_New = reOrientHip(Orientations, XYZ);
        
        data_vicon = person_vicon{j};
        XYZ_vicon = data_vicon{1};
      %  XYZ_vicon = Downsample_vicon(XYZ_vicon, 60);
        % the part to segment
       % [XYZ] = RemoveDataWithErrors( XYZ, d );
        [cycles, cycles_v] = Segment_sequence_vicon_kinect(XYZ, XYZ_vicon);
        

        [rkL,rkR,rhL, rhR]= CalculateAngles(Orientations_New);
        [ rkL,rkR,rhL, rhR ] = filterAngles( rkL,rkR,rhL, rhR, 5 );
        % get the vicon angles 
        [rkL_v,rkR_v,rhL_v, rhR_v] = getViconangles(data_vicon{2});
           
        for l=2:size(cycles,2)
            size(cycles,2)
            figure
            cycle_data{m,1}=[rkL(:,cycles(l-1):cycles(l));rkR(:,cycles(l-1):cycles(l));rhL(:,cycles(l-1):cycles(l)); rhR(:,cycles(l-1):cycles(l))];
            
            size_kinect=(cycles(l)-cycles(l-1))+1;
            cycle_data{m,2}=[rkL_v(:,cycles_v(l-1):cycles_v(l));rkR_v(:,cycles_v(l-1):cycles_v(l));rhL_v(:,cycles_v(l-1):cycles_v(l)); rhR_v(:,cycles_v(l-1):cycles_v(l))];
            
            cycle_data{m,2} = Downsample_vicon(cycle_data{m,2},size_kinect);
       
            subplot(2,2,1)
            h = plot(rkL(:,cycles(l-1):cycles(l))');title('Angle Knee Left');
            set(h, {'color'}, {[0.5 0.5 0.5]; [1 0 0]; [0 1 0]})
            hold on
            h= plot(cycle_data{m,2}(1:3,:)','--');
            set(h, {'color'}, {[0.5 0.5 0.5]; [1 0 0]; [0 1 0]})
            %plot(rkL_v(:,cycles_v(l-1):cycles_v(l))', '--');
            
            subplot(2,2,2)
            h=plot(rkR(:,cycles(l-1):cycles(l))');title('Angle Knee Right');
                    set(h, {'color'}, {[0.5 0.5 0.5]; [1 0 0]; [0 1 0]})
            hold on
             h=plot(cycle_data{m,2}(4:6,:)','--');
                     set(h, {'color'}, {[0.5 0.5 0.5]; [1 0 0]; [0 1 0]})
           % plot(rkR_v(:,cycles_v(l-1):cycles_v(l))','--');
            
            subplot(2,2,3);
            h=plot(rhL(:,cycles(l-1):cycles(l))'); title('Angle Hip Left');
             h=       set(h, {'color'}, {[0.5 0.5 0.5]; [1 0 0]; [0 1 0]})
            hold on
            %plot(rhL_v(:,cycles_v(l-1):cycles_v(l))', '--'); 
            h=             plot(cycle_data{m,2}(7:9,:)','--');
                    set(h, {'color'}, {[0.5 0.5 0.5]; [1 0 0]; [0 1 0]})
            
            
            subplot(2,2,4);
            h=plot(rhR(:,cycles(l-1):cycles(l))'); title('Angle Hip Right');
                    set(h, {'color'}, {[0.5 0.5 0.5]; [1 0 0]; [0 1 0]})
            hold on
            %plot(rhR_v(:,cycles_v(l-1):cycles_v(l))','--');
            h= plot(cycle_data{m,2}(10:12,:)','--');
                    set(h, {'color'}, {[0.5 0.5 0.5]; [1 0 0]; [0 1 0]})
            str = sprintf('Plot of %s %d. Cycle %d ', persons{ii}, j,l-1);
            
            suptitle(str);
            pause();
        m=m+1;
        m
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

    end
end


%% to visualize staff
% imagesc(Norm_data)
% hold on
% line('XData', [0 100], 'YData', [21.5 21.5], 'LineStyle', '-', ...
%     'LineWidth', 0.8, 'Color','m')
% line('XData', [0 100], 'YData', [28.5 28.5], 'LineStyle', '-', ...
%     'LineWidth', 0.8, 'Color','r')

