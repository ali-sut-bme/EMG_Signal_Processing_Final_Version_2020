%%  Description:
%   function: TMSi
%   data:
%   ChsChoice
%   fs:
%   downFs: 
%   numAction:
%   returnData:
%   (cell),numAction,numAction
function returnData = TMSidata_preprocess(data,ChsChoice,fs,downFs,numAction)
    [m n] = size(data);    
    for cnt1 = 1:n        
        [m2 n2] = size(data{2,cnt1});                        
        Pre_Data{1,cnt1} = data{1,cnt1};         
        for cnt2 = 1:n2
           Pre_Data{2,cnt1}{1,cnt2} = TMSiData_Pre_Proc(data{2,cnt1}{1,cnt2},fs,ChsChoice,downFs);      
        end   
    end
    [m n] = size(Pre_Data);     
    dataSeg = cell(3,n);
    for cnt1 = 1:n         
        dataSeg{1,cnt1} = Pre_Data{1,cnt1};
        [dataSeg{2,cnt1},dataSeg{3,cnt1}] = TMSiData_Segmentation(Pre_Data{2,cnt1},downFs,numAction);
    end
    returnData = dataSeg;
end