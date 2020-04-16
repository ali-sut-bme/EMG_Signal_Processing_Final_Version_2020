%%  Description:
%   function:
%   data:
%                                       sub_x
%                                  Train_Act_Feat,
%                                  Train_Act_Label,
%                                  Train_Rest_Feat,
%                                  Train_Rest_Label
%   returnData: 
%                                       sub_x
%                                  Train_Act_Feat,
%                                  Train_Act_Label,
%                                  Train_Rest_Feat,
%                                  Train_Rest_Label
%%
function returnData = linerPCA(data)    
    % data2 = bsxfun(@minus,data,mean(data,1));        
    % data2 = data -  repmat(mean(data,1),size(data,1),1);    
    % score = data2 * coeff;                
    %%
    [coeff,score,latent]= pca(data,'Centered',false);
    theta = 1-0.001;             
    sumLatent = sum(latent);       
    nEigenvalue = size(latent);     
    comSumLatent = 0;
    for i = 1:nEigenvalue
        comSumLatent = comSumLatent + latent(i);
        if comSumLatent/sumLatent > theta
            break;
        end
    end
    returnData = score(:,1:i);
%     figure;
%     biplot(coeff(:,1:2),'scores',score(:,1:2)});    
end