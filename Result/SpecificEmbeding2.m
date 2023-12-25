hostImg = imread('05.png'); 
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
w_sequence1=w_sequence(1,1:512);
w_sequence2=w_sequence(1,513:1024);

% %%%%%%%%%%%%%%%%%嵌入w_sequence2%%%%%%%%%
% %%%%%%%%%%%%%%%%%嵌入w_sequence2%%%%%%%%%
% %%%%%%%%%%%%%%%%%嵌入w_sequence2%%%%%%%%%

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%    生成localmap    %%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
G=10; % 鲁棒水印嵌入强度
[local_map2,T,alpha,error] = dq_sp_get_localmap(g_l,block_size_r,w_sequence2,G,n_level)
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%      嵌入      %%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[watermarkedImg2]=dq_sp_embedWatermarking(g_l,block_size_r,local_map2,w_sequence2,G,T,n_level);
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%      psnr1      %%%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
psnr1_g=psnr(watermarkedImg2,g_l);
ssim1_g=ssim(watermarkedImg2,g_l);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  提取
% %%%%%%%%%%%%%%%%%%%%
[exw_sequence2] = dq_sp_exactedWatermarking1(watermarkedImg2,local_map2,block_size_r,T,G,n_level);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 恢复
% %%%%%%%%%%%%%%%%%%%%%%%%%%
[recoveredImg] = dq_sp_robustWatermarkRecover(local_map2,exw_sequence2,watermarkedImg2,block_size_r,T,G,n_level);
psnr2=psnr(recoveredImg,g_l);