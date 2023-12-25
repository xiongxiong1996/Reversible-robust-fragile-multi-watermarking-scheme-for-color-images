function [w_sequence] = dq_prepareWatermark(wImg,a,b,n)
% DQ_PREPAREWATERMARK Summary of this function goes here
% 对水印图像进行预处理
% DQ_ROBUSTATTACT_TEST Summary of this function goes here
% 鲁棒水印攻击测试，测试各种鲁棒攻击
%   Detailed explanation goes here
% 输入：wImg----------水印图像
% 输入：a,b,n----------Anorld置乱用到的参数
% 输出：w_sequence----------水印序列
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 如果输入参数小于7则给n,a,b默认值。
if nargin < 2
	n = 10;
	a=3;
	b=5; 
end
% 如果输入参数小于2则给n,a,b默认值。
w_sequence=zeros(1,n*n); % 创建水印序列
thresh =graythresh(wImg);     % 自动确定二值化阈值
wbImg = im2bw(wImg,thresh);   % 对图像二值化
w_Img = dsh_arnold(wbImg,n,a,b); % 水印置乱处理 n=10 a=3 b=5


[n n] =size(w_Img); % 获取水印图像的大小
% %%%%%%%%%%%%%%%%%%%%
% %%% 填写水印序列 %%%
% %%%%%%%%%%%%%%%%%%%%
w_s_num=1;
for i=1:n
	for j=1:n
		w_sequence(w_s_num)=w_Img(i,j);
		w_s_num=w_s_num+1;
	end
end


end