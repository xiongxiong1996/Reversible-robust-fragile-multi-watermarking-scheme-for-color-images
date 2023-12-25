% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [exw_sequence] = dq_exactedWatermarking_all(watermarkedImg,local_map,block_size,T,G,n_level)
% DQ_EXACTEDWATERMARKING_ALL Summary of this function goes here
% 该函数使用三种方法进行水印的提取并生成一个提取出的水印序列
%   Detailed explanation goes here
% 输入：watermarkedImg----------水印图像
% 输入：local_map----------鲁棒水印嵌入图
% 输入：block_size----------分块大小
% 输入：T,G,----------T:最大误差和，G:阈值
% 输出：exw_sequence----------提取的水印序列
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[exw_sequence1]=dq_exactedWatermarking1(watermarkedImg,local_map,block_size,T,G,n_level); % 提取水印序列方法1
[exw_sequence2]=dq_exactedWatermarking2(watermarkedImg,local_map,block_size,T,G,n_level); % 提取水印序列方法2
[exw_sequence3]=dq_exactedWatermarking3(watermarkedImg,local_map,block_size,T,G,n_level); % 提取水印序列方法3


[r l]=size(exw_sequence1);
exw_sequence=zeros(1,l);

for i=1:l
	if exw_sequence1(i)==exw_sequence2(i)
		if exw_sequence1(i)==exw_sequence3(i)
			w=exw_sequence1(i);
		else
			w=exw_sequence1(i);
		end
	else
		if exw_sequence2(i)==exw_sequence3(i)
			w=exw_sequence2(i);
		end
		if exw_sequence1(i)==exw_sequence3(i)
			w=exw_sequence3(i);
		end
	end
	exw_sequence(i)=w;
end
end

