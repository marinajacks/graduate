function [new_matrix_cells,new_v]=leadcarupdate(matrix_cells,v,vmax,i)
%第一辆车更新规则
n=length(matrix_cells);
if v(n)~=0
    matrix_cells(n)=0;
    v(n)=0;
end
if min(v(i)+1,vmax)>n-i
    matrix_cells(i)=0;
    v(i)=0;
else
    v(i)=randslow(v(i));
    newv=v(i)
    matrix_cells(i)=0;
    matrix_cells(i+newv)=1;
    v(i)=0;
    v(i+newv)=newv;
end
new_matrix_cells=matrix_cells;
new_v=v;
end