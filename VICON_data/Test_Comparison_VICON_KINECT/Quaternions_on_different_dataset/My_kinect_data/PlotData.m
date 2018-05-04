function [ output_args ] = PlotData( XYZ, name )
%PLOTDATA Summary of this function goes here
%   Detailed explanation goes here
ConnectionsUPCVk2

% Set to 1 for keeping skeleton in (0,0,0)
static    = 1;
Xseq =XYZ.X;
Yseq = XYZ.Y;
Zseq = XYZ.Z;
%display using their function

[J D] = size(Xseq);
if (D == 21)
    Xseq = [X_seq, NaN(4,J)];
    Yseq = [Y_seq, NaN(4,J)];
    Yseq = [Y_seq, NaN(4,J)];
end

    
        
  for j=1:J
      X = Xseq(j,:);
      Y=Yseq(j,:);
      Z=Zseq(j,:);
      td=[X;Y;Z]';
        
                     
            
            clf;
  
            axis([-2 2 -3 3 -2 2]);
            view([-170, -50]); %  
            hold on
            scatter3(td(:,1),td(:,2),td(:,3),'.');
           grid on
            
            for kk=1:size(joints,1)
                plot3([td(joints(kk,1),1) ,td(joints(kk,2),1) ],...
                    [td(joints(kk,1),2) ,td(joints(kk,2),2) ],...
                    [td(joints(kk,1),3) ,td(joints(kk,2),3) ],'b');
                
                
            end
           str = sprintf('%s %d ', name, j);
           suptitle(str)
            
            pause(0.005);
        end






end



