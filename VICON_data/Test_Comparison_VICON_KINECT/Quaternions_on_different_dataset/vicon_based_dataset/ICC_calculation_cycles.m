% calculate the ICC coefficient for the data

%data=load('cycle_data');
%data=data.cycle_data;
data=cycle_data;
[O N] = size(cycle_data);
ICC_C1 = zeros(12,3);
data1=[]; % kinect
data2 =[]; %vicon
for i=1:O
  data1 =  [data1, data{i,1}];
  data2 = [data2, data{i,2}];
  
  kin = data{i,1};
  vic = data{i,2}
  
  
   % visualization              
   figure
   subplot(2,2,1)
   rkL = kin(1:3,:); rkR = kin(4:6,:); rhL = kin(7:9,:); rhR = kin(10:12,:);
   rhL(3,:) =rhL(3,:)-25;
   rhR(3,:) =rhR(3,:)-25;
   h = plot(rkL');title('Angle Knee Left');
   set(h, {'color'}, {[0.5 0.5 0.5]; [1 0 0]; [0 1 0]})
   hold on
   h= plot( vic(1:3,:)','--');
   set(h, {'color'}, {[0.5 0.5 0.5]; [1 0 0]; [0 1 0]})
       
           
   subplot(2,2,2)
   h=plot(rkR');title('Angle Knee Right');
   set(h, {'color'}, {[0.5 0.5 0.5]; [1 0 0]; [0 1 0]})
   hold on
   h=plot( vic(4:6,:)','--');
   set(h, {'color'}, {[0.5 0.5 0.5];[1 0 0]; [0 1 0]})
               
   subplot(2,2,3);
   h=plot(rhL'); title('Angle Hip Left');
   h= set(h, {'color'}, { [1 0 0];[0.5 0.5 0.5]; [0 1 0]})
   hold on
   h=             plot( vic(7:9,:)','--');
   set(h, {'color'}, {[0.5 0.5 0.5]; [1 0 0]; [0 1 0]})
            
            
   subplot(2,2,4);
   h=plot(rhR'); title('Angle Hip Right');
   set(h, {'color'}, {[1 0 0]; [0.5 0.5 0.5]; [0 1 0]})
   hold on
            %plot(rhR_v(:,cycles_v(l-1):cycles_v(l))','--');
   h= plot( vic(10:12,:)','--');
   set(h, {'color'}, {[0.5 0.5 0.5]; [1 0 0]; [0 1 0]})

            pause();



end

  

 [ICC_C1(:,1),ICC_C1(:,2),ICC_C1(:,3)] = CalculateICC(data1,data2);