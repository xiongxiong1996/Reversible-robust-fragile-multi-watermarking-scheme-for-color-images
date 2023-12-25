function [image_a,att_name] = attacks_filter(Watermarked_Image,Attacks)
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
        h= fspecial('average', [2,2]);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Average filter 2×2';
    case 2        
        h= fspecial('average', [3,3]);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Average filter 3×3';
    case 3        
        h= fspecial('average', [4,4]);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Average filter 4×4';
    case 4       
        h= fspecial('average', [5,5]);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Average filter 5×5';
    case 5       
        h= fspecial('average', [6,6]);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Average filter 6×6';
    case 6      
        h= fspecial('average', [7,7]);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Average filter 7×7';
    case 7     
        h= fspecial('average', [8,8]);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Average filter 8×8';
    case 8      
        h= fspecial('average', [9,9]);
        image_a=imfilter(Watermarked_Image,h);
        att_name='Average filter 9×9';  
    case 9    
        image_a=Watermarked_Image;
        image_a(:,:,1)=medfilt2(Watermarked_Image(:,:,1),[2,2]);
        image_a(:,:,2)=medfilt2(Watermarked_Image(:,:,2),[2,2]);
        image_a(:,:,3)=medfilt2(Watermarked_Image(:,:,3),[2,2]);
        att_name='Median filter 2×2';
    case 10
        image_a=Watermarked_Image;
        image_a(:,:,1)=medfilt2(Watermarked_Image(:,:,1),[3,3]);
        image_a(:,:,2)=medfilt2(Watermarked_Image(:,:,2),[3,3]);
        image_a(:,:,3)=medfilt2(Watermarked_Image(:,:,3),[3,3]);
        att_name='Median filter 3×3';
    case 11
        image_a=Watermarked_Image;
        image_a(:,:,1)=medfilt2(Watermarked_Image(:,:,1),[4,4]);
        image_a(:,:,2)=medfilt2(Watermarked_Image(:,:,2),[4,4]);
        image_a(:,:,3)=medfilt2(Watermarked_Image(:,:,3),[4,4]);
        att_name='Median filter 4×4';
    case 12
        image_a=Watermarked_Image;
        image_a(:,:,1)=medfilt2(Watermarked_Image(:,:,1),[5,5]);
        image_a(:,:,2)=medfilt2(Watermarked_Image(:,:,2),[5,5]);
        image_a(:,:,3)=medfilt2(Watermarked_Image(:,:,3),[5,5]);
        att_name='Median filter 5×5';
    case 13        
        image_a=Watermarked_Image;
        image_a(:,:,1)=medfilt2(Watermarked_Image(:,:,1),[6,6]);
        image_a(:,:,2)=medfilt2(Watermarked_Image(:,:,2),[6,6]);
        image_a(:,:,3)=medfilt2(Watermarked_Image(:,:,3),[6,6]);
        att_name='Median filter 6×6';
    case 14        
        image_a=Watermarked_Image;
        image_a(:,:,1)=medfilt2(Watermarked_Image(:,:,1),[7,7]);
        image_a(:,:,2)=medfilt2(Watermarked_Image(:,:,2),[7,7]);
        image_a(:,:,3)=medfilt2(Watermarked_Image(:,:,3),[7,7]);
        att_name='Median filter 7×7';
    case 15
        image_a=Watermarked_Image;
        image_a(:,:,1)=medfilt2(Watermarked_Image(:,:,1),[8,8]);
        image_a(:,:,2)=medfilt2(Watermarked_Image(:,:,2),[8,8]);
        image_a(:,:,3)=medfilt2(Watermarked_Image(:,:,3),[8,8]);
        att_name='Median filter 8×8';
    case 16
        image_a=Watermarked_Image;
        image_a(:,:,1)=medfilt2(Watermarked_Image(:,:,1),[9,9]);
        image_a(:,:,2)=medfilt2(Watermarked_Image(:,:,2),[9,9]);
        image_a(:,:,3)=medfilt2(Watermarked_Image(:,:,3),[9,9]);
        att_name='Median filter 9×9';
    case 17
        h = fspecial('gaussian',2,0.5);
        image_a = imfilter(Watermarked_Image,h);
        att_name = 'Gaussian LPF 2x2';
    case 18
        h = fspecial('gaussian',3,0.5);
        image_a = imfilter(Watermarked_Image,h);
        att_name = 'Gaussian LPF 3x3';
    case 19
        h = fspecial('gaussian',4,0.5);
        image_a = imfilter(Watermarked_Image,h);
        att_name = 'Gaussian LPF 4x4';
    case 20
        h = fspecial('gaussian',5,0.5);
        image_a = imfilter(Watermarked_Image,h);
        att_name = 'Gaussian LPF 5x5';
    case 21
        h = fspecial('gaussian',6,0.5);
        image_a = imfilter(Watermarked_Image,h);
        att_name = 'Gaussian LPF 6x6';
    case 22
        h = fspecial('gaussian',7,0.5);
        image_a = imfilter(Watermarked_Image,h);
        att_name = 'Gaussian LPF 7x7';
    case 23
        h = fspecial('gaussian',8,0.5);
        image_a = imfilter(Watermarked_Image,h);
        att_name = 'Gaussian LPF 8x8';
    case 24
        h = fspecial('gaussian',9,0.5);
        image_a = imfilter(Watermarked_Image,h);
        att_name = 'Gaussian LPF 9x9';
end