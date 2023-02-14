


S=[9 11 11 11 -1 11 12 -1 13 12 12 13 8 10 10 11 9 5 8 -1 8 9 7 7 10 5 5 8];
for index_img=1:28
    hostImg = imread([num2str(index_img,'%02d'),'.png']);    %读入图片    
    G=S(index_img);
    if G>0
        [psnr2,ssim2] = getpsnr(hostImg,G,index_img);
        best_list(index_img,1)=psnr2; % psnr
        best_list(index_img,2)=ssim2; % ssim
        xlswrite('psnrssim.xls',best_list);
    else
    end
end


function [psnr2,ssim2] = getpsnr(hostImg,G,index_img)
    % 读入水印图像
    wImg=imread('wImg32.png'); 
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % %%%%%%%%%   水印图像预处理   %%%%%%%%%%
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [w_sequence] = dq_prepareWatermark(wImg);
    % 鲁棒水印的分块大小
    block_size_r=16; 
    % IWT等级
    n_level=3;
    % block_size_r=8; % 鲁棒水印的分块大小
    block_size_f=8; % 脆弱水印的分块大小
    bit_len=2; % 脆弱水印多少长度以下嵌入

    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % %%%%%%%%%    生成localmap    %%%%%%%%%%
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [local_map,T,alpha,error] = dq_get_localmap(hostImg,block_size_r,w_sequence,G,n_level);
    while error == 1
        G=G-2;
        [local_map,T,alpha,error] = dq_get_localmap(hostImg,block_size_r,w_sequence,G,n_level);
    end
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % %%%%%%%%%%%      嵌入      %%%%%%%%%%%%
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [watermarkedImg]=dq_embedWatermarking(hostImg,block_size_r,local_map,w_sequence,G,T,n_level);
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % %%%%%%%%%%%      psnr1      %%%%%%%%%%%
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % psnr1=psnr(watermarkedImg,hostImg);
    % ssim1=ssim(watermarkedImg,hostImg);
    % [avg_nc] = get_avgnc(watermarkedImg,wImg,local_map,block_size_r,T,G,n_level);
    % [att] = dq_robustAttact_test(wImg,watermarkedImg,local_map,block_size_r,T,G,n_level);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % %%%%%%%%%%%%%%%%%%%%%        脆弱水印嵌入        %%%%%%%%%%%%%%%%%%%%%%%%%
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [watermarkedImg,block_cell] = dsh_frigleWatermarkEmbed(watermarkedImg,block_size_f,bit_len);
    % 请检查dsh_frigleWatermarkEmbed中调用的方法db_peeEmbed
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % %%%%%%%%%%%      psnr2      %%%%%%%%%%%
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    psnr2=psnr(watermarkedImg,hostImg);
    ssim2=ssim(watermarkedImg,hostImg);
    save(['db',num2str(index_img,'%02d'),'.mat'],'block_cell');
end