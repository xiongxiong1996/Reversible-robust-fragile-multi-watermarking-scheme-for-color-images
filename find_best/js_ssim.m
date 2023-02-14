

% for j=1:28
%     index_img=j;
%     best_list=xlsread(['best_list_',num2str(index_img,'%02d'),'.xls']);
%     target = best_list(:,5);
%     psnr1 = best_list(:,3);
%     avg_nc = best_list(:,4);
%     ssim1=(-1*target-0.3*psnr1/40-0.5*avg_nc)*5;
%     best_list(:,7)=ssim1
%     xlswrite(['list_',num2str(index_img,'%02d'),'.xls'],best_list);
% end


for j=1:1:28
    index_img=j;
    best_list=xlsread(['list_',num2str(index_img,'%02d'),'.xls']);
    psnr1 = best_list(:,3);
    avg_nc = best_list(:,4);
    ssim1 = best_list(:,7);
    target2=0.2*ssim1+0.5*avg_nc+0.3*psnr1/45;
    best_list(:,6)=target2;
    plot(best_list(1:35,2),best_list(1:35,6));
end

    