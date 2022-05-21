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
B=regress(Y(1:10000,1),X(1:10000,:));
Y_copy=X(10001:12111,:)*B;
%for i=1:1
%    figure
%   %plot(Y(i,:));
%    plot(m(1:200,3))
%    hold on;
%    plot(Y_copy(1:200));
%end

ground_truth=[];
    for i=1:size(Y_copy,1)
        if Y_copy(i)>=1.8
            Y_blank(i)=2;
        else 
            Y_blank(i)=1;
        end
          if Y_blank(i)==Y(i)
       %     sum(k)=sum(k)+1;
            ground_truth(i)=1;
        else
            ground_truth(i)=0;
        end
    end
    result=auc(Y_copy,ground_truth)