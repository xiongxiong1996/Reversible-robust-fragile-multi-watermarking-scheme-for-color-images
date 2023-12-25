subplot(2,2,1);
x1=[1;0.995539011;0.954452319;0.924445459;0.941955163;0.951729293;0.928382977]
x2=[1;0.9931;0.9124;0.765;0.735;0.7166;0.6659]
y = 1.0 :-0.1: 0.4;
plot(y,x1,'b-x','linewidth', 1);
hold on
y1 = 1.0 :-0.1: 0.4;
plot(y1,x2,'r-o','linewidth', 1);
axis([0.4 1 0.5 1])
xlabel('QF')
ylabel('NC')
l2 = legend('Proposed','Su et al.[5]','location', 'southeast');
set(l2,'Fontname', 'Times New Roman','FontWeight','bold');
set(gca,'XDir','reverse');
title('Lena')



	
	
	
	
	
subplot(2,2,2);
x3=[1;0.949777422;0.893431354;0.838608428;0.863022086;0.835128847;0.800885813]
x4=[1;0.9793;0.9255;0.7719;0.7512;0.6959;0.7211]
y = 1.0 :-0.1: 0.4;
plot(y,x3,'b-x','linewidth', 1);
hold on
y1 = 1.0 :-0.1: 0.4;
plot(y1,x4,'r-o','linewidth', 1);
axis([0.4 1 0.5 1])
xlabel('QF')
ylabel('NC')
l2 = legend('Proposed','Su et al.[5]','location', 'southeast');
set(l2,'Fontname', 'Times New Roman','FontWeight','bold');
set(gca,'XDir','reverse');
title('Baboon')

subplot(2,2,3);
x5=[1;0.997028225;0.986556521;0.952941481;0.98956426;0.967104881;0.818120042]
x6=[1;0.9839;0.9286;0.8111;0.7419;0.6959;0.7212]
y = 1.0 :-0.1: 0.4;
plot(y,x5,'b-x','linewidth', 1);
hold on
y1 = 1.0 :-0.1: 0.4;
plot(y1,x6,'r-o','linewidth', 1);
axis([0.4 1 0.5 1])
xlabel('QF')
ylabel('NC')
l2 = legend('Proposed','Su et al.[5]','location', 'southeast');
set(l2,'Fontname', 'Times New Roman','FontWeight','bold');
set(gca,'XDir','reverse');
title('Airplane')

	
	
	
	
	
	

subplot(2,2,4);
x7=[1;0.919623656;0.831501448;0.820756899;0.817133782;0.883467436;0.897830419]
x8=[1;0.9954;0.9539;0.8341;0.7857;0.6659;0.7097]
y = 1.0 :-0.1: 0.4;
plot(y,x7,'b-x','linewidth', 1);
hold on
y1 = 1.0 :-0.1: 0.4;
plot(y1,x8,'r-o','linewidth', 1);
axis([0.4 1 0.5 1])
xlabel('QF')
ylabel('NC')
l2 = legend('Proposed','Su et al.[5]','location', 'southeast');
set(l2,'Fontname', 'Times New Roman','FontWeight','bold');
set(gca,'XDir','reverse');
title('Peppers')