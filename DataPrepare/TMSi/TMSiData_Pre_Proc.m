%%  Description:
%   function: TMSi
%   data:
%   Sampling_Rate
%   ChsChoice
%   downFs: »Sampling_Rate
%   returnData:
function Pre_Data=TMSiData_Pre_Proc(data,Sampling_Rate,ChsChoice,downFs)
    if (nargin == 3)                        
        downFs = Sampling_Rate;   
    end
    if isempty(ChsChoice)==1                            
        ChsChoice = 1:1:size(data,1);
    end  
    Temp_Data  = data(ChsChoice,:);  
    fs2 = 20;   fp2 = 30;          
    fp1 = 400;  fs1 = 500;
    ws2=fs2*2/Sampling_Rate; wp2=fp2*2/Sampling_Rate;
    wp1=fp1*2/Sampling_Rate; ws1=fs1*2/Sampling_Rate;
    wc2=(ws2+wp2)/2; wc1=(ws1+wp1)/2;
    wp=[wc2,wc1];
    n_filter = 200;                                   % 200 n_filter/2
    b=fir1(n_filter,wp,'bandpass');     
    freqz(b,1,512);    
    newdata=filter(b,1,Temp_Data(:,:)')';      
    colStart = n_filter/2+1;   
    newdata = newdata(:,colStart:end);
  %% 
    Temp1_Data=(resample(newdata',downFs,Sampling_Rate))';           
    Pre_Data=Temp1_Data;
end