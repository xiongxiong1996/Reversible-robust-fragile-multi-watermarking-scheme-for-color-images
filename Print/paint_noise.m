clc;clear;
subplot(2,2,1);
% -------------------------------------------------------------%
% Gaussian noise
% -------------------------------------------------------------%
list=xlsread('compare_noise.xls');
a11=list(3:10,1)
a12=list(3:10,2)
b11=list(3:10,3)
b12=list(3:10,4)
c11=list(3:10,5)
c12=list(3:10,6)
x = [0.01 0.03 0.05 0.07 0.09 0.11 0.13 0.15];
plot(x,a11,'r-o','LineWidth',1);
hold on;
plot(x,c11,'g-*','LineWidth',1);
plot(x,b11,'b-x','LineWidth',1);
xlabel('高斯噪声强度');
ylabel('准确率(NC)');
legend('提出的方案','Su等人的方案','Duan等人的方案','Location','SouthWest');
% a = [1,2,3,4,5,6,7,8];
s = {'0.01%','0.03%','0.05%','0.07%','0.09%','0.11%','0.13%','0.15%'}
grid on;
set(gca,'xtick',x);
set(gca,'xticklabel',s);
% title('')


subplot(2,2,2);
% -------------------------------------------------------------%
% Gaussian noise
% -------------------------------------------------------------%
list=xlsread('compare_noise.xls');
a11=list(3:10,1)
a12=list(3:10,2)
b11=list(3:10,3)
b12=list(3:10,4)
c11=list(3:10,5)
c12=list(3:10,6)
x = [0.01 0.03 0.05 0.07 0.09 0.11 0.13 0.15];
plot(x,a12,'r-o','LineWidth',1);
hold on;
plot(x,c12,'g-*','LineWidth',1);
plot(x,b12,'b-x','LineWidth',1);
xlabel('高斯噪声强度');
ylabel('误码率(BER)');
legend('提出的方案','Su等人的方案','Duan等人的方案','Location','NorthWest');
% a = [1,2,3,4,5,6,7,8];
s = {'0.01%','0.03%','0.05%','0.07%','0.09%','0.11%','0.13%','0.15%'}
grid on;
set(gca,'xtick',x);
set(gca,'xticklabel',s);
% title('')



subplot(2,2,3);
% -------------------------------------------------------------%
% Salt-pepper noise
% -------------------------------------------------------------%
list=xlsread('compare_noise.xls');
a21=list(11:18,1)
a22=list(11:18,2)
b21=list(11:18,3)
b22=list(11:18,4)
c21=list(11:18,5)
c22=list(11:18,6)
x = [0.01 0.03 0.05 0.07 0.09 0.11 0.13 0.15];
plot(x,a21,'r-o','LineWidth',1);
hold on;
plot(x,c21,'g-*','LineWidth',1);
plot(x,b21,'b-x','LineWidth',1);
xlabel('椒盐噪声强度');
ylabel('准确率(NC)');
legend('提出的方案','Su等人的方案','Duan等人的方案','Location','SouthWest');
% a = [1,2,3,4,5,6,7,8];
s = {'0.01%','0.03%','0.05%','0.07%','0.09%','0.11%','0.13%','0.15%'}
grid on;
set(gca,'xtick',x);
set(gca,'xticklabel',s);

subplot(2,2,4);
% -------------------------------------------------------------%
% Salt-pepper noise
% -------------------------------------------------------------%
list=xlsread('compare_noise.xls');
a21=list(11:18,1)
a22=list(11:18,2)
b21=list(11:18,3)
b22=list(11:18,4)
c21=list(11:18,5)
c22=list(11:18,6)
x = [0.01 0.03 0.05 0.07 0.09 0.11 0.13 0.15];
plot(x,a22,'r-o','LineWidth',1);
hold on;
plot(x,c22,'g-*','LineWidth',1);
plot(x,b22,'b-x','LineWidth',1);
xlabel('椒盐噪声强度');
ylabel('误码率(BER)');
legend('提出的方案','Su等人的方案','Duan等人的方案','Location','NorthWest');
% a = [1,2,3,4,5,6,7,8];
s = {'0.01%','0.03%','0.05%','0.07%','0.09%','0.11%','0.13%','0.15%'}
grid on;
set(gca,'xtick',x);
set(gca,'xticklabel',s);


% subplot(3,2,5);
% % -------------------------------------------------------------%
% % Salt-pepper noise
% % -------------------------------------------------------------%
% list=xlsread('compare_noise.xls');
% a31=list(19:26,1)
% a32=list(19:26,2)
% b31=list(19:26,3)
% b32=list(19:26,4)
% c31=list(19:26,5)
% c32=list(19:26,6)
% x = [0.01 0.03 0.05 0.07 0.09 0.11 0.13 0.15];
% plot(x,a31,'r-o','LineWidth',1);
% hold on;
% plot(x,c31,'g-*','LineWidth',1);
% plot(x,b31,'b-x','LineWidth',1);
% xlabel('Gaussian noise intensity');
% ylabel('NC');
% legend('proposed method','[35]','[14]','Location','Best');
% % a = [1,2,3,4,5,6,7,8];
% s = {'0.01%','0.03%','0.05%','0.07%','0.09%','0.11%','0.13%','0.15%'}
% grid on;
% set(gca,'xtick',x);
% set(gca,'xticklabel',s);
% 


% 
% subplot(3,2,1);imshow('fig1.jpg');
% subplot(3,2,2);imshow('fig2.jpg');
% subplot(3,2,3);imshow('fig3.jpg');
% subplot(3,2,4);imshow('fig4.jpg');
% subplot(3,2,5);imshow('fig5.jpg');
% subplot(3,2,6);imshow('fig6.jpg');
% 
