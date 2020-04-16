function  feats = extractAR4feat(DataSet,frameLen,RemoveMean)
Ntotal = size(DataSet,1);   
Nsig = size(DataSet,2);   
if(RemoveMean)
    DataSet = DataSet - ones(Ntotal,Nsig)*mean(mean(DataSet));
end
for SigNum=1:Nsig
    clear ar
    range=1:frameLen;
    ar=arburg(DataSet(range,SigNum),4);
    feats(:,SigNum)=ar(2:5); 
end