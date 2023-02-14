% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [recoveredImg] = dq_sp_robustWatermarkRecover(local_map,exw_sequence,watermarkedImg,block_size,T,G,n_level)
% DQ_ROBUSTWATERMARKRECOVER Summary of this function goes here
% 鲁棒水印进行可逆恢复
%   Detailed explanation goes here
% 输入：local_map----------鲁棒水印嵌入图
% 输入：exw_sequence----------提取出水印序列
% 输入：watermarkedImg----------要进行恢复的水印图像，单层灰度图像
% 输入：block_size----------分块大小
% 输入：T,G,----------T:最大误差和，G:阈值
% 输出：recoveredImg----------恢复后的图像
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index=1; % 提取水印序列的索引
block_size_l=block_size/2; % 频域的块大小
M = ((block_size_l/2)-1)*(block_size_l-2); % M
recoveredImg=watermarkedImg; % 可逆恢复后的图像
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 生成预测误差直方图 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[L L]=size(local_map); % 水印嵌入图 
for i=1:L
	for j=1:L % 遍历local_map
		if local_map(i,j)==1 % 如果locla_map为1，表示嵌入
			x1=(i-1)*block_size+1;
			x2=i*block_size;
			y1=(j-1)*block_size+1;
			y2=j*block_size;
            if exw_sequence(index)==1 % 如果水印序列为1，表示该块进行了直方图平移，则进行恢复 R层
				block_r=watermarkedImg(x1:x2,y1:y2); 
				% block_r = imcrop(wr_l,[x1,y1,block_size-1,block_size-1]);
				[ll_r, lh_r, hl_r, hh_r] = dq_iwtTransfrom(block_r,n_level);
                % [ll_r,imgwave]=liftwavedec2(block_r,block_size,1); % 进行IWT
				ll_rr = qyh_blockRecover(ll_r,block_size/2,T,G,M);
                % imgwave(1:block_size/2,1:block_size/2)=ll_rr;
                % block_rr=liftwaverec2(imgwave,block_size,1);
				[block_rr] = dq_inverIwtTransform(ll_rr,lh_r, hl_r, hh_r,n_level);
				recoveredImg(x1:x2,y1:y2)=block_rr;
            end
            index=index+1; % 水印序列索引+1
		end % if
	end % for
end % for
end

