function [XYZ ] = RemoveDataWithErrors( XYZ,  d )




%RemoveDataWithErrors make NaNs from the values which do not satisfy the
%constraints
% the goal is to remove all the wrongly estimated joints --- when there are
% errors and filtering does not help any longer
% only low-limbs joints are intresting, precisely, hip, knee, ankle

% we fit the gaussian distribution on the data of the distance 
[O, N] = size(XYZ.X);
distances = zeros(O, 6); % l h, r h, l k, r k, l a, r a

% % hip,  knee  ankle: 13,17    14,18    15,19
for i=2:O
   lh = [XYZ.X(i,13),XYZ.Y(i,13), XYZ.Z(i,13)];
   rh = [XYZ.X(i,17),XYZ.Y(i,17), XYZ.Z(i,17)];
   lk = [XYZ.X(i,14),XYZ.Y(i,14), XYZ.Z(i,14)];
   rk = [XYZ.X(i,18),XYZ.Y(i,18), XYZ.Z(i,18)];
   la = [XYZ.X(i,15),XYZ.Y(i,15), XYZ.Z(i,15)];
   ra = [XYZ.X(i,19),XYZ.Y(i,19), XYZ.Z(i,19)];
   i_temp = i;
   i=i-1;
   lh_prev = [XYZ.X(i,13),XYZ.Y(i,13), XYZ.Z(i,13)];
   rh_prev = [XYZ.X(i,17),XYZ.Y(i,17), XYZ.Z(i,17)];
   lk_prev = [XYZ.X(i,14),XYZ.Y(i,14), XYZ.Z(i,14)];
   rk_prev = [XYZ.X(i,18),XYZ.Y(i,18), XYZ.Z(i,18)];
   la_prev = [XYZ.X(i,15),XYZ.Y(i,15), XYZ.Z(i,15)];
   ra_prev = [XYZ.X(i,19),XYZ.Y(i,19), XYZ.Z(i,19)];
   i=i_temp;
   distances(i,:) =   [EuclideanDist(lh, lh_prev), EuclideanDist(rh, rh_prev), EuclideanDist(lk, lk_prev), EuclideanDist(rk, rk_prev), EuclideanDist(la, la_prev), EuclideanDist(ra, ra_prev)];
end
% compare the obtained distances with the learned before mean (+- 2 std)
% values coming from the previous dataset. NaN the outliers.
distances=[distances; distances(end,:)];


Threshold= repmat(d.*[15 15 20 20 22 22],O,1);
%M=(distances(2:end,:)>(Threshold)); % if they are bigger - delete corresponding frame
M=(distances(2:end,:)>(3.5));
% make NaN values instead of bad joints
for i=1:O 
    for j=1:6
        if M(i,j)>0
            % filter corresponding joint
            switch j
              case 1
                 XYZ.X(i,13)=NaN; XYZ.Y(i,13)=NaN; XYZ.X(i,13) = NaN;
                 %Orientations.X(i,13)=NaN;  Orientations.Y(i,13)=NaN;  Orientations.Z(i,13)=NaN;  Orientations.W(i,13)=NaN;
               case 2
                  XYZ.X(i,17)=NaN; XYZ.Y(i,17)=NaN; XYZ.X(i,17) = NaN;
                  %Orientations.X(i,17)=NaN;  Orientations.Y(i,17)=NaN;  Orientations.Z(i,17)=NaN;  Orientations.W(i,17)=NaN ;
               case 3 
                  XYZ.X(i,14)=NaN; XYZ.Y(i,14)=NaN; XYZ.X(i,14) = NaN;
                  %Orientations.X(i,14)=NaN;  Orientations.Y(i,14)=NaN;  Orientations.Z(i,14)=NaN;  Orientations.W(i,14)=NaN ;
                   
                case 4
                     XYZ.X(i,18)=NaN; XYZ.Y(i,18)=NaN; XYZ.X(i,18) = NaN;
                  %Orientations.X(i,18)=NaN;  Orientations.Y(i,18)=NaN;  Orientations.Z(i,18)=NaN;  Orientations.W(i,18)=NaN ;
                case 5
                     XYZ.X(i,15)=NaN; XYZ.Y(i,15)=NaN; XYZ.X(i,15) = NaN;
                 % Orientations.X(i,15)=NaN;  Orientations.Y(i,15)=NaN;  Orientations.Z(i,15)=NaN;  Orientations.W(i,15)=NaN ;
                case 6
                     XYZ.X(i,19)=NaN; XYZ.Y(i,19)=NaN; XYZ.X(i,19) = NaN;
                 %  Orientations.X(i,19)=NaN;  Orientations.Y(i,19)=NaN;  Orientations.Z(i,19)=NaN;  Orientations.W(i,19)=NaN ;
   
        end
     end
  end
end
XYZ.X=XYZ.X(1:end-15,:);
XYZ.Y=XYZ.Y(1:end-15,:);
XYZ.Z=XYZ.Z(1:end-15,:);
end
