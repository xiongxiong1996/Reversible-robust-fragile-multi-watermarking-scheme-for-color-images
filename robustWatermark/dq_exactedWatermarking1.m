% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [exw_sequence] = dq_exactedWatermarking1(watermarkedImg,local_map,block_size,T,G,n_level)
% DQ_EXACTEDWATERMARKING1 Summary of this function goes here
% 该函数进行水印序列的提取。
%   Detailed explanation goes here
% 输入：watermarkedImg----------水印图像
% 输入：local_map----------鲁棒水印嵌入图
% 输入：block_size----------分块大小
% 输入：T,G,----------T:最大误差和，G:阈值
% 输出：exw_sequence----------提取的水印序列
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wr_l=watermarkedImg(:,:,1);
wg_l=watermarkedImg(:,:,2);
wb_l=watermarkedImg(:,:,3);
index=1; % 水印序列的index
exw_sequence=zeros(1,1); % 提取出的水印序列
[L L]=size(local_map); % 获取嵌入图的size
for i=1:L
	for j=1:L
		if local_map(i,j)==1			
			x1=(i-1)*block_size+1;
			x2=i*block_size;
			y1=(j-1)*block_size+1;
			y2=j*block_size;
			% %%%%%%%%%%%%%%%%%%%%%
			% %%%    R层提取    %%%
			% %%%%%%%%%%%%%%%%%%%%%
			block_r=wr_l(x1:x2,y1:y2);
			[ll_r, lh_r, hl_r, hh_r] = dq_iwtTransfrom(block_r,n_level);
            % [ll_r,imgwave]=liftwavedec2(block_r,block_size,1); % 进行IWT
			[sum_pe] = qyh_getBlockSumpe(ll_r,block_size/2); % 获取单小块的sum_pe
			if sum_pe>=(-T-G/2) && sum_pe<=(T+G/2)
				w=0;
			else
				w=1;
			end
			exw_sequence(index)=w;
			index=index+1;
			% %%%%%%%%%%%%%%%%%%%%%
			% %%%    G层提取    %%%
			% %%%%%%%%%%%%%%%%%%%%%
			block_g=wg_l(x1:x2,y1:y2);
            % [ll_g,imgwave]=liftwavedec2(block_g,block_size,1); % 进行IWT
			[ll_g, lh_g, hl_g, hh_g] = dq_iwtTransfrom(block_g,n_level);
			[sum_pe] = qyh_getBlockSumpe(ll_g,block_size/2);% 获取单小块的sum_pe
			if sum_pe>=(-T-G/2) && sum_pe<=(T+G/2)
				w=0;
			else
				w=1;
			end
			exw_sequence(index)=w;
			index=index+1;
		end
	end
end
end

