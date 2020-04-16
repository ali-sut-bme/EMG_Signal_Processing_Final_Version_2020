%%  Description:
%   function: EMG4RES4
%   Sampling_Rate
%   downFs:  Sampling_Rate
%   returnData
function Pre_Data=EMG4RES4Data_Pre_Proc(data,Sampling_Rate,downFs)
    if (nargin == 2)                        
        downFs = Sampling_Rate;     
    end 
    fs2 = 20;   fp2 = 30;           
    fp1 = 400;  fs1 = 500;         %pi*rad/s
    ws2=fs2*2/Sampling_Rate; wp2=fp2*2/Sampling_Rate;
    wp1=fp1*2/Sampling_Rate; ws1=fs1*2/Sampling_Rate;
    wc2=(ws2+wp2)/2; wc1=(ws1+wp1)/2;
    wp=[wc2,wc1];
    n_filter = 200;
    b=fir1(n_filter,wp,'bandpass');     
    freqz(b,1,512);                     
    newdata=filter(b,1,data(1:4,:)')';                
    for i = 5:8                                  
        Temp_Data1 = RemoveBadData(data(i,:))+16;           
        newdata(i,:)=smooth(Temp_Data1,15);
    end
    colStart = n_filter/2+1;
    newdata = newdata(:,colStart:end);
    data = data(:,colStart:end);
    len_ch = 8;
    for i=1:len_ch
        Temp_Data(i,:) = newdata(i,:);  
    end
    Temp1_Data=(resample(Temp_Data',downFs,Sampling_Rate))';  
    Temp1_Data(len_ch+1,:)=downsample(data(9,:),floor(Sampling_Rate/downFs)); 
    Temp1_Data(len_ch+2,:)=downsample(data(10,:),floor(Sampling_Rate/downFs));           
    Pre_Data=Temp1_Data;
end