% -------------------------------------------%
figure(4);
a = [1,2,3,4,5,6,7,8]
pm = [0.9164,0.9340,0.9529,0.9404,0.8439,0.8901,0.8647,0.8699];
m = [0.8552,0.8565,0.8481,0.8668,0.6857,0.7023,0.6907,0.7049];
plot(a,pm,'r- o','LineWidth',1);
hold on;
plot(a,m,'b- x','LineWidth',1);
xlabel('Crop');
ylabel('NC');
legend('proposed method','shaohua 2020','Location','Best');
s = {'25%(1)','25%(2)','25%(3)','25%(4)','50%(1)','50%(2)','50%(3)','50%(4)'}
grid on;
set(gca,'xtick',a);
set(gca,'xticklabel',s);
