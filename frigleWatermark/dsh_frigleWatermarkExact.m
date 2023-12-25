% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  revision			2021  Qian yuhan                                     %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [recoverImg,recoverlayer,taggedImg,istagged] = dsh_frigleWatermarkExact(watermarkedImg,block_size,bit_len,block_cell,unc_len,block_t_num)
% DSH_ROBUSTWATERMARKEMBED Summary of this function goes here
% 提取脆弱水印并进行恢复
%   Detailed explanation goes here
% 输入：watermarkedImg----------水印图像
% 输入：block_size----------分块大小
% 输入：bit_len----------控制允许嵌入的误差长度
% 输入：block_cell----------存储了每个块用于提取和恢复的len_map
% 输入：unc_len----------比较hash序列时，有 (len-unc_len)块标记为未嵌入，则认为该块为可疑块
% 输入：block_t_num----------在一个3*3的区域中，周围8个块，有block_t_num块被篡改，则认为该块也被篡改了
% 输出：recoverImg----------复原后的图像
% 输出：recoverlayer----------复原后的层
% 输出：taggedImg----------篡改定位图
% 输出：istagged----------是否被篡改？默认是0，表示未被篡改，如果为1表示被篡改
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
recoverImg = watermarkedImg;
recoverlayer = watermarkedImg(:,:,3);
taggedImg = watermarkedImg;
block_num=1;
istagged=0;

% 取水印图像的size
[L L n] = size(watermarkedImg);
% certain_num=0;
% 疑似篡改图
uncertain_map=zeros(L/block_size,L/block_size);
% 篡改图
tagged_map=zeros(L/block_size,L/block_size);

% %%%%%%%%%%%%%%%%%%
% %%%%%% 分块 %%%%%%
% %%%%%%%%%%%%%%%%%%
for i=1:(L/block_size)
	x1=(i-1)*block_size+1;
	x2=i*block_size;
	for j=1:(L/block_size)
		y1=(j-1)*block_size+1;
		y2=j*block_size;

		% %%%%%%%%%%%%%%%%%%
		% %%%  生成hash  %%%
		% %%%%%%%%%%%%%%%%%%
		temp_block = imcrop(watermarkedImg,[x1,y1,block_size-1,block_size-1]);
		mr=temp_block(:,:,1); % R
		mg=temp_block(:,:,2); % G
		hash_sequence = dsh_hashcode(mr,mg);
		% %%%%%%%%%%%%%%%%%%%%%%
		% %%%%%% 提取恢复 %%%%%%
		% %%%%%%%%%%%%%%%%%%%%%%
		mb=temp_block(:,:,3); % B
		len_map=block_cell{block_num,2};
		[ex_sequence,re_mb] = dsh_peeExact(mb,block_size,len_map);% 用于提取水印，并进行恢复
		recoverlayer(y1:y2,x1:x2)=re_mb; % 使用恢复的re_mb 替换原来的区域
		block_num=block_num+1;
		% %%%%%%%%%%%%%%%%%%
		% %%%%%% 比较 %%%%%%
		% %%%%%%%%%%%%%%%%%%
		[istag,isuncertain]=dsh_s_compareHash(hash_sequence,ex_sequence,block_size,unc_len);% 用于比较两个序列
		
		% %%%%%%%%%%%%%%%%%%%%%%
		% %%%%篡改检测图生成%%%%
		% %%%%%%%%%%%%%%%%%%%%%%
        if(istag==1)
		 	taggedImg(y1:y2,x1:x2)=1; % 标记篡改区域
		 	istagged=1;
		 	tagged_map(ceil(x1/block_size),ceil(y1/block_size))=1;
        else
            if (isuncertain==1)
				uncertain_map(ceil(x1/block_size),ceil(y1/block_size))=1;
            end
        end
	end % for
end % for
recoverImg(:,:,3) = recoverlayer;
taggedImg=dsh_tamperrCertain2(tagged_map,uncertain_map,taggedImg,block_size,block_t_num);
end

