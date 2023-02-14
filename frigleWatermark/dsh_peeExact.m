% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Duan Shaohua <smartJack10101@gmail.com>       %%%
% %%%  revision			2021  Qian yuhan                                     %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ex_sequence,re_mb] = dsh_peeExact(mb,block_size,len_map)
% DSH_PEEEMBED Summary of this function goes here
% 预测误差扩展 提取并恢复
%   Detailed explanation goes here
% 输入：mb----------要进行提取的矩阵
% 输入：block_size----------分块大小
% 输入：len_map----------预测误差长度map
% 输出：ex_sequence----------提取的序列
% 输出：re_mb----------可逆恢复后的矩阵
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
len = ((block_size/2)-1)*(block_size-2); % 序列长度 3*6 =18
ex_sequence = zeros(1,len);% 取前watermark_len位
ex_num = 1;
re_mb=mb;
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
	% wpe 预测误差(含水印)
	wpe=double(c-pc);
	% %%%%%%%%%%%%%%%%%%
	% %%%%%提取恢复%%%%%
	% %%%%%%%%%%%%%%%%%%
	len=1; % 初始len=1
	wpe_l=abs(wpe);
	while wpe_l>=2
		wpe_l=floor(wpe_l/2);
		len=len+1;
	end
	lx=mod(ex_num-1,3)+1;
	ly=floor((ex_num-1)/3)+1;
	m_len=len_map(lx,ly);

	if m_len==-1  % 当检测到该位置没有嵌入水印时，不进行恢复
		ex_sequence(ex_num) = -1;
	else
		if m_len==len % 如果嵌入的是0 不需要恢复
			ex_sequence(ex_num) = 0;
			% re_mb(mx,my) = pc;
		else
			ex_sequence(ex_num) = 1;
			if wpe==2
				re_mb(mx,my) = pc;
			else
			re_mb(mx,my) = pc + (wpe/abs(wpe))*floor(abs(wpe)/2);
			end
		end
	end
	ex_num = ex_num+1;
	end
end
end

