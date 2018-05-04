%Plot3DSelectedJointsSequence( Joints.X, Joints.Y, Joints.Z );

 Orientations_New = reOrientHip(Orientations, Joints);
        % the part to segment
        %cycles = Segment_sequence(XYZ);
        % filter out Joints and Orientations in order to remove some
        % outliers
        %[Orientations_New, XYZ] = RemoveDataWithErrors( XYZ, Orientations_New, d );
  cycle_data = {};
 m = 1;       
 XYZ=Joints;
        
        cycles = Segment_sequence(XYZ);
             %[Orientations_New, XYZ] = RemoveDataWithErrors( XYZ, Orientations_New, d );
        % filter out Joints and Orientations in order to remove some
        % outliers
        %VisualizeDCM(XYZ, Orientations_New, j, 'b', Orientations);
        [rkL,rkR,rhL, rhR] = CalculateAnglesfromJoints(XYZ);
        [ rkL,rkR,rhL, rhR ] = filterAngles( rkL,rkR,rhL, rhR, 4 );
        if isempty(cycles)
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
            str = sprintf('No cycles detected. Plot of %s %d ', persons{ii}, j);
            suptitle(str)
            prompt = 'no section were detected, decide if you want to keep it : ';
            Keep = input(prompt);
            Keep
            %pause();
            if (Keep == 1)
                size(rkL)
                prompt = 'and which frames first-last';
                period(1)=input(prompt);
                period(2)=input(prompt);
                cycle_data{m}=[rkL(:,period(1):period(2));rkR(:,period(1):period(2));rhL(:,period(1):period(2)); rhR(:,period(1):period(2))];
                m=m+1;
            end
        hold off;
        close all
        else
            
        figure 
        hold on
        for l=2:size(cycles,2)
            cycle_data{m}=[rkL(:,cycles(l-1):cycles(l));rkR(:,cycles(l-1):cycles(l));rhL(:,cycles(l-1):cycles(l)); rhR(:,cycles(l-1):cycles(l))];
            m=m+1;
            subplot(2,2,1)
            plot(rkL(:,cycles(l-1):cycles(l))');title('Angle Knee Left');
            subplot(2,2,2)
            plot(rkR(:,cycles(l-1):cycles(l))');title('Angle Knee Right');
            subplot(2,2,3);
            plot(rhL(:,cycles(l-1):cycles(l))'); title('Angle Hip Left');
            subplot(2,2,4);
            plot(rhR(:,cycles(l-1):cycles(l))'); title('Angle Hip Right');
            str = sprintf('Plot of Kinect data');
            
            suptitle(str);
            pause();
        end
        hold off;
        close all;
        end
 
        
   