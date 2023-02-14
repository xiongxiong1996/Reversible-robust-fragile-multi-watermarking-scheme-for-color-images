% for i=8:1:28
%     [best_list] = findB(i);
% end

for i =1:50
    a(i,1)=i;
end

yy=-1*ones(1,50); 
plot(a,yy,'LineWidth',1); 
hold on;
% for j=1:1:4
%     best_list=xlsread(['best_list_',num2str(j,'%02d'),'.xls']);
%     plot(a,best_list(1:1:50,5),'LineWidth',1);
%     hold on;
% end
% for j=6:1:7
%     best_list=xlsread(['best_list_',num2str(j,'%02d'),'.xls']);
%     plot(a,best_list(1:1:50,5),'LineWidth',1);
%     hold on;
% end
% for j=9:1:19
%     best_list=xlsread(['best_list_',num2str(j,'%02d'),'.xls']);
%     plot(a,best_list(1:1:50,5),'LineWidth',1);
%     hold on;
% end
% for j=21:1:28
%     best_list=xlsread(['best_list_',num2str(j,'%02d'),'.xls']);
%     plot(a,best_list(1:1:50,5),'LineWidth',1);
%     hold on;
% end

for j=25:1:28
    best_list=xlsread(['image_',num2str(j,'%02d'),'.xls']);
    plot(a,best_list(1:1:50,5),'LineWidth',1);
    hold on;
end
xlabel('G');
ylabel('Targe');
