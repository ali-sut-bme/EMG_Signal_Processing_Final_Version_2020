%%  Description: TMSi
%   function: EMG returnData
%   mean_threshold
%   coordinates_jump 
function returnData = Get_EMG_Action_Point(data,Fs,mean_threshold,coordinates_jump,PassbandFrequency,StopbandFrequency)
    close all;
    if (nargin == 2)
        mean_threshold = 1.5;
        coordinates_jump = 2000;               
        PassbandFrequency = 20;            
        StopbandFrequency = 30;                 
    end    
    a = diff(data(1,:));                
     figure(1);subplot(311);plot(a);                  
    b = abs(a);
     subplot(312);plot(b);                          
     hold on; 
    c = mean(b);d=c*ones(1,length(a));
     plot(d);                                        
    wf = PassbandFrequency*2/Fs;
    ws = StopbandFrequency*2/Fs;
    lpFilt = designfilt('lowpassfir','PassbandFrequency',wf, ...
         'StopbandFrequency',ws,'PassbandRipple',0.1, ...
         'StopbandAttenuation',65,'DesignMethod','kaiserwin');
    e = filtfilt(lpFilt,b');
     subplot(313);plot(e);ylim([min(e),max(e)]);hold on;plot(d);     
    f=smooth(e,50);
     hold on;plot(f);
    g(:,1) = find(e> mean_threshold*c );  % mean_threshold
    g(2:end,2)=diff(g(:,1));
    h = find(g(:,2)>coordinates_jump);         
     figure(2);
     plot(g(:,2));
                   %len_h == 2
                   %len_h == 3
                   %len_h == 4
    len_h = length(h);
    returnData1 = zeros(1,2*(len_h));
    for cnt = 1:len_h+1
        if cnt==1               
            returnData1(2*cnt-1) = g(1,1);
            returnData1(2*cnt)   = g(h(cnt)-1,1);
        elseif cnt==len_h+1 
            returnData1(2*cnt-1) = g(h(cnt-1),1);
            returnData1(2*cnt)   = g(end,1);
        else  
            returnData1(2*cnt-1) = g(h(cnt-1),1);
            returnData1(2*cnt)   = g(h(cnt)-1,1);
        end
    end
    cnt1 = 0;
    for cnt = 1:len_h+1
        if returnData1(2*cnt)-returnData1(2*cnt-1) > 0.1*Fs    %0.1*Fs
            cnt1 = cnt1 +1;
            returnData(2*cnt1-1) = returnData1(2*cnt-1);
            returnData(2*cnt1) = returnData1(2*cnt);
        end   
    end 
    [m n] = size(data);
    maxdata = max(max(data));
    figure;
    for cnt = 1:m
        plot(data(cnt,:)+(cnt-1)*maxdata);
        hold on;
    end
    len_returnData = length(returnData);
    for cnt = 1: cnt1
        plot([returnData(2*cnt-1),returnData(2*cnt-1)],[-maxdata,(m)*maxdata],'Linewidth',3);
        hold on;
        plot([returnData(2*cnt),returnData(2*cnt)],[-maxdata,(m)*maxdata],'Linewidth',3);
        hold on;
    end
    pause(2);
end