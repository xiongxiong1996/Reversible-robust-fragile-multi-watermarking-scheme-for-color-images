


x2=[0.995539011213857;0.954452318603002;0.924445458925615;0.941955163019906;0.951729292848497;0.928382976852516;0.623676478771806]
x4=[0.993100000000000;0.912400000000000;0.765000000000000;0.735000000000000;0.716600000000000;0.665900000000000;0.672800000000000]
x5=[1.0;0.999200000000000;0.920000000000000;0.643300000000000]
y = 0.9 :-0.1: 0.3;
plot(y,x2,'-x','linewidth', 2);
hold on
y1 = 0.9 :-0.1: 0.3;
plot(y1,x4,'-+');
y2 = 1.0:-0.2:0.4;
plot(y2,x5,'-v');

axis([0 1 0.5 1])
xlabel('QF')
ylabel('NC')
l2 = legend('Proposed','Qingtang Su,2018',	'Lee.,2019','location', 'southeast');
set(l2,'Fontname', 'Times New Roman','FontWeight','bold');
set(gca,'XDir','reverse');



% figure(2)
% 
% img_25=[0.9668,0.926,0.8784,0.9164,0.9405,0.9247,0.586];
% img_26=[0.934,0.8613,0.8386,0.863,0.8207,0.8009,0.814];
% img_27=[0.9196,0.8315,0.78,0.8171,0.8579,0.8708,0.7194];
% img_28=[0.9276,0.9292,0.9148,0.9762,0.9184,0.6987,0.4377];
% a = 0.9 :-0.1: 0.3;
% axis([0 1 0.4 1])
% plot(a,img_25,'-x','linewidth',1.5);
% hold on
% plot(a,img_26,'-+','linewidth',1.5);
% plot(a,img_27,'-v','linewidth',1.5);
% plot(a,img_28,'-o','linewidth',1.5);
% l1 = legend('Lena',	'Baboon',	'Peppers',	'Airplane','location', 'southeast')
% set(l1,'Fontname', 'Times New Roman','FontWeight','bold')
% xlabel('QF')
% ylabel('NC')
% set(gca,'XDir','reverse');

