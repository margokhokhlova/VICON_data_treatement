% small visualization normal
P = load('cycles_train_all_w89.mat');
person_saved =P.person_saved;
persons=fieldnames(person_saved);
num_persons=numel(persons);
each = {};
covmat =[];
for ii=1:num_persons
 

rkL_all = [];
rkR_all = [];
rhL_all = [];
rhR_all = [];
    
            data=person_saved.(persons{ii});
            num_seq=numel(data);
           
            figure
            
            for jj = 1:num_seq
                 data_a = data{jj};
                 %data_a = Downsample(data_a, 20);
                 rkL = data_a(1,:); 
                 rkR=data_a(2,:);
                 rhL=data_a(3,:);
                 rhR=data_a(4,:);
                 input = [rkL; rkR; rhL; rhR];
                 %Xa=nancov(input');
                 
                % imagesc(Xa);
                 %pause(1);
                 
                 input=input';
                 [O T] = size(input);
                 Xa=1/(T-1)*input*(1/T* eye(T)-ones(T,T))*(input');
                 covmat = [covmat; [ii, Xa(:)']];
                   rkL_all = [rkL_all; rkL];
                   rkR_all = [rkR_all; rkR];
                   rhL_all = [rhL_all; rhL];
                    rhR_all = [rhR_all; rhR];
            end
            
         figure 
            
         subplot(2,2,1)
         plot(mean(rkL_all)');title('Angle Knee Left');
         subplot(2,2,2)
         plot(mean(rkR_all)');title('Angle Knee Right');
         subplot(2,2,3);
         plot(mean(rhL_all)'); title('Angle Hip Left');
         subplot(2,2,4);
         plot(mean(rhR_all)'); title('Angle Hip Right');
         suptitle(persons{ii});
         pause();
        each{ii}=[mean(rkL_all); mean(rkR_all); mean(rhL_all);mean(rhR_all)];
        ii         
            
end
% %%
% covmat=[];
% g=[];
% for ii=1:num_persons
%     
%     if rem(ii-1,5) == 0
%         figure
%         hold off
%         g=[];
%     end
%            plot(each{ii}');
%            hold on;
%            
%            g = strcat(persons{ii}, g);
%            title(g);
%            Xa=nancov(each{ii}');
%            covmat = [covmat; Xa(:)'];
%            
% end
%%
save('covmat_train_all_89_alternative_big.mat', 'covmat');