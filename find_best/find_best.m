% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;
% 读入宿主图像
% hostImg = imread('TI_Lena_color.tiff');
% hostImg = imread('TI_Airplane.tiff');
hostImg = imread('12.png');
% hostImg = imread('TI_Peppers.tiff');
% hostImg = imread('01.png');
% 读入水印图像
wImg=imread('wImg32.png'); 
% 对宿主图像进行分层
r_l=hostImg(:,:,1);
g_l=hostImg(:,:,2);
b_l=hostImg(:,:,3);
% 参数设定
block_size_r=16; % 鲁棒水印的分块大小
best_list=zeros(50,5); % 存储数据
n_level=3;
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%   水印图像预处理   %%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[w_sequence] = dq_prepareWatermark(wImg);
for i=1:50
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % %%%%%%%%%    生成localmap    %%%%%%%%%%
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    G=i; % 鲁棒水印嵌入强度
    [local_map,T,alpha,error] = dq_get_localmap(hostImg,block_size_r,w_sequence,G,n_level);
    while error == 1
        G=G-1;
        [local_map,T,alpha,error] = dq_get_localmap(hostImg,block_size_r,w_sequence,G,n_level);
    end
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % %%%%%%%%%%%      嵌入      %%%%%%%%%%%%
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [watermarkedImg]=dq_embedWatermarking(hostImg,block_size_r,local_map,w_sequence,G,T,n_level);
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % %%%%%%%%%%%      psnr1      %%%%%%%%%%%
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    psnr1=psnr(watermarkedImg,hostImg);
    ssim1=ssim(watermarkedImg,hostImg);
    [avg_nc] = get_avgnc(watermarkedImg,wImg,local_map,block_size_r,T,G,n_level);
    target=-1*(0.3*psnr1/40+0.2*ssim1+0.5*avg_nc);
    target2=0.2*ssim1+0.5*avg_nc+0.3*psnr1/45;
    B=T+G;
    best_list(i,1)=T;
    best_list(i,2)=G;
    best_list(i,3)=psnr1;
    best_list(i,4)=avg_nc;
    best_list(i,5)=target;
    best_list(i,6)=target2;
    best_list(i,7)=ssim1;
end
xlswrite('image_12.xls',best_list);
