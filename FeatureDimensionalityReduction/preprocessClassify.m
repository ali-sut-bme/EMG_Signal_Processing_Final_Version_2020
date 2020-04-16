%%  Description:
%   function:
%   TrainData:
%   Action_Selected:
%   returnData: 
%%
function [allTDCoef,targetClass,Real_Class] = preprocessClassify(data)
    allTDCoef=[];
    targetClass=[];
    Action_Selected = size(data{2,1},2);
    j=1;
    for i=1:Action_Selected                              
        allTDCoef=[allTDCoef;data{2,1}{1,i}']; 
        L=length(data{2,1}{1,i});
        Train_Act_Label_Slected{2,1}{1,i}(1:L)=j;
        targetClass=[targetClass Train_Act_Label_Slected{2,1}{1,i}]; 
        j=j+1;
    end
    for i=1:Action_Selected                        
        allTDCoef=[allTDCoef;data{4,1}{1,i}'];
        L=length(data{4,1}{1,i});
        Train_Rest_Label_Slected{4,1}{1,i}(1:L)=j;
        targetClass=[targetClass Train_Rest_Label_Slected{4,1}{1,i}];
    end
    Real_Class = j;
end