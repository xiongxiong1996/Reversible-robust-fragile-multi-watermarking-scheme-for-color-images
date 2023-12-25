% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [perror_sequence] = dq_get_preErrorSequence(hostImg,block_size,n_level)
% DQ_GET_PREERRORSEQUENCE Summary of this function goes here
% 对灰度图像或彩色图像单层，进行分块预测误差，并计算其SUM，生成sequence
% 输入：hostImg----------宿主图像
% 输入：block_size----------分块大小
% 输出：perror_sequence----------预测误差和序列
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 获取宿主图像的大小
[L L]=size(hostImg);
% 定义perror_sequence
perror_sequence=zeros(1,floor(L/block_size)*floor(L/block_size));
% perror_sequence的索引
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
		block=hostImg(x1:x2,y1:y2); 
		% block = imcrop(hostImg,[x1,y1,block_size-1,block_size-1]);
		[ll_r, lh_r, hl_r, hh_r] = dq_iwtTransfrom(block,n_level);
		[sum_pe] = qyh_getBlockSumpe(ll_r,block_size/2);
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% %%%%%% 生成perror_sequence %%%%%
		% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		perror_sequence(index)=sum_pe;
		index=index+1;

	end % for
end % for

end

