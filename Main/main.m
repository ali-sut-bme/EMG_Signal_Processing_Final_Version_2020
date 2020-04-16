%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main.m: Main code for EMG Signal Processing 
% author:Ali Abedi
% Master of Biomedical Engineering From Tehran University of Medical Science
% Biomedical Engineering Department,April 2020.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Start
clear;clc;
close all;
%% Step 1:  add path 
mainPathA = which('main.m');      
cd(mainPathA(1:end-7));             
cd ..;addpath(genpath(pwd));      
cd(mainPathA(1:end-7));
%% Step  2:  load data
%  path('File path')  deviceName('TMSi or EMG4RES4')  savePath(load); 
%  TMSi & EMG4RES4
%  standard_data_format.mat;
deviceName1 = 'TMSi';
deviceName2 = 'EMG4RES4';
%% --------------------------------------------------------------
deviceName = deviceName1;       % choise device
[path,savePath,EMGpos,ChsChoice,ActChoice,Fs,numAction,win_time,Feat_Kind_Chose] = parameterSetting(deviceName);
returnData2 = loadData(path,deviceName,savePath,EMGpos);
%% Step 3 : Data_Preprocessing
returnData3 = data_preprocess(returnData2,deviceName,ChsChoice,ActChoice,Fs,numAction);
%% Step 4 : win_time,Feat_Kind,Remove_Mean,win_inc
win=floor(Fs*win_time);                                      
win_inc=floor(win/2);                                         
if isempty(ActChoice)
    nclass = numAction+1; % numAction
else
    nclass = length(ActChoice) + 1; % ActChoice
end
Remove_Mean =0;
returnData4 = data_feature(returnData3,win,win_inc,nclass,Feat_Kind_Chose,Remove_Mean);
%% Step 5 && Step 6
subNum = size(returnData4,2);
for cntSubNum = 1:subNum       
    data = returnData4(:,cntSubNum);                               
    [allTDCoef,targetClass,Real_Class] = preprocessClassify(data); 
    %% Step 5 :
      allTDCoef = linerPCA(allTDCoef);
    %% Step 6 : Action_Selected
    returnData5 = data_train(allTDCoef,targetClass,nclass);
    %% Step 6 : returnData6
    returnData6{1,cntSubNum} = returnData4{1, cntSubNum}(27:end-4);
    returnData6{2,cntSubNum} = 'FeatureChoice';
    returnData6{3,cntSubNum} = Feat_Kind_Chose;
    returnData6{4,cntSubNum} = 'ChannelChoice';
    returnData6{5,cntSubNum} = ChsChoice;
    returnData6{6,cntSubNum} = 'ActionChoice';
    returnData6{7,cntSubNum} = ActChoice;
    returnData6(8:13,cntSubNum)=returnData5;
end
%% Finally 
 [m n] = size(returnData5);
 Average_Recognition_Rate = 0;
 for i = 1:n
     a = returnData5{5,i};
     Average_Recognition_Rate = Average_Recognition_Rate +a;
 end
 Average_Recognition_Rate = Average_Recognition_Rate/n; 