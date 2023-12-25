% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [avg_nc] = get_avgnc(watermarked_Img,ow_Img,local_map,block_size,T,G,n_level)
% 本函数用于测试水印,获取平均NC值。平均NC值为
% 6	Lossy JPEG (QF = 40%)
% 10	Histogram equalization
% 14	Gaussian noise ( 0.5%)
% 20	Salt-pepper noise (0.5%)
% 26	Speckle noise (1%)
% 29	Average filter 3X3
% 34	Median filter 3X3
% 39	Motion filter 3X3
% 44	Gaussian LPF 3X3
% 48	Crop 25% (1)

% 攻击的平均值
%   Detailed explanation goes here
thresh =graythresh(ow_Img);     % 自动确定二值化阈值
ow_Img = im2bw(ow_Img,thresh);   % 对图像二值化
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_att=10;
att=zeros(num_att,2); % 用于存放攻击后图像的鲁棒性信息
att_array=[6,10,14,20,26,29,34,39,44,48];
att_n=1;
for i=1:num_att
	[attacked_img,~] = attacks(watermarked_Img,att_array(att_n)); % 调用攻击函数
	[exw_sequence] = dq_exactedWatermarking_all(attacked_img,local_map,block_size,T,G,n_level);
	[exwImg] = dq_get_wImg(exw_sequence);
	nc_num=d_get_nc(ow_Img,exwImg);
	att(i,1)=i-1;
	att(i,2)=nc_num;
	att_n=att_n+1;
end
sum_nc=0;
for j=1:num_att
	sum_nc=sum_nc+att(j,2);
end
avg_nc=sum_nc/num_att;
end
