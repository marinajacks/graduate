function yhat=dcsj1(beta,x)
yhat=beta(3)*(x(:,1)-9).^beta(1).*x(:,2).^beta(2);