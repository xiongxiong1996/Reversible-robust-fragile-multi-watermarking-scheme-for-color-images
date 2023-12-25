% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Qian yuhan          %%%
% %%%  revision			2021  Duan shaohua                                   %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [histImg,spe_squence] = qyh_getHistogram(Img,block_size)
% QYH_GETBLOCKSUMPE Summary of this function goes here
% 本函数用于获取直方图
%   Detailed explanation goes here
% 输入：Img----------需要获取直方图的图片
% 输入：block_size----------块大小
% 输出：histImg----------直方图
% 输出：spe_squence----------用于生成直方图的序列
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[L L]=size(Img);
index=1;
% %%%%%%%%%%%%%%%%%%
% %%%%%% 分块 %%%%%%
% %%%%%%%%%%%%%%%%%%
for i=1:(L/block_size)
	x1=(i-1)*block_size+1;
	x2=i*block_size;
	for j=1:(L/block_size)
		y1=(j-1)*block_size+1;
		y2=j*block_size;
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% %%%%%% 获取单小块的sum_pe %%%%%%
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		block = imcrop(Img,[x1,y1,block_size-1,block_size-1]);
		[sum_pe] = qyh_getBlockSumpe(block,block_size);
		spe_squence(index)=sum_pe;
		index=index+1;
	end % for
end % for
histImg=histogram(spe_squence,1000);
end

