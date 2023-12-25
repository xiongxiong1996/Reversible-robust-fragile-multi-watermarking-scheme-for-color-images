% function crcout = qyh_crc2(datain,tempstr,initdata,refin,refout,xorout)
function encoded = qyh_crc2(crc_din)
%cala crc
%author ******
%parameter: initdata --xor the fisrt reg; refin --- the datain need reflect
%refout: out crc need reflect; xorout--- crc reg xor xorout
% initdata ---- 寄存器（crc）初始化预置值
% REFIN：待测数据的每个字节是否按位反转
% REFOUT：在计算后之后，异或输出之前，整个数据是否按位反转
% XOROUT：计算结果与此参数异或         得到最终的CRC值。 
 h = crc.generator('Polynomial',[1 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0 1],'InitialState',[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0],'FinalXOR',[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]);

%这个多项式为x^16+x^15+x^2+1，注意后面’InitialState’和’FinalXOR’的值都是16个0.

% 1100111
% crc_din = 103;%这里是十进制，而且可以用load一个文件后面的几行就是为了文件而处理的load一个

% 1110011
% crc_din = 115;%这里是十进制，而且可以用load一个文件后面的几行就是为了文件而处理的load一个

crc_din_bi = de2bi(crc_din);%转换成2位的二进制，后面的2指的是2位

crc_din_trans = transpose(crc_din_bi);%这个函数的意思就是把crc_din_bi这个矩阵翻转，比如原来crc_din_bi是一个1x2的矩阵，翻转后变成2x1，前面是行数，后面是列数

crc_din_trans_reshape = reshape(crc_din_trans,[],1);%中间是一个方括号。reshaple的意思是把一个矩阵串起来，按照一列串起来

encoded = generate(h,crc_din_trans_reshape);%执行CRC

end
