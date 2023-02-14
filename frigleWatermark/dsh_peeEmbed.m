% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  revision			2021  Qian yuhan                                     %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [fw_martrix,len_map] = dsh_peeEmbed(mb,hash_sequence,block_size,bit_len)
% DSH_PEEEMBED Summary of this function goes here
% 预测误差扩展嵌入
%   Detailed explanation goes here
% 输入：mb----------要进行嵌入的矩阵
% 输入：hash_sequence----------要嵌入的hash序列
% 输入：block_size----------块大小
% 输入：bit_len----------控制允许嵌入的误差长度
% 输出：fw_martrix----------可逆嵌入完毕后的矩阵
% 输出：len_map----------预测误差长度map
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fw_martrix = mb; % 嵌入后的矩阵
watermark_len = ((block_size/2)-1)*(block_size-2); % 可嵌入序列的长度 3*6 =18
hash_sequence = hash_sequence(1:watermark_len);% 取前watermark_len位
hash_s_num=1; % hash序列序号

len_map=zeros((block_size/2)-1,(block_size-2)); % 3*6 长度图，用于存储预测误差长度

for i=1:(block_size-2)
	x1=i;
	x2=i+2;
	for j=1:((block_size/2)-1)
		y1=2*j-mod(x1+1,2);
		y2=2*j+2-mod(x1+1,2);
		mx=x1+1; % 中心元素坐标
		my=y1+1; % 中心元素坐标
		% %%%%%%%%%%%%%%%%%%
		% %%% 误差预测  %%%%
		% %%%%%%%%%%%%%%%%%%
		% p 3*3矩阵遍历
		p=zeros(1,9);
		p_n=1;
		for r=x1:x2
			for l=y1:y2
				p(p_n)=mb(r,l);
				 p_n=p_n+1;
			end
		end
		% c 3*3矩阵中中心元素
		c=double(p(5));
		% 初始化 Diamond prediction
		diamond_p_s=zeros(1,4);
		% 菱形预测
		diamond_p_s=[p(2) p(4) p(6) p(8)]; 
		% pc 菱形预测中心元素
		pc=round(mean(diamond_p_s)); 
		% pe 预测误差
		pe=double(c-pc);
		
		% %%%%%%%%%%%%%%%%%%
		% %%%%%扩展嵌入%%%%%
		% %%%%%%%%%%%%%%%%%%
		if hash_sequence(hash_s_num)==1 % 等于1的话嵌入
			if pe==0
				wpe=2;
			else
			wpe = (pe/abs(pe))*(abs(pe)*2+1);
			end
		else % 等于0的话不嵌
			wpe = pe;
		end
		
		if pe>(2^bit_len) || pe<-(2^bit_len) || pc+wpe>255 || pc+wpe<0 % 当遇到预测误差过大，和嵌入后超出范围的情况，我们不进行嵌入
			fw_martrix(mx,my)=c;
			len=-1; % len_map 嵌入-1
			len_map(mod(hash_s_num-1,3)+1,floor((hash_s_num-1)/3)+1)=len;
		else
			fw_martrix(mx,my)=pc+wpe;
			len=1; % 初始len=1
			pe=abs(pe); % 取绝对值进行len的计算
			% %%%%%%%%%%%%%
			% %% 计算len %%
			% %%%%%%%%%%%%%
			while pe>=2
				pe=floor(pe/2);
				len=len+1;
			end
			lx=mod(hash_s_num-1,3)+1;
			ly=floor((hash_s_num-1)/3)+1;
			len_map(lx,ly)=len; % 将len存入len_map
		end
		hash_s_num=hash_s_num+1; % hash序列索引+1
	end % for
end % for

end

