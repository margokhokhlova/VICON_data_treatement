function [] = BDDVICON(folder)

    d=dir(folder);
    data_save=struct; % structure qui va contenir les informations
    [lg, ~]=size(d);
    for i=3:lg
        if d(i).isdir==1
            adresse=[folder '\' d(i).name]; %go to the first subfolder
            save_str={};
            disp(adresse);
            subfolder=dir(adresse);
            for m=3:size(subfolder,1)
                adr=[adresse '\' subfolder(m).name]; % NEEDED for test
                % here the sequences are
                sequences = dir( adr);
                [num_seq, ~]=size(sequences);
                for j=3:num_seq
                    XYZ = struct;
                    addresse=[adr  '\' sequences(j).name]; %go to the first subfolder
                   % addr=[addresse '\' sub_test(3).name];
                   acq = btkReadAcquisition(addresse);
                   markers = btkGetMarkers(acq);
                   angles = btkGetAngles(acq);
                   % data from VICON, taken the right joints and substract  the base joint
                    [X, Y, Z]  = NormalizeMarkers(markers);
                    XYZ.X=X;
                    XYZ.Y=Y;
                    XYZ.Z=Z;
                   % PlotDataWholeSequence( XYZ, sequences(j).name );
                    save_str{j-2}{1} = XYZ;
                    save_str{j-2}{2} = angles;
               %     PlotData(XYZ, sequences(j).name);
               
                end
                   
            end
         [data_save.(d(i).name)]=save_str;       
        end
    end
save('training_vicon.mat', 'data_save');
end



% 
%addpath('G:\MATLAB\toolbox\btk')


