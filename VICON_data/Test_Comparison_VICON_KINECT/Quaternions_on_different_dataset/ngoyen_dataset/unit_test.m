
% load data
train_data = load('testing.mat');
train_data = train_data.data_save; 
persons=fieldnames(train_data);
num_persons=numel(persons);
%%
%Norm_data=[];
for ii=num_persons
%for each person
persons{ii}
    person=train_data.(persons{ii});
    for  j=1:size(person,2)
        data=person{j};
        XYZ = data{1};
        [rkL,rkR,rhL, rhR]= CalculateAnglesfromJoints(XYZ);
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
        
        input=[rkL(1,:); rkR(1,:); rhL(1,:); rhR(1,:)]; %  
        [N T]=size(input);
        %Xa=1/(T-1)*input*(1/T* eye(T)-ones(T,T))*transpose(input);
        % ovariance is a measure of how much two random variables vary together. It’s similar to variance, but where variance tells you how a single variable varies, co variance tells you how two variables vary together.
        % Cov(X,Y) = ? E((X-?)E(Y-?)) / n-1 
        Xa = nancov(input');
        imagesc(Xa)
        upper_part_of_matrix = triu(Xa);
        %eigenVal = eig(Xa);
        figure
        subplot(1,2,1); imagesc(upper_part_of_matrix);suptitle(str);
        subplot(1,2,2);imagesc(eigenVal);
        Norm_data = [Norm_data; nonzeros(upper_part_of_matrix(:))'];
        
        %Xa
        %Xa_norm
       % saveas(gcf,strName);
       
        pause(0.1);
    end
end
% 
% 
%% to visualize staff
figure
imagesc(Norm_data)
hold on
line('XData', [0 100], 'YData', [81.5 81.5], 'LineStyle', '-', ...
    'LineWidth', 0.8, 'Color','m')

