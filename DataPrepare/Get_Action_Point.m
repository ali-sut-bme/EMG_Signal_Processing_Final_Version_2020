%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Temp_Data
%   My_Diff  RemoveBadData
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Act_Point=Get_Action_Point(Temp_Data,Sampling_Rate,numAction)
 %-- Comp_Act_Point -----
        n=length(Temp_Data);
        diff_Temp_Data(1:n)=0;
        diff_Temp_Data(2:n)=diff(Temp_Data(end,:));
        j=1;
        Comp_Act_Point(1)=1;                                                
        i=1;
        while(i<=n)
            if(abs(diff_Temp_Data(i))>0.05)
                j=j+1;
                Comp_Act_Point(j)=i;        
                i=i+2;
            else
                i=i+1;
            end
        end
        j=j+1; 
        Comp_Act_Point(j)=n;        % Comp_Act_Point
  %% Act_Point
            diff_Temp_Data=[];  
            diff_Temp_Data(1:n)=0;
            m = size(Temp_Data,1);
            for i=1:m-2
                a=Temp_Data(i,:);
                a=smooth(a,25);
                a=My_Diff(a);
                a=smooth(a,25);
                diff_Temp_Data=diff_Temp_Data+abs(a');
            end
            diff_Temp_Data=smooth(diff_Temp_Data,25);         
            temp=diff_Temp_Data;
            Act_Threshold=1.8*mean(temp);                                  
            diff_Temp_Data=diff_Temp_Data>Act_Threshold;                   
            for i=1:numAction
                Temp_Act_Data=[];
                Temp_Act_Data=diff_Temp_Data(Comp_Act_Point(2*i):Comp_Act_Point(2*i+1));
                t=0;
                for ii=1:length(Temp_Act_Data)
                    if(Temp_Act_Data(ii)>0.5)
                        t=ii;
                        break;
                    end
                end
                if(t==0)
                    disp('************************************')
                    disp('Act_Threshold')
                    t=floor(Sampling_Rate*0.35);
                    %return;                       
                end
                Act_Point(i*2)=t+Comp_Act_Point(2*i)-1;
                Temp_Act_Data=[];
                Temp_Act_Data=diff_Temp_Data(Comp_Act_Point(2*i+1):Comp_Act_Point(2*i+2));
                t=0;
                for ii=1:length(Temp_Act_Data)
                    if(Temp_Act_Data(ii)>0.5)
                        t=ii;
                        break;
                    end
                end
                if(t==0)
                    disp('************************************')
                    disp('Act_Threshold')
                     %return;
                     t=floor(Sampling_Rate*0.2);
                end                
                Act_Point(i*2+1)=t+Comp_Act_Point(2*i+1)-1;
            end
            Act_Point(1)=1;
            Act_Point(numAction*2+1)=Comp_Act_Point(numAction*2+1);
end