clc;clear;
tic
%
% 
block_size_f=8; % 脆弱水印的分块大小
bit_len=2; % 脆弱水印多少长度以下嵌入
unc_len=5;% 比较hash序列时，有 (len-unc_len)块标记为未嵌入，则认为该块为可疑块
block_t_num=5;% 用于篡改检测图恢复在一个3*3的区域中，周围8个块，有block_t_num块被篡改，则认为该块也被篡改了


for i=1:28
    hostImg=imread([num2str(i,'%02d'),'.png']);    %读入图片
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % %%%%%%%%%%%%%%%%%%%%%        脆弱水印嵌入        %%%%%%%%%%%%%%%%%%%%%%%%%
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 嵌入，获取block_cell
    [watermarkedImg,block_cell] = dsh_frigleWatermarkEmbed(hostImg,block_size_f,bit_len);
    % 写出水印图像
    imwrite(watermarkedImg,'watermarkedImg.png')
    % 读取水印图像
    I = imread('watermarkedImg.png');
    % 攻击模式@！
    J = fragile_att(I,3);
    [recoverImg,taggedImg,tmap,istagged,tagged_map,uncertain_map]  = dq_frigleExactMap_per(J,block_size_f,bit_len,block_cell,unc_len);
    value=zeros(1,8); 
    [fpr,fnr,tpr,tnr,acc] = dq_FragileExample(I,J,tmap);
    v_i =1;
    value(v_i,4)=fpr;
    value(v_i,5)=fnr;
    value(v_i,6)=tpr;
    value(v_i,7)=tnr;
    value(v_i,8)=acc;
    v_i=v_i+1;
    for detal=0.4:0.1:1
        for a1=0.4:0.1:1
            for a2= 0.1:0.1:1
                [taggedImg,tmap2]=dq_tamperrCertain2(tagged_map,uncertain_map,taggedImg,block_size_f,block_t_num,tmap,detal,a1,a2);
                [fpr,fnr,tpr,tnr,acc] = dq_FragileExample(I,J,tmap2);
                value(v_i,1)=detal;
                value(v_i,2)=a1;
                value(v_i,3)=a2;
                value(v_i,4)=fpr;
                value(v_i,5)=fnr;
                value(v_i,6)=tpr;
                value(v_i,7)=tnr;
                value(v_i,8)=acc;
                v_i=v_i+1;
            end
        end
    end
    s = xlswrite(['frigleGaussian_test_',num2str(i,'%02d'),'.xls'], value);
end
