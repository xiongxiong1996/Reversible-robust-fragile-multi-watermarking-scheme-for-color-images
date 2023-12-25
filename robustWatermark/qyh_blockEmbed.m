% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Qian yuhan          %%%
% %%%  revision			2021  Duan shaohua                                   %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [block_p,bool]=qyh_blockEmbed(block,block_size,T,G)
% QYH_GETBLOCKSUMPE Summary of this function goes here
% 水印嵌入方案
%   Detailed explanation goes here
% 输入：block----------要嵌入水印的块
% 输入：block_size----------块大小
% 输入：T----------范围
% 输入：G----------阈值
% 输出：block_p----------嵌入水印后的块
% 输出：bool----------如果溢出了bool变为0，表示该块不适合嵌入

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bool=0;
sum_pe =0;
flag=1;          % beta正负：flag=1/-1
block_p=block;
block_num=1; % 嵌入的几块。一共 M 块   b
[block_size,block_size]=size(block);
M=block_size^2;
% M = ((block_size/2)-1)*(block_size-2); % 可嵌入序列的长度 3*6 =18


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  计算sum_pe  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
sum_pe=qyh_getBlockSumpe(block,block_size);
if sum_pe<0
    flag=-1;
end
% % % % % 若sum_pe>0，则每个小块权重不变；若sum_pe<=0，则每个小块权重变为相反数%%%%%%
for i=1:block_size
    for j=1:block_size
        beta=flag * floor((T+G+block_num-1)/M);          
        if mod(i+j,2)==0                           %下标和对2取余为0时，
              block_p(i,j)=block_p(i,j)+beta;
        else
              block_p(i,j)=block_p(i,j)-beta;
        end % if
        block_num=block_num+1;
    end
end
end



