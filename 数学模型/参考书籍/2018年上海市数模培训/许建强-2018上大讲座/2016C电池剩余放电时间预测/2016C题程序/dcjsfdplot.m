clear 
x=xlsread('c:\MATLAB7\work\CUMCM2016-C-Appendix-Chinese.xls','附件1','a3:j1885');
x1=x(:,1);
plot(x(:,2:10),x1)
legend('20A','30A','40A','50A','60A','70A','80A','90A','100A');
xlabel('放电时间/min')
ylabel('电压/v')