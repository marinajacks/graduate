clear 
x=xlsread('c:\MATLAB7\work\CUMCM2016-C-Appendix-Chinese.xls','附件1','a3:j1885');
x1=x(:,1);
y=[3764-x(:,1),2454-x(:,1),1724-x(:,1),1308-x(:,1),1044-x(:,1),862-x(:,1),730-x(:,1),620-x(:,1),538-x(:,1)];
y(find(y<0))=0;
plot(x(:,2:10),y);
legend('20A','30A','40A','50A','60A','70A','80A','90A','100A');
xlabel('放电时间/min')
ylabel('电压/v')