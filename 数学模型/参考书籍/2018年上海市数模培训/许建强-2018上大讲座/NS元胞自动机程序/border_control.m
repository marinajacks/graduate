function [new_matrix_cells,new_v]=border_control(matrix_cells,a,b,v,vmax,nCar0)
%边界条件，开口边界，控制车辆出入
%% 出口边界，若头车在道路边界，则以一定该路0.9离去
n=length(matrix_cells);
if a + v(a) > n
    matrix_cells(a)=0;
    v(a)=0;
end
%% 入口边界，泊松分布到达，1s内平均到达车辆数为q，t为1s
nCar = sum(matrix_cells);
if b > vmax
    t=1;
    q=0.25;
    x=1;
    p=(q*t)^x*exp(-q*t)/prod(x); %1s内有1辆车到达的概率
    if nCar < nCar0
        p = 0.9;
    end
    rand('state',sum(100*clock)*rand(1));
    p_2=rand(1);
    if p_2<=p
        m=min(b-vmax,vmax);
        matrix_cells(m)=1;
        v(m)=m;
    end
end
new_matrix_cells=matrix_cells;
new_v=v;
end