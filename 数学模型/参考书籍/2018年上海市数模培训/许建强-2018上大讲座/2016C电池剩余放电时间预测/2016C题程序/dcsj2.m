clear
x=xlsread('c:\MATLAB7\work\CUMCM2016-C-Appendix-Chinese.xls','¸½¼þ1','a3:j1885');
x(find(isnan(x)==1))=9;
y=[3764-x(:,1);2454-x(:,1);1724-x(:,1);1308-x(:,1);1044-x(:,1);862-x(:,1);730-x(:,1);620-x(:,1);538-x(:,1)];
y(find(y<0))=0;
beta0=[1 0 10];
dl=20:10:100;
x1=[x(:,2),dl(1)*ones(size(x,1),1)];
for i=2:length(dl)
  x1=[x1;x(:,i+1),dl(i)*ones(size(x,1),1)];
end
[beta,R,J]=nlinfit(x1,y,'dcsj1',beta0);