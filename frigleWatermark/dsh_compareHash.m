% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  Revision			2021  Qian yuhan                                     %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [hash_right,error_num] = dsh_compareHash(hash_sequence,hw_array)

%   Note: 
% 此方法用于比较两个hash序列是否相同，（可以优化！！！）

% 输入：hash_sequence，hw_array---需要比较的两个hash序列
% 输出：hash_right---hash标志，1为匹配成功0为失败
% 输出：error_num---hash序列不匹配个数（没用）

% ---------------------------------------------------------
l = length(hash_sequence);
error_num=0;
hash_right=1;
for i=1:l
	if hw_array(i)==2
	else if hash_sequence(i) == hw_array(i);
	else
		hash_right=0;
		error_num=error_num+1;
	end
end
end

