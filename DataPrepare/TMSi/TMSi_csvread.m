%% Description
%   csvPath:
%   csvRowStart: csv
%   csvColStart: csv
%   saveDataPath
%   saveDataName
%   returnData: 
function returnData = TMSi_csvread(csvPath,saveDataPath,saveDataName,csvRowStart,csvColStart)
    if (nargin == 2)
        csvRowStart = 1;       
        csvColStart = 2;
        saveDataName = 'readTMSidata.mat';
    end
    str=[csvPath,'\*.csv'];
    struct1=dir(str);
    lenStruct=length(struct1);
    for i=1:lenStruct
        filename=[csvPath,'\',struct1(i,1).name];
        readTMSidata{1,i} = struct1(i,1).name;
        readTMSidata{2,i} = csvread(filename,csvRowStart,csvColStart);   
    end
    save([saveDataPath,'\',saveDataName],'readTMSidata');
    returnData = readTMSidata;
end