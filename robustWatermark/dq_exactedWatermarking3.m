function [exw_sequence] = dq_exactedWatermarking3(watermarkedImg,local_map,block_size,T,G,n_level)
% DQ_EXACTEDWATERMARKING1 Summary of this function goes here
% 该函数进行水印序列的提取。
%   Detailed explanation goes here
% 输入：watermarkedImg----------水印图像
% 输入：local_map----------鲁棒水印嵌入图
% 输入：block_size----------分块大小
% 输入：T,G,----------T:最大误差和，G:阈值
% 输出：exw_sequence----------提取的水印序列
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[histImg,spe_squence] = dq_getHistogram(watermarkedImg,local_map,block_size,n_level);
l=size(spe_squence,2);
exw_sequence=zeros(1,l);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     K_means聚类      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data=zeros(l,1);
for i=1:l
	data(i,1)=spe_squence(i);
end
[re] = qyh_kmeans(data,0);
for i=1:l
	if re(i,2) == 2
		w=0;
	else
		w=1;
	end
	exw_sequence(i)=w;
end
end
