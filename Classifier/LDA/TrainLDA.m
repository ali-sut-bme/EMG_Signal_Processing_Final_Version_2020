function[aveLDATestErr,aveLDATestAcc,ConfusionMatrix,Wg,Cg ]= TrainLDA(allTDCoef,targetClass,nclass)
%% Computation
% using 5-fold cross validation
kk=5;
indices = crossvalind('Kfold',size(allTDCoef,1),kk);
TestError = 0;
ConfusionMatrix = zeros(nclass,nclass);
for i = 1:kk
    test = (indices == i); train = ~test;    
    Curcl_tr = allTDCoef(train,:);
    Curcl_te = allTDCoef(test,:);
    targetcl_tr = targetClass(train);
    targetcl_te = targetClass(test);
    % Compute the LDA decisions and accuracy.
    [PeTrain,PeTest,TrainPredict,LDAPredict,Wg,Cg] = lda(Curcl_tr',Curcl_te',targetcl_tr,targetcl_te);
    normLDATestErr = (1-PeTest)*100; % Normal LDA Test Error
    nValidClass = max(targetcl_te); 
    confusion = zeros(nValidClass); 
    for targetclass = 1:nValidClass 
        idx = find(targetcl_te==targetclass);   
        ndecision(targetclass) = length(idx); 
        for predictedClass = 1:nValidClass     
            nMatch(targetclass,predictedClass) = sum(LDAPredict(idx)==predictedClass);
            percent(targetclass,predictedClass) = nMatch(targetclass,predictedClass)./ndecision(targetclass);
        end
    end
    TestError = TestError + normLDATestErr;
    ConfusionMatrix = ConfusionMatrix + percent;
end
aveLDATestErr = TestError./kk;
aveLDATestAcc = 100-TestError./kk;
ConfusionMatrix = ConfusionMatrix./kk;
ConfusionMatrix = ConfusionMatrix';
fprintf('\nAverage Classification Error = %5.2f',aveLDATestErr);
fprintf('\nAverage Classification Accuracy = %5.2f',aveLDATestAcc);
fprintf('\n Confusion Matrix \n')
disp('ConfusionMatrix=')
disp(ConfusionMatrix)