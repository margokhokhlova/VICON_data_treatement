%close all
%%
% load data
train_data = load('cycles_Sphere_abnormal.mat');
train_data = train_data.cycle_data; 
num_persons = numel(train_data);
covmat = [];
for ii=1:num_persons

        data=train_data{ii};
        XYZ = data;
   

        rkL=XYZ(1,:);
        rkR = XYZ(2,:);
        rhL =XYZ(3,:);
        rhR=XYZ(4,:);
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
            
        pause(1);
        hold off;
        close all;


         input=[rkL(1,:); rkR(1,:); rhL(1,:); rhR(1,:)]; %  
         [N T]=size(input);
%         %Xa=1/(T-1)*input*(1/T* eye(T)-ones(T,T))*transpose(input);
%         % ovariance is a measure of how much two random variables vary together. It’s similar to variance, but where variance tells you how a single variable varies, co variance tells you how two variables vary together.
%         % Cov(X,Y) = ? E((X-?)E(Y-?)) / n-1 
          
          Xa = nancov(input');
%         Xa_norm = NormalizeCovarianceMatrix(Xa);
  
         covmat = [covmat;   [2,Xa(:)']]; %  nonzeros
%         figure
         imagesc(Xa);
         colorbar
         
         pause();

end
%end


%% to visualize staff
% imagesc(Norm_data)
% hold on
% line('XData', [0 100], 'YData', [21.5 21.5], 'LineStyle', '-', ...
%     'LineWidth', 0.8, 'Color','m')
% line('XData', [0 100], 'YData', [28.5 28.5], 'LineStyle', '-', ...
%     'LineWidth', 0.8, 'Color','r')

