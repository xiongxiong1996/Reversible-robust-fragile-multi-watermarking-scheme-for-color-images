% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%  Copyright (C) 2021  Qian yuhan                                    %%%
% % %%%  Copyright (C) 2021  Duan shaohua                                  %%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [img]=dq_inverIwtTransform(img,lh,hl,hh,n)
    [M,M]=size(img);
    N=2*M;
    for i=n:-1:1
        M=N/2;
        imgwave1(1:M,1:M)=img;
        imgwave1(M+1:N,1:M)=lh{i};
        imgwave1(1:M,M+1:N)=hl{i};
        imgwave1(M+1:N,M+1:N)=hh{i};
        img=lwaverec2(imgwave1,N);
        N=N*2;
    end
    % img=lwaverec2_26(imgwave1,N);
end
%********************************************************************%
%***********************    2/6小波变换    **************************%
%********************************************************************%
function f_column=lwaverec2_26(f_row,N);
T=N/2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%反变换%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   1.行变换
%   A.提取（低频高频分开）
f1=f_row(:,[T+1:1:N]);  %  高频 奇数
f2=f_row(:,[1:1:T]);    %  低频 偶数
%  B.更新
f2(:,T+1)=f2(:,1);  % 补行
% 第一行单独处理 !!!!!!! 此处要用floor，前面用ceil，这里用floor。
low_frequency_row(:,1)=floor((2*f2(:,1)-f1(:,1)+ceil(((f2(:,T)-f2(:,2))/4)+1/2))/2);
for i_lr=2:T;
    low_frequency_row(:,i_lr)=floor((2*f2(:,i_lr)-f1(:,i_lr)+ceil(((f2(:,i_lr-1)-f2(:,i_lr+1))/4)+1/2))/2);
end;
%  C.预测
% 第一行单独处理
high_frequency_row(:,1)=low_frequency_row(:,1)+f1(:,1)-ceil((((f2(:,T))-(f2(:,2)))/4)+1/2);
for i_hr=2:T;
    high_frequency_row(:,i_hr)=low_frequency_row(:,i_hr)+f1(:,i_hr)-ceil((((f2(:,i_hr-1))-(f2(:,i_hr+1)))/4)+1/2);
end;
%  D.合并(奇偶分开合并)
f_row(:,[2:2:N])=low_frequency_row(:,[1:T]);
f_row(:,[1:2:N-1])=high_frequency_row(:,[1:T]);    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   2.列变换
%  A.提取（低频高频分开
f1=f_row([T+1:1:N],:);  %  奇数 高频
f2=f_row([1:1:T],:);    %  偶数 低频
%  B.更新
f2(T+1,:)=f2(1,:);  % 补行
% 第一行单独处理
low_frequency_column(1,:)=floor((2*f2(1,:)-f1(1,:)+ceil(((f2(T,:)-f2(2,:))/4)+1/2))/2);
for i_lc=2:T;
    low_frequency_column(i_lc,:)=floor((2*f2(i_lc,:)-f1(i_lc,:)+ceil(((f2(i_lc-1,:)-f2(i_lc+1,:))/4)+1/2))/2);
end;
%  C.预测
% 第一行单独处理
high_frequency_column(1,:)=low_frequency_column(1,:)+f1(1,:)-ceil((((f2(T,:))-(f2(2,:)))/4)+1/2);
for i_hc=2:T;
    high_frequency_column(i_hc,:)=low_frequency_column(i_hc,:)+f1(i_hc,:)-ceil((((f2(i_hc-1,:))-(f2(i_hc+1,:)))/4)+1/2);
end;
%  D.合并(奇偶分开合并）
f_column([2:2:N],:)=low_frequency_column([1:T],:);
f_column([1:2:N-1],:)=high_frequency_column([1:T],:);
end











%********************************************************************%
%********************************************************************%
%************************    S小波变换    ***************************%
%********************************************************************%

function f_column=lwaverec2(f_row,N);
T=N/2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   1.行变换
%   A.提取（低频高频分开）
f1=f_row(:,[T+1:1:N]);  %  奇数
f2=f_row(:,[1:1:T]);    %  偶数
%  B.更新
for i_lr=1:T;
    low_frequency_row(:,i_lr)=f2(:,i_lr)-ceil(1/2*f1(:,i_lr));
end;
%  C.预测
for i_hr=1:T;
    high_frequency_row(:,i_hr)=f1(:,i_hr)+low_frequency_row(:,i_hr);
end;
%  D.合并(奇偶分开合并)
f_row(:,[2:2:N])=low_frequency_row(:,[1:T]);
f_row(:,[1:2:N-1])=high_frequency_row(:,[1:T]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   2.列变换
%  A.提取（低频高频分开）
f1=f_row([T+1:1:N],:);  %  奇数
f2=f_row([1:1:T],:);    %  偶数
%  B.更新
for i_lc=1:T;
    low_frequency_column(i_lc,:)=f2(i_lc,:)-ceil(1/2*f1(i_lc,:));
end;
%  C.预测
for i_hc=1:T;
    high_frequency_column(i_hc,:)=f1(i_hc,:)+low_frequency_column(i_hc,:);
end;
%  D.合并(奇偶分开合并）
f_column([2:2:N],:)=low_frequency_column([1:T],:);
f_column([1:2:N-1],:)=high_frequency_column([1:T],:);
end
