%% %%%%  example %%%%%%%%%
 clear
 clc
%% t
t=[1:100000]./1200;
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

a=m(1:2000,3)-1;
%writematrix(m,'depression_extracted.csv')
m=m';
m=mapminmax(m,-1,1);
m=m';

%% input £¨18£©
I(:,1)=m(:,1);
I(:,2)=m(:,2);
I(:,3)=m(:,4);
I(:,4)=m(:,5);
I(:,5)=m(:,6);
I(:,6)=m(:,7);
I(:,7)=m(:,8);
I(:,8)=m(:,9);
I(:,9)=m(:,10);
I(:,10)=m(:,11);
I(:,11)=m(:,12);
I(:,12)=m(:,13);
I(:,13)=m(:,14);
I(:,14)=m(:,15);
I(:,15)=m(:,16);
I(:,16)=m(:,17);
I(:,17)=m(:,18);
I(:,18)=m(:,19);
I(:,19)=m(:,20);
I(:,20)=m(:,21);
I(:,21)=m(:,22);
I(:,22)=m(:,23);
I(:,23)=m(:,24);
I(:,24)=m(:,25);
I(:,25)=m(:,26);
I(:,26)=m(:,27);
I(:,27)=m(:,28);
I(:,28)=m(:,29);


%% output 
S(:,1)=m(:,3);


X=I';
Y=S';
% 
% for i=1:size(X,1)
% X(i,:)=mapminmax(X(i,:),-1,1);
% end
% for i=1:size(Y,1)
% Y(i,:)=mapminmax(Y(i,:),-1,1);
% end


%%  train
x=2;
c=100000;
nl=3;% number of layers
%seed=2;
%net=TLCnet(X,Y,nl,x,c);%training net
net=TLCnet(X(:,2001:12111),Y(:,2001:12111),nl,x,c);
plot(net{3});
writematrix(X(:,2001:12111),'Original_X_train.csv')
writematrix(Y(:,2001:12111),'Original_Y_train.csv')
writematrix(X(:,1:2000),'X_test.csv')
writematrix(Y(:,1:2000),'Y_test.csv')
%%  test
Y_pre=test_TLCnet(net,X(:,1:2000));%test net
%Y_pre=test_TLCnet(net,X);
Y_copy=Y_pre;
b1=Y_copy/2+0.5;

AUCC(a',b1)
thresholdd(a,b1);


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
X=[ones(size(m,1),1) m(:,1:2) m(:,4:29)];

Y=m(:,3);


B=regress(Y(2001:12111,1),X(2001:12111,:));
Y_copy2=X(1:2000,:)*B;
b2=Y_copy2'-1;

AUCC(a',b2)
thresholdd(a,b2);

net = patternnet(10);
net = train(net,(X(2001:12111,:))',(Y(2001:12111,1))'-1);
simpleclusterOutputs = sim(net,(X(1:2000,:))');
b7=simpleclusterOutputs;
AUCC(a',b7)
thresholdd(a,b7);
%Read_PNN

 



