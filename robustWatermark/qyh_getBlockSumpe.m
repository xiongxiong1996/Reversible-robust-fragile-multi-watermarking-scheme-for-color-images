% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Qian yuhan          %%%
% %%%  revision			2021  Duan shaohua                                   %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sum_pe] = qyh_getBlockSumpe(block,block_size)
% QYH_GETBLOCKSUMPE Summary of this function goes here
% 本函数用于对单独一个小块进行预测，并求预测误差的sum
%   Detailed explanation goes here
% 输入：block----------要进行计算的矩阵
% 输入：block_size----------块大小
% 输出：sum_pe----------计算出的sum_pe
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[block_size,block_size]=size(block);
sum_pe =0;
for i=1:block_size                          %遍历每个小块
	for j=1:block_size 
        if mod(i+j,2)==0                    %下标和对2取余为0时，权重为1
            sum_pe=sum_pe+block(i,j);            
        else
            sum_pe=sum_pe-block(i,j);       %下标和对2取余为1时，权重为-1
        end
	end % for
end % for

end

