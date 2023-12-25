% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Revision			 2021  Qian yuhan                                    %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [istag,isuncertain,error_num]=dsh_s_compareHash(hash_sequence,ex_sequence,block_size,unc_len)
% DSH_PEEEMBED Summary of this function goes here
% 比较hash值是否相同
%   Detailed explanation goes here
% 输入：hash_sequence----------计算出的hash quence
% 输入：ex_sequence----------提取出的hash quence
% 输入：block_size----------块大小
% 输入：unc_len----------比较hash序列时，有 (len-unc_len)块标记为未嵌入，则认为该块为可疑块
% 输出：istag----------相同tag，如果相同返回0，不同返回1
% 输出：error_num----------两个hash值对比错误数量
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
watermark_len = ((block_size/2)-1)*(block_size-2); % 可嵌入序列的长度 3*6 =18
hash_sequence = hash_sequence(1:watermark_len);% 取前watermark_len位

isuncertain=0;
unembed_num=0;
error_num=0;
istag=0;
for i=1:watermark_len
	if ex_sequence(i)==-1
		unembed_num=unembed_num+1;
	else if hash_sequence(i) == ex_sequence(i)
	else
		istag=1;
		error_num=error_num+1;
	end
end
% 若未嵌入太多的位，我们则认为该块的比较结果不可信
if istag==0 && unembed_num > (watermark_len-unc_len)
	isuncertain=1;
end
end

