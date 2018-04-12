% script to get data from the sphere dataset
folder = 'E:\datasets\Nguyen_sphere\skeletons_only\Testing';
d=dir(folder);
    data_save=struct; % structure qui va contenir les informations
    [lg, ~]=size(d);
    save_str=cell(1,1);
    for i=3:lg
         d(i).name % display name
         addresse = strcat(folder,'//', d(i).name);
         [XYZ] = GetDataXYZ_Sphere(addresse);

            % Plot3DSelectedJointsSequence(XYZ.X,XYZ.Y, XYZ.Z);
            % pause(0.1);

         save_str{1} = XYZ;
         name =  d(i).name(1:end-4); 
        [data_save.(name)]=save_str;        
    end
    
save('Testing_sphere.mat', 'data_save');
