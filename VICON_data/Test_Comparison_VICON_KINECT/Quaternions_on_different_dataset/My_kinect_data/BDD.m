function [] = BDD(folder)

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
                    addresse=[adr  '\' sequences(j).name]; %go to the first subfolder
                   % addr=[addresse '\' sub_test(3).name];
                    [t, XYZ, Orientations, state] = LoadJointsFromAtxtwState(addresse);
                    save_str{j-2}{1} = XYZ;
                    save_str{j-2}{2} = Orientations;
                    PlotData(XYZ, sequences(j).name);
               
                end
                   
            end
         [data_save.(d(i).name)]=save_str;       
        end
    end
%save('training.mat', 'data_save');
end

%% order
% {'LFD';'LKI';'RFD';'RKI';'normal'}