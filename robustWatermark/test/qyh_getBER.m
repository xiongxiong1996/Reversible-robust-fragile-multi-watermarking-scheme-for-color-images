function [ber] = qyh_getBER(w_sequence,exw_sequence)
% QYH_GETBER Summary of this function goes here
%   Detailed explanation goes here

[r,l]=size(w_sequence);
count=0;
s_num=1;
for i=1:l
	if w_sequence(s_num) ~= exw_sequence(s_num)
		count=count+1;
	end
	s_num=s_num+1;
end
ber=count/(l);
end

