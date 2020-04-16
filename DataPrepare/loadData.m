%%  Description
%   function: loadData
%   path: savePath = 'D:\Tehran University of Medical Science\Proposal\Prosthesis\Bionic Arm Code\EMG-toolbox\EMG-FE-DC\Data\loaddedData';
%   deviceName:TMSi or EMG4RES4 
%   EMGpos: 2
%   returnData
function returnData = loadData(path,deviceName,savePath,EMGpos)
    switch deviceName
        case 'EMG4RES4'
            returnData = EMG4RES4_matread(path,savePath);
            disp('-------- EMG4RES4 Matreading --------');
       %{
        case 'EMG4'
            returnData = EMG4_matread(path,savePath);
            disp('-------- EMG4--------');
        case 'RES4'
            returnData = RES4_matread(path,savePath);
            disp('-------- RES4--------');
            %}
        case 'TMSi'
            data = TMSi_csvread(path,savePath);
            [m n] = size(data); 
            getLetterNum = 3; 
            returnData{1,1} = data{1,1}(1:getLetterNum);
            for cnt1 = 1:n
                returnData{2,1}{1,cnt1} = data{2,cnt1}(100:end,:)';
            end
            disp('-------- TMSi Processing --------');
        case 'Delsys'
            returnData1 = Delsys_csvread(path,savePath); 
            if (nargin == 3)
                disp('--------Delsys-------'); 
                returnData2 = returnData1;
            else
                numChs = length(EMGpos);     
                [m n] = size(returnData1);      %   Delsys  m--row, n--column
                for cnt1 = 1:n
                    returnData2{1,cnt1} =  returnData1{1,cnt1};
                    returnData2{2,cnt1} =  returnData1{2,cnt1}(:,EMGpos);
                end
                disp('-------- Delsys--------');
            end
            [m n] = size(returnData2); 
            getLetterNum = 3;
            returnData{1,1} = returnData2{1,1}(1:getLetterNum);
            for cnt1 = 1:n
                returnData{2,1}{1,cnt1} = returnData2{2,cnt1}(100:end,:)'; 
            end
    end
end