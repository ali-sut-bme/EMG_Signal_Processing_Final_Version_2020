function feats = extractMavfeat(DataSet,frameLen,RemoveMean)
%extractMavfeat   �mav
Ntotal = size(DataSet,1);  % winSize==frameLen
Nsig = size(DataSet,2);  % nWin
if(RemoveMean)
    DataSet = DataSet - ones(Ntotal,Nsig)*mean(mean(DataSet));
end
for SigNum=1:Nsig
    clear mav
    range=1:frameLen;
    mav=mean(abs(DataSet(range,SigNum)));
    feats(1,SigNum)=mav;
end