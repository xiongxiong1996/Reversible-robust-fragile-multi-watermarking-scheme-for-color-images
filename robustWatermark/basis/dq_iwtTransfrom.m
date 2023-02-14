% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% %%%  Copyright (C) 2021  Duan shaohua                                  %%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [ll, lh, hl, hh] = dq_iwtTransfrom(block)
% % DQ_IWTTRANSFROM Summary of this function goes here
% % 用于IWT变换
% %   Detailed explanation goes here
% % 输入：block----------需要进行IWT变换的块
% % 输出：ll, lh, hl, hh----------进行IWT变换后的频域LL LH HI HH
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [img, lh, hl, hh]=dq_iwtTransfrom(img,n)
    img=double(img);
    [N,N]=size(img);
    ll=cell(1,3);
    lh=cell(1,3);
    hl=cell(1,3);
    hh=cell(1,3);
    for i=1:n
        imgwave1=lwavedec2(img,N);
        M=N/2;
        ll{i}=imgwave1(1:M,1:M);
        lh{i}=imgwave1(M+1:N,1:M);
        hl{i}=imgwave1(1:M,M+1:N);
        hh{i}=imgwave1(M+1:N,M+1:N);
        img=ll{i};
        N=N/2;
    end
    % imgwave1=lwavedec2_26(img,N);
end

%********************************************************************%
%***********************    2/6小波变换    **************************%
%********************************************************************%
function f_row=lwavedec2_26(image,N)
f=image;
T=N/2;               %  子图像维数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   1.列变换
%  A.分裂（奇偶分开）
f1=f([1:2:N-1],:);  %  奇数
f2=f([2:2:N],:);    %  偶数
%  C.更新
for i_lc=1:T;
    low_frequency_column(i_lc,:)=f2(i_lc,:)+ceil(((f1(i_lc,:)-f2(i_lc,:)))/2);
end;
%  B.预测
low_frequency_column(T+1,:)=low_frequency_column(1,:);  %  补行
% 第一行单独处理
high_frequency_column(1,:)=f1(1,:)-f2(1,:)+ceil((low_frequency_column(T,:)-low_frequency_column(2,:))/4+1/2);
for i_hc=2:T;
    high_frequency_column(i_hc,:)=f1(i_hc,:)-f2(i_hc,:)+ceil((low_frequency_column(i_hc-1,:)-low_frequency_column(i_hc+1,:))/4+1/2);
end;
%  D.合并
f_column([1:1:T],:)=low_frequency_column([1:T],:);
f_column([T+1:1:N],:)=high_frequency_column([1:T],:);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   2.行变换
%  A.分裂（奇偶分开）
f1=f_column(:,[1:2:N-1]);  %  奇数
f2=f_column(:,[2:2:N]);    %  偶数
%  C.更新
for i_lr=1:T;
    low_frequency_row(:,i_lr)=f2(:,i_lr)+ceil((f1(:,i_lr)-f2(:,i_lr))/2);
end;
%  B.预测
low_frequency_row(:,T+1)=low_frequency_row(:,1);  %  补行
% 第一行单独处理
high_frequency_row(:,1)=f1(:,1)-f2(:,1)+ceil((low_frequency_row(:,T)-low_frequency_row(:,2))/4+1/2);
for i_hr=2:T;
    high_frequency_row(:,i_hr)=f1(:,i_hr)-f2(:,i_hr)+ceil((low_frequency_row(:,i_hr-1)-low_frequency_row(:,i_hr+1))/4+1/2);
end;
% high_frequency_row(:,T)=high_frequency_row(:,1);  %  补行
%  D.合并
f_row(:,[1:1:T])=low_frequency_row(:,[1:T]);
f_row(:,[T+1:1:N])=high_frequency_row(:,[1:T]);
end






%********************************************************************%
%************************    S小波变换    ***************************%
%********************************************************************%
function f_row=lwavedec2(image,N)
f=image;
T=N/2;               %  子图像维数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   1.列变换

%  A.分裂（奇偶分开）

f1=f([1:2:N-1],:);  %  奇数
f2=f([2:2:N],:);    %  偶数

% f1(:,T+1)=f1(:,1);  %  补列
% f2(T+1,:)=f2(1,:);  %  补行

%  B.预测

for i_hc=1:T;
    high_frequency_column(i_hc,:)=f1(i_hc,:)-f2(i_hc,:);
end;

% high_frequency_column(T+1,:)=high_frequency_column(1,:);  %  补行

%  C.更新

for i_lc=1:T;
    low_frequency_column(i_lc,:)=f2(i_lc,:)+ceil(1/2*high_frequency_column(i_lc,:));
end;

%  D.合并
f_column([1:1:T],:)=low_frequency_column([1:T],:);
f_column([T+1:1:N],:)=high_frequency_column([1:T],:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   2.行变换
%  A.分裂（奇偶分开）
f1=f_column(:,[1:2:N-1]);  %  奇数
f2=f_column(:,[2:2:N]);    %  偶数
% f2(:,T+1)=f2(:,1);    %  补行
%  B.预测
for i_hr=1:T;
    high_frequency_row(:,i_hr)=f1(:,i_hr)-f2(:,i_hr);
end;
% high_frequency_row(:,T+1)=high_frequency_row(:,1);  %  补行
%  C.更新
for i_lr=1:T;
    low_frequency_row(:,i_lr)=f2(:,i_lr)+ceil(1/2*high_frequency_row(:,i_lr));
end;
%  D.合并
f_row(:,[1:1:T])=low_frequency_row(:,[1:T]);
f_row(:,[T+1:1:N])=high_frequency_row(:,[1:T]);
end