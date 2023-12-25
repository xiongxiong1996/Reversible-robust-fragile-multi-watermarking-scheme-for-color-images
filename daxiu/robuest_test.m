% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;
tic
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   水印嵌入开始   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%        鲁棒水印嵌入        %%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%     参数设定     %%%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 读入宿主图像
% hostImg = imread('TI_Lena_color.tiff');

% hostImg = imread('TI_Airplane.tiff');
% hostImg = imread('TI_Baboon.tiff');
% hostImg = imread('TI_Peppers.tiff');


% hostImg = imread('A01_1.jpg');
% hostImg = hostImg(513:2400,513:2400,:);
% hostImg = hostImg(432:2480,432:2480,:);

% [hostImg,cmap]=imread('021.gif');
% hostImg = ind2rgb(hostImg,cmap);


% hostImg = imread('TI_Airplane.tiff');
% hostImg = imread('TI_Peppers.tiff');
% 读入水印图像
% wImg=imread('wImg16.png');
% wImg=imread('wImg32.png'); 
% wImg=imread('wImg64.png'); 
% wImg=imread('wImg128.png'); 


% 参数设定
% 读入宿主图像
% hostImg = imread('TI_Airplane.tiff'); 
% hostImg = imread('TI_Lena_color.tiff'); 
% hostImg = imread('TI_Peppers.tiff');
hostImg = imread('TI_Baboon.tiff');
% hostImg = imread('TI_Airplane.tiff'); 
% hostImg = imread('TI_Lena_color.tiff'); 
% 对宿主图像进行分层
r_l=hostImg(:,:,1);
g_l=hostImg(:,:,2);
b_l=hostImg(:,:,3);
% 读入水印图像
wImg=imread('wImg32.png'); 
% 鲁棒水印的分块大小
block_size_r=16; 
% IWT等级
n_level=3;
% block_size_r=8; % 鲁棒水印的分块大小
block_size_f=8; % 脆弱水印的分块大小
bit_len=2; % 脆弱水印多少长度以下嵌入
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%   水印图像预处理   %%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[w_sequence] = dq_prepareWatermark(wImg);
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%    生成localmap    %%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G=5; % 鲁棒水印嵌入强度
% G=3; % 鲁棒水印嵌入强度
[local_map,T,alpha,error] = dq_get_localmap(hostImg,block_size_r,w_sequence,G,n_level);
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%      嵌入      %%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[watermarkedImg]=dq_embedWatermarking(hostImg,block_size_r,local_map,w_sequence,G,T,n_level);
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%      psnr1      %%%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
psnr1=psnr(watermarkedImg,hostImg);
ssim1=ssim(watermarkedImg,hostImg);
% [avg_nc] = get_avgnc(watermarkedImg,wImg,local_map,block_size_r,T,G,n_level);
% target=-1*(0.3*psnr1/40+0.2*ssim1+0.5*avg_nc);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      鲁棒性测试      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
att_list=zeros(76,30);
for i=1:10
    [att] = dq_robustAttact_test(wImg,watermarkedImg,local_map,block_size_r,T,G,n_level);
    att_list(:,3*(i-1)+1)=att(:,1);
    att_list(:,3*(i-1)+2)=att(:,2);
    att_list(:,3*(i-1)+3)=att(:,3); 
end

