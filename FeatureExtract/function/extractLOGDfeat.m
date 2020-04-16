function feats = extractLOGDfeat(DataSet,framelen,RemoveMean)
%extractLOGDfeat Mean Logarithm Kernel (mLogdkernel)
% DataSet
% RemoveMean
Ntotal=size(DataSet,1);
Nsig=size(DataSet,2);
if(RemoveMean)
    DataSet = DataSet - ones(Ntotal,Nsig)*mean(mean(DataSet));
end
for SigNum=1:Nsig
   clear logd
   logd=0;
   range = 1:framelen;
   logdkernel = abs(DataSet(range,SigNum));
   logd = exp(mean(log(logdkernel)));
   feats(1,SigNum)=logd;
end
end