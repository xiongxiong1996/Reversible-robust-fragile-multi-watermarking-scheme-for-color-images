clc;clear;
% -------------------------------------------------------------%
% Gaussian noise
% -------------------------------------------------------------%
list=xlsread('noise_list.xls');

subplot(3,2,1);
a = [1,2,3,4];
P_lena_ber = list(1:1:4,1);
P_lena_nc = list(1:1:4,2);
O_lena_ber = list(1:1:4,3);
O_lena_nc = list(1:1:4,4);

P_air_ber = list(1:1:4,5);
P_air_nc = list(1:1:4,6);
O_air_ber = list(1:1:4,7);
O_air_nc = list(1:1:4,8);

% yyaxis left
plot(a,P_lena_ber,'b-o','LineWidth',1);
hold on;
plot(a,O_lena_ber,'r-.o','LineWidth',1);
plot(a,P_air_ber,'b-x','LineWidth',1);
plot(a,O_air_ber,'r-.x','LineWidth',1);
xlabel('Gaussian noise');
ylabel('BER');
legend('Lena proposed method','Lnea shaohua.etl 2020','Airplane proposed method','Airplane shaohua.etl 2020','Location','Best');
s = {'0.1%','0.5%','1%','2%'}
grid on;
set(gca,'xtick',a);
set(gca,'xticklabel',s);
% -------------------------------------------------------------%
subplot(3,2,2);
% yyaxis left
plot(a,P_lena_nc,'b-o','LineWidth',1);
hold on;
plot(a,O_lena_nc,'r-.o','LineWidth',1);
plot(a,P_air_nc,'b-x','LineWidth',1);
plot(a,O_air_nc,'r-.x','LineWidth',1);
xlabel('Gaussian noise');
ylabel('NC');
legend('Lena proposed method','Lnea shaohua.etl 2020','Airplane proposed method','Airplane shaohua.etl 2020','Location','Best');
s = {'0.1%','0.5%','1%','2%'}
grid on;
set(gca,'xtick',a);
set(gca,'xticklabel',s);






% -------------------------------------------------------------%
% Salt-pepper noise
% -------------------------------------------------------------%

subplot(3,2,3);
a = [1,2,3,4,5];
P_lena_ber = list(7:1:11,1);
P_lena_nc = list(7:1:11,2);
O_lena_ber = list(7:1:11,3);
O_lena_nc = list(7:1:11,4);

P_air_ber = list(7:1:11,5);
P_air_nc = list(7:1:11,6);
O_air_ber = list(7:1:11,7);
O_air_nc = list(7:1:11,8);

% yyaxis left
plot(a,P_lena_ber,'b-o','LineWidth',1);
hold on;
plot(a,O_lena_ber,'r-.o','LineWidth',1);
plot(a,P_air_ber,'b-x','LineWidth',1);
plot(a,O_air_ber,'r-.x','LineWidth',1);
xlabel('Salt-pepper noise');
ylabel('BER');
legend('Lena proposed method','Lnea shaohua.etl 2020','Airplane proposed method','Airplane shaohua.etl 2020','Location','Best');
s = {'0.1%','0.5%','1%','2%','5%'}
grid on;
set(gca,'xtick',a);
set(gca,'xticklabel',s);
% -------------------------------------------------------------%
subplot(3,2,4);
% yyaxis left
plot(a,P_lena_nc,'b-o','LineWidth',1);
hold on;
plot(a,O_lena_nc,'r-.o','LineWidth',1);
plot(a,P_air_nc,'b-x','LineWidth',1);
plot(a,O_air_nc,'r-.x','LineWidth',1);
xlabel('Salt-pepper noise');
ylabel('NC');
legend('Lena proposed method','Lnea shaohua.etl 2020','Airplane proposed method','Airplane shaohua.etl 2020','Location','Best');
s = {'0.1%','0.5%','1%','2%','5%'}
grid on;
set(gca,'xtick',a);
set(gca,'xticklabel',s);

% -------------------------------------------------------------%
% Speckle noise
% -------------------------------------------------------------%

subplot(3,2,5);
a = [1,2,3,4,5];
P_lena_ber = list(13:1:17,1);
P_lena_nc = list(13:1:17,2);
O_lena_ber = list(13:1:17,3);
O_lena_nc = list(13:1:17,4);

P_air_ber = list(13:1:17,5);
P_air_nc = list(13:1:17,6);
O_air_ber = list(13:1:17,7);
O_air_nc = list(13:1:17,8);

% yyaxis left
plot(a,P_lena_ber,'b-o','LineWidth',1);
hold on;
plot(a,O_lena_ber,'r-o','LineWidth',1);
plot(a,P_air_ber,'b-x','LineWidth',1);
plot(a,O_air_ber,'r-x','LineWidth',1);
xlabel('Speckle noise');
ylabel('BER');
legend('Lena proposed method','Lnea shaohua.etl 2020','Airplane proposed method','Airplane shaohua.etl 2020','Location','Best');
s = {'0.1%','0.5%','1%','2%','5%'}
grid on;
set(gca,'xtick',a);
set(gca,'xticklabel',s);
% -------------------------------------------------------------%
subplot(3,2,6);
% yyaxis left
plot(a,P_lena_nc,'b-o','LineWidth',1);
hold on;
plot(a,O_lena_nc,'r-o','LineWidth',1);
plot(a,P_air_nc,'b-x','LineWidth',1);
plot(a,O_air_nc,'r-x','LineWidth',1);
xlabel('Speckle noise');
ylabel('NC');
legend('Lena proposed method','Lnea shaohua.etl 2020','Airplane proposed method','Airplane shaohua.etl 2020','Location','Best');
s = {'0.1%','0.5%','1%','2%','5%'}
grid on;
set(gca,'xtick',a);
set(gca,'xticklabel',s);


% 
% subplot(3,2,1);imshow('fig1.jpg');
% subplot(3,2,2);imshow('fig2.jpg');
% subplot(3,2,3);imshow('fig3.jpg');
% subplot(3,2,4);imshow('fig4.jpg');
% subplot(3,2,5);imshow('fig5.jpg');
% subplot(3,2,6);imshow('fig6.jpg');
% 
