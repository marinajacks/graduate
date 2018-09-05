function str = f_v2str(v,z)
n = length(v);
str = '';
for i = 1:n
    if z(i) == 0
        str = [str,'o'];
    else
        str = [str,num2str(v(i))];
    end
end; clear i
end