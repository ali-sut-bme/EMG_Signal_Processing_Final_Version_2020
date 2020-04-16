%%  Description:
%   function:Parameter Setting
%   path:D:\Tehran University of Medical Science\GitHub\EMG_Classify_master
%   EMGpos:2
%   ChsChoice:8
%   ActChoice:6
%   numAction:6
%   win_time
%   Remove_Mean
%   Feat_Kind_Chose
%%
function [path,savePath,EMGpos,ChsChoice,ActChoice,Fs,numAction,win_time,Feat_Kind_Chose] = parameterSetting(deviceName)
    cd ..;
    switch deviceName
        case 'TMSi'
            path = [pwd,'\Data\TMSi'];
            savePath = [pwd,'\Data\loaddedData'];
            EMGpos = 2;                       
            ChsChoice = [];                   
            ActChoice = [];                    
            Fs = 2048;                         
            numAction = 7;                      % numAction
        case 'Delsys'
            path = [pwd,'\Data\Delsys'];
            savePath = [pwd,'\Data\loaddedData'];
            EMGpos = 2;                         
            ChsChoice = [];                   
            ActChoice = [];                     
            Fs = 1926;                          % TMSi 2048; Delsys:1926; RES4&EMG4:1000
            numAction = 7;                      % numAction
        case {'EMG4RES4','EMG4','RES4'}        
            path = [pwd,'\Data\EMG4RES4'];
            savePath = [pwd,'\Data\loaddedData'];
            EMGpos = 2;                         
            ChsChoice = [1 2 5 8];                  
            ActChoice = [];                   
            Fs = 1000;                          % TMSi 2048; Delsys:1926; RES4&EMG4:1000
            numAction = 6;                      % numAction
    end
    win_time = 0.3;                             %  0.3s
    Feat_Kind = {'AACfeat','AR4feat','AR6feat','DASDVfeat','Kurtfeat','Lenfeat','LOGDfeat','Mavfeat',...
        'MLKfeat','RMSfeat','RSTAR6feat','SSIfeat','StatMaxfeat','StatMeanfeat','StatMinfeat',...
        'StatStdfeat','TDFeats','TM3feat','TM4feat','TM5feat','Turnfeat','VARfeat','ZCfeat'};
    Feat_Kind_Chose = Feat_Kind([1 5]);
end