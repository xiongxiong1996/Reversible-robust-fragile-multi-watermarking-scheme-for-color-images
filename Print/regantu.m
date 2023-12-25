hostImg = imread('TI_Lena_color.tiff'); 
% 对宿主图像进行分层
r_l=hostImg(:,:,1);
g_l=hostImg(:,:,2);
b_l=hostImg(:,:,3);

% 鲁棒水印的分块大小
block_size=16; 
% IWT等级
n_level=3;

[perror_sequence_r] = dq_get_preErrorSequence(r_l,block_size,n_level); % R层分块预测误差和序列
[perror_sequence_g] = dq_get_preErrorSequence(g_l,block_size,n_level); % G层分块预测误差和序列
[perror_sequence_b] = dq_get_preErrorSequence(b_l,block_size,n_level); % G层分块预测误差和序列
rgt_r=zeros(32,32);
rgt_g=zeros(32,32);
rgt_b=zeros(32,32);
index=1;
for i=1:32
    for j=1:32
        rgt_r(i,j)=abs(perror_sequence_r(index));
        rgt_g(i,j)=abs(perror_sequence_g(index));
        rgt_b(i,j)=abs(perror_sequence_b(index));
        index=index+1;
    end 
end
h1 = heatmap(rgt_r);
h.CellLabelFormat = '%0.2f';
% h.CellLabelColor = 'none';
colormap(gca, 'parula')
h2 = heatmap(rgt_g);
h.CellLabelFormat = '%0.2f';
% h.CellLabelColor = 'none';
colormap(gca, 'parula')
h3 = heatmap(rgt_b);
h.CellLabelFormat = '%0.2f';
% h.CellLabelColor = 'none';
colormap(gca, 'parula')
