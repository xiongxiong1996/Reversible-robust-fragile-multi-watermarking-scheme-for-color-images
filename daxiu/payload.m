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
% 参数设定
 

% 读入水印图像
wImg=imread('wImg32.png'); 
% 鲁棒水印的分块大小
block_size_r=16; 
% IWT等级
n_level=3;
[w_sequence] = dq_prepareWatermark(wImg);
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%    生成localmap    %%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S=[9 11 11 11 0 11 12 0 13 12 12 13 8 10 10 11 9 5 8 0 8 9 7 7 10 5 5 8];
value=zeros(28,2)
for index_img=1:28
    hostImg = imread([num2str(index_img,'%02d'),'.png']);    %读入图片
    G=S(index_img);
    % G=3; % 鲁棒水印嵌入强度
    [local_map,T,alpha,error] = dq_get_localmap(hostImg,block_size_r,w_sequence,G,n_level);
    value(index_img,1)=T;
    value(index_img,2)=error;
end


toc
disp(['all_time: ',num2str(toc)]);