% small visualization normal
P = load('testing_norm_cycles.mat');
person_saved =P.person_saved;
persons=fieldnames(person_saved);
num_persons=numel(persons);
each = {};
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
                 data_a = Downsample(data_a, 20);
                 rkL = data_a(1,:); 
                 plot(rkL');title(sprintf('Angle Knee Left %s',persons{ii}));
                 ylim([0 90])
                 hold on
                 rkL_all = [rkL_all; rkL];
            end 
            figure
            for jj = 1:num_seq
                  data_a = data{jj};
                 data_a = Downsample(data_a, 20);
                 rkR = data_a(2,:); 
                 plot(rkR');title(sprintf('Angle Knee Right %s',persons{ii}));
                    ylim([0 90])
                 hold on
                 rkR_all = [rkR_all; rkR];
            end 
            figure
            for jj = 1:num_seq
                 data_a = data{jj};
                 data_a = Downsample(data_a, 20);
                rhL=data_a(3,:);
                 plot(rhL');title(sprintf('Angle Hip Left %s',persons{ii}));
                 hold on
                 ylim([0 90])
                   rhL_all = [rhL_all; rhL];
            end
            figure
            for jj = 1:num_seq
                 data_a = data{jj};
                 data_a = Downsample(data_a, 20);
                rhR=data_a(4,:);
                plot(rhR');title(sprintf('Angle Hip Right %s',persons{ii}));
                hold on
                ylim([0 90])
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
%%

g=[];
for ii=1:num_persons
    
    if rem(ii-1,5) == 0
        figure
        hold off
        g=[];
    end
           plot(each{ii}');
           hold on;
           
           g = strcat(persons{ii}, g);
           title(g);
         
           
end
%%