function feats = extractTM3feat(DataSet,framelen,RemoveMean)
% extractTM3feat solute Value Third Moment (TM3)
% DataSet
% RemoveMean
Ntotal=size(DataSet,1);
Nsig=size(DataSet,2);
if(RemoveMean)
    DataSet = DataSet - ones(Ntotal,Nsig)*mean(mean(DataSet));
end
for SigNum=1:Nsig
   clear tm3
   tm3=0;
   range = 1:framelen;
   tm3 = abs((mean((DataSet(range,SigNum)).^3)));
   %tm3 = abs((sum((DataSet(range,SigNum)).^3)));
   feats(1,SigNum)=tm3;
end
end