%%  Description: Preprocessing EMG Signal
%   function: data_preprocess
%   numAction: 6
%   ChsChoice: 8
%   ActChoice:  
%   returnData:
%                  sub_x
%                action data
%                rest data
function returnData = data_preprocess(data,deviceName,ChsChoice,ActChoice,Fs,numAction)
    switch deviceName
        case 'EMG4RES4'
            downFs = Fs;
            returnData = EMG4RES4data_preprocess(data,ChsChoice,Fs,downFs,numAction);
            disp('-------- EMG4RES4 Data Preprocessing --------');
        case 'TMSi'
            downFs = Fs;
            returnData = TMSidata_preprocess(data,ChsChoice,Fs,downFs,numAction);
            disp('-------- TMSi --------');  
    end
    if isempty(ActChoice)~= 1           
        [m n] = size(returnData);       
        for cnt = 1:n                   
            data{1,cnt} = returnData{1,cnt};
            data{2,cnt} = returnData{2,cnt}(:,ActChoice);   
            data{3,cnt} = returnData{3,cnt}(:,ActChoice);  
        end
        returnData = data;
    end
end