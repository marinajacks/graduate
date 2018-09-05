function Img = f_v2Img(v,z,ImgNums)
n = length(v);
sz = size(ImgNums);
Img = zeros(sz(1),sz(2)*n,sz(3));
for i = 1:n
    if z(i) == 0
        imgSngl = ImgNums(:,:,:,11);
    else
        imgSngl = ImgNums(:,:,:,v(i)+1);
    end
    Img(:,(i-1)*sz(2)+1:i*sz(2),:) = imgSngl;
end; clear i
end