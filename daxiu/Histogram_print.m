%% 1

% 随机块篡改检测柱状图
data_r_acc=[B_ACC;SP_ACC;GN_ACC;AF_ACC;S_ACC;C_ACC];
bar(data_r_acc,0.9);
ylim([0.88 1])
xticklabels({'模糊','椒盐噪声','高斯','Average filter','Sharpening','Cropping'})
legend('提出的方案','Kamili等人的方案','Duan等人的方案');
xlabel('攻击');
ylabel('准确率(ACC)');







%% 2

A1_ACC=[0.99949	0.957333 0.9842]
A2_ACC=[1	0.963139	0.994]
A3_ACC=[1	0.980923	0.9929]
A4_ACC=[1	0.970531	0.9809]
A5_ACC=[1	0.985352	0.9953]
A6_ACC=[1	0.97654	0.9653]

% 随机块篡改检测柱状图
data_r_acc=[A1_ACC;A2_ACC;A3_ACC;A4_ACC;A5_ACC;A6_ACC];
bar(data_r_acc,0.9);
ylim([0.88 1])
xticklabels({'Object Attack1','Object Attack2','Object Attack3','Object Attack4','Object Attack5','Object Attack6'})
legend('Proposed method','Kamili et la.[9]','Duan et la[11]');
xlabel('Attack');
ylabel('ACC');
