%% Description
%   csv Path:
%   EMG position
function returnData = EMG4RES4_matread(matPath,saveDataPath,saveDataName)
    if (nargin == 2)
        saveDataName = 'readEMG4RES4data.mat';
    end 
    str=[matPath,'\*.mat'];
    struct1=dir(str);
    lenStruct=length(struct1);
    for i=1:lenStruct
        filename=[matPath,'\',struct1(i,1).name];
        readEMG4RES4data{1,i} = struct1(i,1).name;
        data_buff = load(filename);
        readEMG4RES4data{2,i} = data_buff.save_data_buff;   
    end
    save([saveDataPath,'\',saveDataName],'readEMG4RES4data');
    returnData = readEMG4RES4data;   
end