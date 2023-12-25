% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [bool,local_map] = dq_sp_preEmbedingWatermarking(hostImg_lary,block_size,w_sequence,sorted_index,b_num_p,T,G,n_level)
% DQ_EMBEDINGWATERMARKING Summary of this function goes here
% 此函数用于自适应的判断生成local_map
%   Detailed explanation goes here
% 输入：hostImg----------宿主图像
% 输入：block_size----------分块大小
% 输入：w_sequence----------水印序列
% 输入：sorted_index----------排序索引（平滑块）
% 输入：b_num_p----------预测需要嵌入块的个数
% 输入：T,G,----------T:最大误差和，G:阈值
% 输出：bool----------是否全部嵌入
% 输出：local_map----------嵌入位置图
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%
% %%%   设定参数   %%%
% %%%%%%%%%%%%%%%%%%%%
w_len=size(w_sequence,2); % 获取水印序列的长度1024
% 对宿主图像进行分层
[L L n] = size(hostImg_lary); % 获取宿主图像的size
index_num=1; % 排序索引序列编号
w_index=1; % 水印序列编号
l_num = L/block_size; % 每一 行/列 有多少个块
local_map=zeros(l_num,l_num); % 水印嵌入图

for i=1:b_num_p % 对预计要嵌入的块进行嵌入，看能不能将水印序列全部嵌入
	if w_index<=w_len
		x_b = floor((sorted_index(index_num)-1)/l_num)+1; % 块的编号x
	 	y_b = mod(sorted_index(index_num)-1,l_num)+1; % 块的编号y
		index_num=index_num+1; % 排序索引序列编号
		% %%%%%%%%%%%%%%%%%%%%%
		% %%  计算出区域x,y  %%
		% %%%%%%%%%%%%%%%%%%%%%
		x1=(x_b-1)*block_size+1;
		x2=x_b*block_size;
		y1=(y_b-1)*block_size+1;
		y2=y_b*block_size;
		% %%%%%%%%%%%%%%%%%%%%%
		% %%%   R层预嵌入   %%%
		% %%%%%%%%%%%%%%%%%%%%%
		block_r=hostImg_lary(x1:x2,y1:y2); % r层要嵌入的块
		% block_r = imcrop(r_l,[x1,y1,block_size-1,block_size-1]);
		[ll_r, lh_r, hl_r, hh_r] = dq_iwtTransfrom(block_r,n_level); % r层要嵌入的块进行IWT分解
		[ll_rp,bool_r]=qyh_blockEmbed(ll_r,block_size/2,T,G); % 对R层进行嵌入，其实这里的bool_r没用，我们要看最后逆变换后是否溢出
		w_index=w_index+1; % 水印序列编号+1
		% %%%%%%%%%%%%%%%%%%%%%
		% %%  判断是否溢出   %%
		% %%%%%%%%%%%%%%%%%%%%%
		[w_block_r] = dq_inverIwtTransform(ll_rp,lh_r, hl_r, hh_r,n_level); % 对R层块嵌入后逆变换
		[m n] = size(w_block_r); % 获取嵌入块的大小
		b=1; % 默认不溢出，可以进行嵌入
		for i=1:m
			for j=1:n
				if w_block_r(i,j)>255 || w_block_r(i,j)<0 
					b=0; % 无论R还是G出现溢出，均不再进行嵌入
					break;
				end
			end
		end
		if b==1 % 如果不溢出，进行嵌入
			local_map(x_b,y_b)=1; % local_map相应位置进行记录
		else % 如果溢出，不进行嵌入
			w_index=w_index-1; % 水印序列编号-2 R,G均不进行嵌入
		end % if
	end % for
end % for
% %%%%%%%%%%%%%%%%%%%%%
% % 水印是否嵌入完毕 %%
% %%%%%%%%%%%%%%%%%%%%%
if w_index>w_len % 判断水印序列是否嵌入完毕
	bool=1; % 嵌入完毕回1
else
	bool=0; % 未嵌入完回0
end
end

