%% 1
B_ACC=[0.9832,0.963512,0.9498]
SP_ACC=[0.94658,0.973537,0.9092]
GN_ACC=[0.98336,0.96664,0.9499]
AF_ACC=[0.98314,0.965168,0.9499]
S_ACC=[0.98359,0.967419,0.9499]
C_ACC=[0.98284,0.963108,0.9235]

% 随机块篡改检测柱状图
data_r_acc=[B_ACC;SP_ACC;GN_ACC;AF_ACC;S_ACC;C_ACC];
bar(data_r_acc,0.9);
ylim([0.88 1])
xticklabels({'模糊','椒盐噪声','高斯噪声','均值滤波','锐化','裁剪'})
l=legend('提出的方案','Kamili等人的方案','Duan等人的方案');
xlabel('攻击');
ylabel('准确率(ACC)');
set(l,'Fontsize',12);
set(gca,'FontSize',12)






%% 2

A1_ACC=[0.9949	0.957333 0.9842]
A2_ACC=[0.9906	0.963139	0.994]
A3_ACC=[0.9984	0.980923	0.9929]
A4_ACC=[0.9931	0.970531	0.9809]
A5_ACC=[0.9978	0.985352	0.9953]
A6_ACC=[0.9902	0.97654	0.9653]

% 随机块篡改检测柱状图
data_r_acc=[A1_ACC;A2_ACC;A3_ACC;A4_ACC;A5_ACC;A6_ACC];
bar(data_r_acc,0.9);
ylim([0.88 1])
xticklabels({'目标攻击1','目标攻击2','目标攻击3','目标攻击4','目标攻击5','目标攻击6'})
l=legend('提出的方案','Kamili等人的方案','Duan等人的方案');
xlabel('攻击');
ylabel('准确率(ACC)');
set(l,'Fontsize',12);
set(gca,'FontSize',12)
