clear
x=xlsread('c:\MATLAB7\work\CUMCM2016-C-Appendix-Chinese.xls','¸½¼þ2','a3:e150');
x1=x(:,1);
y=x(:,5);
x3=[x(:,2:4),x(:,2).^2,x(:,3).^2,x(:,4).^2];
stepwise(x3,y);%Öð²½»Ø¹é