% 单车道 最大速度3个元胞 开口边界条件 加速 减速 随机慢化
clf; clear; close all;
%% 参数
Nstep = 60;
n=120; % 元胞数
nCar0 =20; % 初始时刻车辆数
vmax = 5; % 最大速度
if_plot_figure2 = 0; % 是否画图2
nstep_save = 10; % 每#步保存一次图片
%% 界面
s_Gui;
Img = imread('img\9.png');
sz1Num = size(Img);
ImgNums = zeros(sz1Num(1),sz1Num(2),sz1Num(3),11);
for i = 0:10
    if i == 10
        imgSngl = imread('img\dotBig.png');
    else
        imgSngl = imread(['img\',num2str(i),'.png']);
    end
    ImgNums(:,:,:,i+1) = imgSngl;
end; clear i imgSngl
%% CA setup
z=zeros(1,n); %元胞个数
z=roadstart(z,nCar0); %道路状态初始化，路段上随机分布5辆
cells=z;
v=speedstart(cells,vmax); %速度初始化
x=1; %记录速度和车辆位置
memor_cells=zeros(3600,n);
memor_v=zeros(3600,n);
imh=imshow(cells); %初始化图像白色有车，黑色空元胞
set(imh, 'erasemode', 'none')
axis equal
axis tight
%%
ImgAll = ones((Nstep+1)*sz1Num(1),n*sz1Num(2),sz1Num(3));
ImgThisTime = f_v2Img(v,z,ImgNums);
if if_plot_figure2
    figure(2)
    imshow(ImgThisTime);
end
% text(0,0,f_v2str(v,z));
ImgAll(1:sz1Num(1),:,:) = ImgThisTime;
figure(1)
%%
stop=0; %wait for a quit button push
run=1; %wait for a draw
freeze=0; %wait for a freeze（冻结）
istep = 0;
while (stop==0 && istep < Nstep)
    istep = istep + 1;
    if(run==1)
        %边界条件处理，搜素首末车，控制进出，使用开口条件
        a=searchleadcar(cells);
        b=searchlastcar(cells);
        [cells,v]=border_control(cells,a,b,v,vmax,nCar0);
        i=searchleadcar(cells); %搜索首车位置
        z = cells; % ??
        for j=1:i
            if i-j+1==n
                [z,v]=leadcarupdate(z,v,vmax,i);
                continue;
            else
                %======================================加速、减速、随机慢化
                if cells(i-j+1)==0; %判断当前位置是否非空
                    continue;
                else
                    v(i-j+1)=min(v(i-j+1)+1,vmax); %加速
                    %=================================减速
                    k=searchfrontcar((i-j+1),cells); %搜素前方首个非空元胞位置
                    if k==0; %确定于前车之间的元胞数
                        d=n-(i-j+1);
                    else d=k-(i-j+1)-1;
                    end
                    v(i-j+1)=min(v(i-j+1),d);
                    %==============================%减速
                    %随机慢化
                    new_v=randslow(v(i-j+1));
%                     if new_v == 0
%                         pause
%                     end
                    v(i-j+1)=new_v;
                    %======================================加速、减速、随机慢化
                    %更新车辆位置
                    z(i-j+1)=0;
                    z(i-j+1+new_v)=1;
                    %更新速度
                    v(i-j+1)=0;
                    v(i-j+1+new_v) = new_v; % ??
                end
            end
        end
        cells=z;
        memor_cells(x,:)=cells; %记录速度和车辆位置
        memor_v(x,:)=v;
        x=x+1;
        set(imh,'cdata',cells) %更新图像
        %update the step number diaplay
        pause(0.2);
        stepnumber = 1 + str2num(get(number,'string'));
        set(number,'string',num2str(stepnumber))
    end
    if (freeze==1)
        run = 0;
        freeze = 0;
    end
    drawnow
    ImgThisTime = f_v2Img(v,z,ImgNums);
%     text(0,0,num2str(v));
    ImgAll(istep*sz1Num(1)+1:(istep+1)*sz1Num(1),:,:) = ImgThisTime;
    if if_plot_figure2 || istep == Nstep
        figure(2)
        imshow(ImgAll(1:(istep+1)*sz1Num(1),:,:));
        xlabel('--Space->'); ylabel('<-Time--')
        set(gca,'xtick',0:20*sz1Num(2):120*sz1Num(2),'xticklabel',0:20:120)
        set(gca,'ytick',0:10*sz1Num(1):istep*sz1Num(1),'yticklabel',0:10:istep)
        axis on
    end
end
saveas(gcf,'result\ImgAll.pdf')
figure(1)
imwrite(ImgAll,'result\ImgAll.png');