function crcout = qyh_crc(datain,tempstr,initdata,refin,refout,xorout)
%cala crc
%author ******
%parameter: initdata --xor the fisrt reg; refin --- the datain need reflect
%refout: out crc need reflect; xorout--- crc reg xor xorout
% initdata ---- 寄存器（crc）初始化预置值
% REFIN：待测数据的每个字节是否按位反转
% REFOUT：在计算后之后，异或输出之前，整个数据是否按位反转
% XOROUT：计算结果与此参数异或         得到最终的CRC值。 
mcrctemp = uint32(bin2dec(tempstr)); % 变成了十进制  11011->27
len = length(tempstr);
size = length(datain); % 输入数据的size
for i = 0:(fix(len/8)+1) % 向0靠近取整 mcrctemp
    datain(end+1) = 0;
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
if refin ~= 0
    datain = reflect(datain , 8);
end
%andvalue = num2str(uint8(zeros(1,len+1)));
%andvalue(len+1) = '1';
andvalue = bitshift(1,len);
midout = uint32(0);
for i = 0:(((size*8)-1)+len)
    midout = bitshift(midout,1);  
    if bitand(datain((fix(i/8)+1)),bitshift(1,7-rem(i,8))) ~= 0
        midout = bitor(midout,1);
    end
    if i == len-1
        midout = bitxor(midout,initdata);
    end
    if bitand(midout,andvalue)~=0 
        midout = bitxor(midout,mcrctemp);
    end
%    dec2bin(midout)
end
if refout ~= 0
    midout = reflect(midout,len);
end
midout = bitxor(midout,xorout);
andvalue = bitshift(4294967295,len-32);
crcout = bitand(midout,andvalue);
end   

function outdata=reflect(data,bitnum)
%reflect this data
%paramter explain: bitnum reflect bit number
size=length(data);
outdata = zeros(1,size);
mvalue = bitshift(4294967295,bitnum);
for i = 1:size
    outdata(i) = data(i);
    outdata(i) = bitand(outdata(i),mvalue);
    for j=0:(bitnum-1)
        if bitand(data(i),bitshift(1,j)) ~= 0
            outdata(i) = bitor(outdata(i),bitshift(1,bitnum -1 - j));
        end
    end
end
end
