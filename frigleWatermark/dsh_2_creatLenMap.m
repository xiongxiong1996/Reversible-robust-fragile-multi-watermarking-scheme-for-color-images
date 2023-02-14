function [len_maps] = dsh_2_creatLenMap(hostImg,block_size,bit_len)
% DSH_FRIGLEWATERMARKEMBED Summary of this function goes here
% 用于生成lenMap
%   Detailed explanation goes here
% 输入：layer----------待嵌入的层
% 输入：block_size----------分块大小
% 输出：len_maps----------存储了每个块用于提取和恢复的len_map
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Detailed explanation goes here

block_num=1;
block_cell=cell(1,2);
% 分块
[L L] = size(hostImg);

watermark_len = ((block_size/2)-1)*(block_size-2); % 可嵌入序列的长度 3*6 =18
index=1; % len_map的索引

% %%%%%%%%%%%%%%%%%%
% %%%%%% 分块 %%%%%%
% %%%%%%%%%%%%%%%%%%
for i=1:(L/block_size)
	x1=(i-1)*block_size+1;
	x2=i*block_size;
	for j=1:(L/block_size)
		y1=(j-1)*block_size+1;
		y2=j*block_size;
		% %%%%%%%%%%%%%%%%%%%%%
		% %%%% 生成len_map %%%%
		% %%%%%%%%%%%%%%%%%%%%%
		index=1;
		E_m = imcrop(hostImg,[x1,y1,block_size-1,block_size-1]);
		% [len_map] = dsh_2_createBlockLenMap(E_m,block_size,bit_len);
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
						p(p_n)=E_m(r,l);
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
				wpe = (pe/abs(pe))*(abs(pe)*2+1);
				% %%%%%%%%%%%%%%%%%%%
				% %%%%%填len_map%%%%%
				% %%%%%%%%%%%%%%%%%%%
				if pe>(2^bit_len) || pe<-(2^bit_len) || pc+wpe>255 || pc+wpe<0 % 当遇到预测误差过大，和嵌入后超出范围的情况，我们不进行嵌入
					len=-1; % len_map 嵌入-1
					len_map(mod(index-1,3)+1,floor((index-1)/3)+1)=len;
				else
					len=1; % 初始len=1
					pe=abs(pe); % 取绝对值进行len的计算
					% %%%%%%%%%%%%%
					% %% 计算len %%
					% %%%%%%%%%%%%%
					while pe>=2
						pe=floor(pe/2);
						len=len+1;
					end
					lx=mod(index-1,3)+1;
					ly=floor((index-1)/3)+1;
					len_map(lx,ly)=len; % 将len存入len_map
				end
				index=index+1; % hash序列索引+1
			end % for
		end % for

		len_maps(block_num,:)={block_num,len_map};
		block_num = block_num+1;
	end % for
end % for
end

