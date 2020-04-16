%%  Description:
%   function: EMG4RES4
%   data:
%   downFs
%   numAction:
%   Train_Act_Data,Train_Rest_Data:
%%
 function [Train_Act_Data,Train_Rest_Data]=EMG4RES4Data_Segmentation(data,downFs,numAction,ChsChoice)
    if isempty(ChsChoice)
        ChsChoice = 1:1:8;
    end
    len_data = length(data);
    Train_Act_Data=cell(len_data,numAction);
    Train_Rest_Data=cell(len_data,numAction);         
    for c=1: len_data      
       Temp_Data=data{c};
       Act_Point=EMG4RES4Get_Action_Point(Temp_Data,downFs,numAction);          
       for i=1:numAction
%           Act_Num=Temp_Data(end,Act_Point(2*i)+1000);        
          Act_Num = i;
          Train_Act_Data{c,Act_Num}=[Train_Act_Data{c,Act_Num},Temp_Data(ChsChoice,Act_Point(2*i):Act_Point(2*i+1))]; %动作数据
          Train_Rest_Data{c,Act_Num}=[Train_Rest_Data{c,Act_Num},Temp_Data(ChsChoice,Act_Point(2*i-1):Act_Point(2*i))];%休息数据
       end
    end
 end