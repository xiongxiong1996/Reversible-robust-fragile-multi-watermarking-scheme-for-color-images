function [image_a,att_name] = attacks_nosie(Watermarked_Image,Attacks)
% 
%   Copyright (C) 2020  Duan Shaohua <smartJack1996@gmail.com>
% 
% This is a function for attacking the watermarked image
% 图片输入类型：uint8
% 本函数用于进行图片攻击测试，共包含了76种攻击大家可以根据需求选取。
% 输入：Watermarked_Image---嵌入水印后的图像
% 			Attacks---攻击类别 0-76的数字，不同数字会进行不同攻击
% 输出：image_a --- 攻击后的嵌入水印图像
% 			att_name --- 攻击名称
% ------------------------------------------------------------------
Watermarked_Image = im2uint8(Watermarked_Image);
[sizeX sizeY] = size(Watermarked_Image);
switch Attacks
    case 0
        image_a = Watermarked_Image;
        att_name = 'Non-Attack';
    case 1
        image_a = imnoise(Watermarked_Image,'gaussian',0,0.001);
        att_name = 'Gaussian noise (σ= 0.1%)'
    case 2        
        image_a = imnoise(Watermarked_Image,'gaussian',0,0.003);
        att_name = 'Gaussian noise (σ= 0.3%)'
    case 3        
        image_a = imnoise(Watermarked_Image,'gaussian',0,0.005);
        att_name = 'Gaussian noise (σ= 0.5%)'
    case 4       
        image_a = imnoise(Watermarked_Image,'gaussian',0,0.007);
        att_name = 'Gaussian noise (σ= 0.7%)'
    case 5       
        image_a = imnoise(Watermarked_Image,'gaussian',0,0.009);
        att_name = 'Gaussian noise (σ= 9%)' 
    case 6      
        image_a = imnoise(Watermarked_Image,'gaussian',0,0.011);
        att_name = 'Gaussian noise (σ= 1.1%)' 
    case 7     
        image_a = imnoise(Watermarked_Image,'gaussian',0,0.013);
        att_name = 'Gaussian noise (σ= 1.3%)' 
    case 8      
        image_a = imnoise(Watermarked_Image,'gaussian',0,0.015);
        att_name = 'Gaussian noise (σ= 1.5%)'  
    case 9    
        image_a = imnoise(Watermarked_Image,'salt & pepper',0.001);
        att_name = 'Salt-pepper noise (den = 0.1%)';
    case 10
        image_a = imnoise(Watermarked_Image,'salt & pepper',0.003);
        att_name = 'Salt-pepper noise (den = 0.3%)';
    case 11
        image_a = imnoise(Watermarked_Image,'salt & pepper',0.005);
        att_name = 'Salt-pepper noise (den = 0.5%)';
    case 12
        image_a = imnoise(Watermarked_Image,'salt & pepper',0.007);
        att_name = 'Salt-pepper noise (den = 0.7%)';
    case 13        
        image_a = imnoise(Watermarked_Image,'salt & pepper',0.009);
        att_name = 'Salt-pepper noise (den = 0.9%)';
    case 14        
        image_a = imnoise(Watermarked_Image,'salt & pepper',0.011);
        att_name = 'Salt-pepper noise (den = 1.1%)';; 
    case 15
        image_a = imnoise(Watermarked_Image,'salt & pepper',0.013);
        att_name = 'Salt-pepper noise (den = 1.3%)';
    case 16
        image_a = imnoise(Watermarked_Image,'salt & pepper',0.015);
        att_name = 'Salt-pepper noise (den = 1.5%)';
    case 17
        image_a = imnoise(Watermarked_Image,'speckle',0.001);
        att_name = 'Speckle noise (0.1%)';
    case 18
        image_a = imnoise(Watermarked_Image,'speckle',0.003);
        att_name = 'Speckle noise (0.3%)';
    case 19
        image_a = imnoise(Watermarked_Image,'speckle',0.005);
        att_name = 'Speckle noise (0.5%)';
    case 20
        image_a = imnoise(Watermarked_Image,'speckle',0.007);
        att_name = 'Speckle noise (0.7%)';
    case 21
        image_a = imnoise(Watermarked_Image,'speckle',0.009);
        att_name = 'Speckle noise (0.9%)';
    case 22
        image_a = imnoise(Watermarked_Image,'speckle',0.011);
        att_name = 'Speckle noise (1.1%)';
    case 23
        image_a = imnoise(Watermarked_Image,'speckle',0.013);
        att_name = 'Speckle noise (1.3%)';
    case 24
        image_a = imnoise(Watermarked_Image,'speckle',0.015);
        att_name = 'Speckle noise (1.5%)';
end