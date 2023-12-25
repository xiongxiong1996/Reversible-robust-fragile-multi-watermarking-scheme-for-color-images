B=[1,1,1,1;1,1,1,1;1,1,1,1;1,1,1,1];
[block_p,bool]=qyh_blockEmbed(B,4,5,5);
B2=qyh_blockRecover(block_p,4,5,5,0);