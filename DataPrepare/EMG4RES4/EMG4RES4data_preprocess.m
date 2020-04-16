%%  Description:
%   function: EMG4RES4
%   data:EMG Raw Signal
%   Chs-Choice:8
%   fs:1000
%   downFs: 1000
%   numAction: 6
%   returnData:
%               (cell) numAction
%                 sub_x
function returnData = EMG4RES4data_preprocess(data,ChsChoice,Fs,downFs,numAction)
    [m n] = size(data);     
    for cnt1 = 1:n          
        [m2 n2] = size(data{2,cnt1});                          
        Pre_Data{1,cnt1} = data{1,cnt1};                 
        for cnt2 = 1:n2
           if isempty(data{2,cnt1}{1,cnt2}) ~=1
                Pre_Data{2,cnt1}{1,cnt2} = EMG4RES4Data_Pre_Proc(data{2,cnt1}{1,cnt2},Fs,downFs);  
           end
        end   
    end
    [m n] = size(Pre_Data);    
    dataSeg = cell(3,n);
    for cnt1 = 1:n        
        dataSeg{1,cnt1} = Pre_Data{1,cnt1};
        [dataSeg{2,cnt1},dataSeg{3,cnt1}] = EMG4RES4Data_Segmentation(Pre_Data{2,cnt1},downFs,numAction,ChsChoice); 
    end
    returnData = dataSeg;
end