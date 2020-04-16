function feats = extractRMSfeat(DataSet,framelen,RemoveMean)
%extractRMSfeat Root Mean Square
% DataSet
% RemoveMean
Ntotal=size(DataSet,1);
Nsig=size(DataSet,2);
if(RemoveMean)
    DataSet = DataSet - ones(Ntotal,Nsig)*mean(mean(DataSet));
end
for SigNum=1:Nsig
   clear rms
   rms=0;
   range = 1:framelen;
   rms = sqrt(mean((DataSet(range,SigNum)).^2));
   feats(1,SigNum)=rms;
end
end