function thresholdd(a,b)
[tpr,fpr,thresholds] =roc(a',b);
RightIndex=(tpr+(1-fpr)-1);
[~,index]=max(RightIndex);
%
RightIndexVal=RightIndex(index(1));
tpr_val=tpr(index(1));
fpr_val=fpr(index(1));
thresholds_val=thresholds(index(1))
disp(['平均准确率： ',num2str((RightIndexVal+1)*0.5)]);
disp(['最佳正确率： ',num2str(tpr_val)])
disp(['最佳错误率： ',num2str(fpr_val)])