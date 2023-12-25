% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Qian yuhan          %%%
% %%%  revision			2021  Duan shaohua                                   %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [block_r] = qyh_blockRecover(block,block_size,T,G,M)
% QYH_BLOCKRECOVER Summary of this function goes here
% 该函数用于小块的恢复
%   Detailed explanation goes here
% 输入：block_p----------要进行恢复的块
% 输入：block_size----------块大小
% 输入：T,G,M----------T:最大误差和，G:阈值，M:每个块预测的像素个数
% 输出：block_r----------恢复的小块

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
block_num=1;
[block_size block_size]=size(block);
[sum_pe] = qyh_getBlockSumpe(block,block_size);
block_r=block;
flag=1;          % beta正负：flag=1/-1
M=block_size^2;
block_p=block;
block_r=block;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     进行恢复    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum_pe<0
    flag=-1;
end
for i=1:block_size
    for j=1:block_size
        beta=flag * floor((T+G+block_num-1)/M);
        if mod(i+j,2)==0
              block_r(i,j)=block_p(i,j)-beta;
        else
              block_r(i,j)=block_p(i,j)+beta;
        end % if
        block_num=block_num+1;
    end
end
end

