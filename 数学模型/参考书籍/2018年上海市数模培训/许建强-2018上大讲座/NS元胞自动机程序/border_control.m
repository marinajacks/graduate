function [new_matrix_cells,new_v]=border_control(matrix_cells,a,b,v,vmax,nCar0)
%�߽����������ڱ߽磬���Ƴ�������
%% ���ڱ߽磬��ͷ���ڵ�·�߽磬����һ����·0.9��ȥ
n=length(matrix_cells);
if a + v(a) > n
    matrix_cells(a)=0;
    v(a)=0;
end
%% ��ڱ߽磬���ɷֲ����1s��ƽ�����ﳵ����Ϊq��tΪ1s
nCar = sum(matrix_cells);
if b > vmax
    t=1;
    q=0.25;
    x=1;
    p=(q*t)^x*exp(-q*t)/prod(x); %1s����1��������ĸ���
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