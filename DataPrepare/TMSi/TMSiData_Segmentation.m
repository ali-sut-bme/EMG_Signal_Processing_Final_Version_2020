%%  Description:
%   function: TMSi 
%   data:
%   downFs
%   numAction:
%   Train_Act_Data,Train_Rest_Data:
%%
 function [Train_Act_Data,Train_Rest_Data]=TMSiData_Segmentation(data,downFs,numAction)
    len_data = length(data);
    if numAction == len_data 
       for c=1:len_data     
           Temp_Data=data{c};
           Act_Point = Get_EMG_Action_Point(Temp_Data,downFs);
           len_Act_Point = length(Act_Point)/2; 
           for cnt = 1:len_Act_Point
               Train_Act_Data{cnt,c} = Temp_Data(:,Act_Point(2*cnt-1):Act_Point(2*cnt));
           end
       end
    else   
       for c=2:len_data 
           Temp_Data=data{c};
           Act_Point = Get_EMG_Action_Point(Temp_Data,downFs);
           len_Act_Point = length(Act_Point)/2;      
           for cnt = 1:len_Act_Point
               Train_Act_Data{cnt,c-1} = Temp_Data(:,Act_Point(2*cnt-1):Act_Point(2*cnt));
           end
           Rest_Data=data{1};
           vec = 0:1:len_Act_Point;  
           len_rest = length(Rest_Data);
           vec = round(vec*len_rest/len_Act_Point);
           for cnt = 1:len_Act_Point
               Train_Rest_Data{cnt,c-1} = Rest_Data(:,1+vec(cnt):vec(cnt+1));
           end
        end
    end
 end