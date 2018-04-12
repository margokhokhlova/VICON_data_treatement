
% load data
train_data = load('testing.mat');
train_data = train_data.data_save; 
persons=fieldnames(train_data);
num_persons=numel(persons);
d = load('distances_h_k_a.mat');
d=d.distance_for_save;
%%
%Norm_data=[];
for ii=1:num_persons
%for each person
    person=train_data.(persons{ii});
    for  j=1:size(person,2)-1
        data=person{j};
        XYZ = data{1};
        Orientations = data{2};
        Orientations_New = reOrientHip(Orientations, XYZ);
        % the part to segment
        %cycles = Segment_sequence(XYZ);
        % filter out Joints and Orientations in order to remove some
        % outliers
        %[Orientations_New, XYZ] = RemoveDataWithErrors( XYZ, Orientations_New, d );

        %VisualizeDCM(XYZ, Orientations_New, j, 'b', Orientations);
        [rkL,rkR,rhL, rhR]=CalculateAngles(Orientations_New);
        [ rkL,rkR,rhL, rhR ] = filterAngles( rkL,rkR,rhL, rhR, 4 );
%        
%% optional filtering 
       %  [ rkL,rkR,rhL, rhR ] = filterAngles( rkL,rkR,rhL, rhR, 7 )
         figure 
         subplot(2,2,1)
         plot(rkL');title('Angle Knee Left');
         subplot(2,2,2)
         plot(rkR');title('Angle Knee Right');
         subplot(2,2,3);
         plot(rhL'); title('Angle Hip Left');
         subplot(2,2,4);
         plot(rhR'); title('Angle Hip Right');
         str = sprintf('Plot of %s %d ', persons{ii}, j);
        suptitle(str)
        pause(0.1);
        close all
        % features based on the angles data
        %take angles and make correlation matrix
        
        % reshape angles to imput
        strName = sprintf('C://Users//margo_kat//Pictures//some_plots_matrices//flextion//normal%s%d.png ', persons{ii}, j);
        input=[rkL(1,:); rkR(1,:); rhL(1,:); rhR(1,:)]; %  
        [N T]=size(input);
        %Xa=1/(T-1)*input*(1/T* eye(T)-ones(T,T))*transpose(input);
        % ovariance is a measure of how much two random variables vary together. It’s similar to variance, but where variance tells you how a single variable varies, co variance tells you how two variables vary together.
        % Cov(X,Y) = ? E((X-?)E(Y-?)) / n-1 
        Xa = nancov(input');
        imagesc(Xa)

        Xa_norm = NormalizeCovarianceMatrix(Xa);
        upper_part_of_matrix = triu(Xa);
 
         eigenVal = eig(Xa);
        figure
        subplot(1,2,1); imagesc(upper_part_of_matrix);suptitle(str);
        subplot(1,2,2);imagesc(eigenVal);
        Norm_data = [Norm_data;  eigenVal'];
        
        %Xa
        %Xa_norm
       % saveas(gcf,strName);
       
        pause(0.1);
    end
end


%% to visualize staff
imagesc(Norm_data)
hold on
line('XData', [0 100], 'YData', [21.5 21.5], 'LineStyle', '-', ...
    'LineWidth', 0.8, 'Color','m')
line('XData', [0 100], 'YData', [28.5 28.5], 'LineStyle', '-', ...
    'LineWidth', 0.8, 'Color','r')

