% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [att] = dq_robustAttact_test(wImg,watermarkedImg,local_map,block_size,T,G,n_level)
% DQ_ROBUSTATTACT_TEST Summary of this function goes here
% 鲁棒水印攻击测试，测试各种鲁棒攻击
%   Detailed explanation goes here
% 输入：wImg----------水印图像
% 输入：watermarkedImg----------嵌入水印后的图像（用于提取水印）
% 输入：local_map----------鲁棒水印嵌入图
% 输入：block_size----------分块大小
% 输入：T,G,----------T:最大误差和，G:阈值
% 输出：att----------攻击后提取效果列表
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

thresh =graythresh(wImg);     % 自动确定二值化阈值
wImg = im2bw(wImg,thresh);   % 对图像二值化
ow_Img=wImg;
att_n=0;% 44
att=zeros(76,3); % 用于存放攻击后图像的鲁棒性信息
for i=1:25  % 77
		% [attacked_img,att_name] = attacks(watermarkedImg,att_n); % 调用攻击函数
		[attacked_img,att_name] = attacks_filter(watermarkedImg,att_n); % 调用攻击函数
        % [exw_sequence]= dq_exactedWatermarking1(attacked_img,local_map,block_size,T,G); % 对攻击后的图像进行水印提取
		[exw_sequence] = dq_exactedWatermarking_all(attacked_img,local_map,block_size,T,G,n_level);
		[exwImg] = dq_get_wImg(exw_sequence);
		% ber = qyh_getBER(w_sequence,exw_sequence); % 误码率计算
		ber=d_get_ber(ow_Img,exwImg);
		nc_num=d_get_nc(ow_Img,exwImg);
		% psnr_w=psnr(ow_Img,extract_w);
		% figure(i);
		% imshow(exwImg);
		att(i,1)=i-1;
    att(i,2)=ber;
    att(i,3)=nc_num;
		att_n=att_n+1;
end
end

