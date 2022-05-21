m=csvread('D:\college\spring\PRP\nsch_2020_topical_SAS\database_depression.csv',1,0);
i=1;
while i<size(m,1)
%for i=1:17539
    for j=1:29
        if m(i,j)==0
            %m(i,j)=mode(m(:,j));
            m(i,:)=[];
            i=i-1;
            break;
        end
    end
            i=i+1;
end
%writematrix(m,'anxiety_extracted.csv')
m=m';
m=mapminmax(m,-1,1);

Train=m(:,2001:12111);
X1=Train(1:2,:);
X2=Train(4:29,:);
XX=[X1;X2];
Label=Train(3,:);
attr=ones(1,28);
attr(1)=0;
[sample,sampleLabel]=SmoteOverSampling(XX,Label,[-1,1],[1,1],attr,5,'nominal');
writematrix(sample,'SMOTE_X_train.csv')
writematrix(sampleLabel,'SMOTE_Y_train.csv')


sample=sample';
I=[];
for j=1:28
    I(:,j)=sample(:,j);
end
S=[];
S(:,1)=sampleLabel;
X=I';
Y=S';
x=2;
c=100000;
nl=3;% number of layers
%seed=2;
%net=TLCnet(X,Y,nl,seed,c);%training net
net=TLCnet(X,Y,nl,x,c);
plot(net{3});

TESTX=[m(1:2,1:2000);m(4:29,1:2000)];
Y_pre=test_TLCnet(net,TESTX);%test net
%Y_pre=test_TLCnet(net,X);
Y_copy=Y_pre;
b5=Y_copy/2+0.5;
AUCC(a',b5)
thresholdd(a,b5);

B=regress(sampleLabel',sample);
Y_copy2=TESTX'*B;
b6=Y_copy2/2+0.5;
b6=b6';
AUCC(a',b6)
thresholdd(a,b6)

net = patternnet(10);
net = train(net,sample',sampleLabel/2+0.5);
simpleclusterOutputs = sim(net,TESTX);
b9=simpleclusterOutputs;
AUCC(a',b9)
thresholdd(a,b9);


%result=auc(Y_copy,ground_truth)