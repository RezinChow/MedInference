2022.5.9 update1

请先将depression.m中的数据库地址更改
若要更改为针对变量'anxiety'，请将数据库更换为'database_anxiety'

roc曲线已更新
输出的result为auc值

若要查看因果谱，将depression.m中 '%Read_PNN' 的注释符号'%'删除

切记切换到depression.m再点击运行

2022.5.14 update2


改地址后运行即可（depression.m）

若要查看因果谱，将depression.m中 '%Read_PNN' 的注释符号'%'删除

2022.5.21 update3

更新oversample和SMOTE两种数据增强已经matlab内置的10层神经网络模型
更新ROC/AUC
直接运行DEP，可以跑DD/Linear Regression/10-layer NN的ROC图、AUC、阈值选取以及其他结果指标
若有报错联系我，可能是缺少文件