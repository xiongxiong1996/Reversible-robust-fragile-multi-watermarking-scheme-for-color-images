function [wImg] = dq_get_wImg(exw_sequence,a,b,n)
% DQ_GET_WIMG Summary of this function goes here
%   Detailed explanation goes here
if nargin < 2
	n = 10;
	a = 3;
	b = 5; 
end
len=size(exw_sequence,2); % 提取出的水印序列长度
b_len=sqrt(len);
% %%%%%%%%%%%%%%%%%%%%
% %%% 填写水印序列 %%%
% %%%%%%%%%%%%%%%%%%%%
arnoldwImg=zeros(b_len,b_len);
w_s_num=1;
for i=1:b_len
	for j=1:b_len
		arnoldwImg(i,j)=exw_sequence(w_s_num);
		w_s_num=w_s_num+1;
	end
end
N=b_len;
img=arnoldwImg;
for i=1:n
    for y=1:b_len
        for x=1:b_len            
            xx=mod((a*b+1)*(x-1)-b*(y-1),N)+1;
            yy=mod(-a*(x-1)+(y-1),N)+1  ;        
            arnoldwImg(yy,xx)=img(y,x);                   
        end
    end
    img=arnoldwImg;
end
wImg=arnoldwImg;
end
