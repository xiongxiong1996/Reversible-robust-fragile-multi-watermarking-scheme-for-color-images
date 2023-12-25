function [watermarkedImg]=dq_sp_embedWatermarking(hostImg_layer,block_size,local_map,w_sequence,G,T,n_level)
% DQ_EMBEDINGWATERMARKING Summary of this function goes here
%   Detailed explanation goes here

w_r_l=hostImg_layer;
[L L]=size(local_map);
w_index=1;
for i=1:L
	for j=1:L
		if local_map(i,j)==1			
			x1=(i-1)*block_size+1;
			x2=i*block_size;
			y1=(j-1)*block_size+1;
			y2=j*block_size;
			% %%%%%%%%%%%%%%%%%%%%%
			% %%%    R层提取    %%%
			% %%%%%%%%%%%%%%%%%%%%%
			block_r=hostImg_layer(x1:x2,y1:y2); % 需要嵌入的块获取
			% block_r = imcrop(r_l,[x1,y1,block_size-1,block_size-1]);
			[ll_r, lh_r, hl_r, hh_r] = dq_iwtTransfrom(block_r,n_level); % 进行IWT
            % [ll_r,imgwave]=liftwavedec2(block_r,block_size,1); % 进行IWT
			ll_rp=ll_r;
			if w_sequence(w_index)==1 
				[ll_rp,~]=qyh_blockEmbed(ll_r,block_size/2,T,G);
			end
			w_index=w_index+1;
			[w_block_r] = dq_inverIwtTransform(ll_rp,lh_r, hl_r, hh_r,n_level);% 进行inder IWT
            w_r_l(x1:x2,y1:y2)=w_block_r; % 用嵌入后的块，替换原始的块，生成嵌入水印后的层

		end
	end
end
watermarkedImg=w_r_l;
end

