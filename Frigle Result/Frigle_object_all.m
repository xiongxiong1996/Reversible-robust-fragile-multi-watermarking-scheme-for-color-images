clc;clear;
tic
%
% 
block_size_f=8; % 脆弱水印的分块大小
bit_len=2; % 脆弱水印多少长度以下嵌入
unc_len=5;% 比较hash序列时，有 (len-unc_len)块标记为未嵌入，则认为该块为可疑块
block_t_num=5;% 用于篡改检测图恢复在一个3*3的区域中，周围8个块，有block_t_num块被篡改，则认为该块也被篡改了

detal=0.4;
a1=0.9;
a2=0.3;
    hostImg=imread('TI_house.tiff');  
    % hostImg=imread('TI_Lena_color.tiff');    %读入图片
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % %%%%%%%%%%%%%%%%%%%%%        脆弱水印嵌入        %%%%%%%%%%%%%%%%%%%%%%%%%
    % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 嵌入，获取block_cell
    [watermarkedImg,block_cell] = dsh_frigleWatermarkEmbed(hostImg,block_size_f,bit_len);
    % 写出水印图像
    imwrite(watermarkedImg,'watermarkedImg.png')
    value=zeros(1,5); 
    % 读取水印图像
    I = imread('watermarkedImg.png'); 
    J = imread('T_house.png');
    [recoverImg,taggedImg,tmap,istagged,tagged_map,uncertain_map]  = dq_frigleExactMap_per(J,block_size_f,bit_len,block_cell,unc_len);
    [taggedImg,tmap2]=dq_tamperrCertain2(tagged_map,uncertain_map,taggedImg,block_size_f,block_t_num,tmap,detal,a1,a2);
    [fpr,fnr,tpr,tnr,acc] = dq_FragileExample(I,J,tmap2);
    value(1,1)=fpr;
    value(1,2)=fnr;
    value(1,3)=tpr;
    value(1,4)=tnr;
    value(1,5)=acc;
    imwrite(taggedImg,['taggedImg_house.png'])
    % s = xlswrite('frigle_list_airplane', value);
