%%  Description:
%   function:
%   TrainData: 
%   Action_Selected: 
%   returnData: 
%                                       sub_x
%                                    ConfusionMatrix
%                                     aveLDATestAcc
%%
function returnData = data_train(allTDCoef,targetClass,nclass)
     %-------------------------------------------------------------------------
     [aveLDATestErr,aveLDATestAcc,ConfusionMatrix,Wg,Cg] = TrainLDA(allTDCoef,targetClass,nclass);
     returnData{1,1} = 'aveLDATestErr';
     returnData{2,1} = aveLDATestErr;
     returnData{3,1} = 'ConfusionMatrix';
     returnData{4,1} = ConfusionMatrix;
     returnData{5,1} = 'aveLDATestAcc';
     returnData{6,1} = aveLDATestAcc;
end