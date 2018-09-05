% ������ ����ٶ�3��Ԫ�� ���ڱ߽����� ���� ���� �������
clf; clear; close all;
%% ����
Nstep = 60;
n=120; % Ԫ����
nCar0 =20; % ��ʼʱ�̳�����
vmax = 5; % ����ٶ�
if_plot_figure2 = 0; % �Ƿ�ͼ2
nstep_save = 10; % ÿ#������һ��ͼƬ
%% ����
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
z=zeros(1,n); %Ԫ������
z=roadstart(z,nCar0); %��·״̬��ʼ����·��������ֲ�5��
cells=z;
v=speedstart(cells,vmax); %�ٶȳ�ʼ��
x=1; %��¼�ٶȺͳ���λ��
memor_cells=zeros(3600,n);
memor_v=zeros(3600,n);
imh=imshow(cells); %��ʼ��ͼ���ɫ�г�����ɫ��Ԫ��
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
freeze=0; %wait for a freeze�����ᣩ
istep = 0;
while (stop==0 && istep < Nstep)
    istep = istep + 1;
    if(run==1)
        %�߽���������������ĩ�������ƽ�����ʹ�ÿ�������
        a=searchleadcar(cells);
        b=searchlastcar(cells);
        [cells,v]=border_control(cells,a,b,v,vmax,nCar0);
        i=searchleadcar(cells); %�����׳�λ��
        z = cells; % ??
        for j=1:i
            if i-j+1==n
                [z,v]=leadcarupdate(z,v,vmax,i);
                continue;
            else
                %======================================���١����١��������
                if cells(i-j+1)==0; %�жϵ�ǰλ���Ƿ�ǿ�
                    continue;
                else
                    v(i-j+1)=min(v(i-j+1)+1,vmax); %����
                    %=================================����
                    k=searchfrontcar((i-j+1),cells); %����ǰ���׸��ǿ�Ԫ��λ��
                    if k==0; %ȷ����ǰ��֮���Ԫ����
                        d=n-(i-j+1);
                    else d=k-(i-j+1)-1;
                    end
                    v(i-j+1)=min(v(i-j+1),d);
                    %==============================%����
                    %�������
                    new_v=randslow(v(i-j+1));
%                     if new_v == 0
%                         pause
%                     end
                    v(i-j+1)=new_v;
                    %======================================���١����١��������
                    %���³���λ��
                    z(i-j+1)=0;
                    z(i-j+1+new_v)=1;
                    %�����ٶ�
                    v(i-j+1)=0;
                    v(i-j+1+new_v) = new_v; % ??
                end
            end
        end
        cells=z;
        memor_cells(x,:)=cells; %��¼�ٶȺͳ���λ��
        memor_v(x,:)=v;
        x=x+1;
        set(imh,'cdata',cells) %����ͼ��
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