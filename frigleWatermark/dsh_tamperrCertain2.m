% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%  revision	     2021  Duan Shaohua <smartJack10101@gmail.com>	     %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [taggedImg] = dsh_tamperrCertain2(tagged_map,uncertain_map,taggedImg,block_size,block_t_num)
% DSH_TAMPERRCERTAIN2 Summary of this function goes here
% 对第一次得到的篡改检测图，进行一次恢复
%   Detailed explanation goes here
% 输入：tagged_map----------篡改定位图像
% 输入：uncertain_map----------疑似块分布图
% 输入：taggedImg----------篡改定位分布图
% 输入：block_size----------块大小
% 输入：block_t_num----------在一个3*3的区域中，周围8个块，有block_t_num块被篡改，则认为该块也被篡改了
% 输出：taggedImg----------修改后的篡改定位图像
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% detal 用于计算边缘块
detal=0.7;
a1=1; % 周围篡改块系数
a2=0.4; % 周围可疑块系数
[m_l m_l] = size(uncertain_map);
for i=1:m_l
	for j=1:m_l
		b_t_num=0;
		block_t_num_c=block_t_num;
        if uncertain_map(i,j)==1
			for n=i-1:i+1
				for m=j-1:j+1
				% 越界块处理，不再进行计算
                    if n<1||m<1||n>m_l||m>m_l
                        if block_t_num>=1
							% 减去响应的阈值
							block_t_num_c=block_t_num_c-detal;
                        end
                    else
                        if tagged_map(n,m)==1
                            b_t_num=b_t_num+a1;
                        end
                        if uncertain_map(n,m)==1
                            b_t_num=b_t_num+a2;
                        end
                    end
				end
			end
        end
        if b_t_num>=block_t_num_c
			x1=(i-1)*block_size+1;
			x2=i*block_size;
			y1=(j-1)*block_size+1;
			y2=j*block_size;
			taggedImg(y1:y2,x1:x2)=1;
        end
    end
end

end

