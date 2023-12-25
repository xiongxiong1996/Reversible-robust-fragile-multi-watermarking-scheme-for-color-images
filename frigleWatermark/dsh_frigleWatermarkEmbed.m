% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  revision			2021  Qian yuhan                                     %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [watermarkedImg,block_cell] = dsh_frigleWatermarkEmbed(hostColorImg,block_size,bit_len)
% DSH_FRIGLEWATERMARKEMBED Summary of this function goes here
% 提取脆弱水印并进行恢复
%   Detailed explanation goes here
% 输入：hostColorImg----------宿主图像
% 输入：block_size----------分块大小
% 输入：bit_len----------控制允许嵌入的误差长度
% 输出：watermarkedImg----------嵌入水印后的图像
% 输出：block_cell----------存储了每个块用于提取和恢复的len_map
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Detailed explanation goes here
watermarkedImg=hostColorImg;
fwImg=hostColorImg(:,:,3);
block_num=1;
block_cell=cell(1,2);
% 分块
[L L n] = size(hostColorImg);
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
		temp_block = imcrop(hostColorImg,[x1,y1,block_size-1,block_size-1]);
		mr=temp_block(:,:,1); % R
		mg=temp_block(:,:,2); % G
		hash_sequence = dsh_hashcode(mr,mg);
		% %%%%%%%%%%%%%%%%%%
		% %%%%%% 嵌入 %%%%%%
		% %%%%%%%%%%%%%%%%%%
		mb=temp_block(:,:,3); % B
		[fw_martrix,len_map] = dsh_peeEmbed(mb,hash_sequence,block_size,bit_len);
        % [fw_martrix,len_map] = db_peeEmbed(mb,hash_sequence,block_size,bit_len);
		block_cell(block_num,:)={block_num,len_map};
		block_num = block_num+1;
		% 替换原来的块
		fwImg(y1:y2,x1:x2)=fw_martrix;
	end % for
end % for
watermarkedImg(:,:,3)=fwImg;
end

