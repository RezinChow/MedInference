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

for i=1:12111-2001+1
    if Train(3,i)==-1
        Train=[Train,Train(:,i)];
        Train=[Train,Train(:,i)];
        Train=[Train,Train(:,i)];
        Train=[Train,Train(:,i)];
        Train=[Train,Train(:,i)];
        Train=[Train,Train(:,i)];
    end
end

X1=Train(1:2,:);
X2=Train(4:29,:);

XX=[X1;X2];
Label=Train(3,:);

writematrix(XX,'Oversample_X_train.csv')
writematrix(Label,'Oversample_Y_train.csv')

%attr=ones(1,28);
%attr(1)=0;
%[sample,sampleLabel]=SmoteOverSampling(XX,Label,[-1,1],[1,1],attr,5,'nominal');
%sample=sample';
I=[];
XX=XX';
for j=1:28
    I(:,j)=XX(:,j);
end
S=[];
S(:,1)=Label';
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
b3=Y_copy/2+0.5;
AUCC(a',b3)
thresholdd(a,b3);

Y=m(3,:);
B=regress(Label',XX);
Y_copy2=TESTX'*B;
b4=Y_copy2';

AUCC(a',b4)
thresholdd(a,b4);

net = patternnet(10);
net = train(net,XX',Label/2+0.5);
simpleclusterOutputs = sim(net,TESTX);
b8=simpleclusterOutputs;
AUCC(a',b8)
thresholdd(a,b8);
%    result=auc(Y_copy,ground_truth)