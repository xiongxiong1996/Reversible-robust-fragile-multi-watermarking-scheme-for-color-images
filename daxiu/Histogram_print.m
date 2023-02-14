GN_ber=[0.00097,0.0212,0.033203]
SP_ber=[0.0137,0.1106,0.173828]
SN_ber=[0.0313,0.0994,0.124023]
AF_ber=[0.0029,0.085,0.007813]
MF_ber=[0.0068,0.1008,0.013672]
GLPF_ber=[0,0,0]


% ber柱状图
data_ber=[GN_ber;SP_ber;SN_ber;AF_ber;MF_ber;GLPF_ber];
bar(data_ber,0.9);
xticklabels({'Gaussian noise (0.1%)','Salt-pepper noise (1%)','Speckle noise (1%)','Average filter','Median filter','Gaussian LPF'})
legend('Proposed method','[12]','[35]');
xlabel('Attack');
ylabel('BER');


GN_nc=[0.9985,0.9849,0.950394]
SP_nc=[0.979,0.9198,0.756765]
SN_nc=[0.9515,0.9281,0.823112]
AF_nc=[0.9955,0.9388,0.98817]
MF_nc=[0.9896,0.9273,0.979171]
GLPF_nc=[1,1,1]
% nc柱状图
data_nc=[GN_nc;SP_nc;SN_nc;AF_nc;MF_nc;GLPF_nc];
bar(data_nc,0.9);
ylim([0.7 1])
xticklabels({'Gaussian noise (0.1%)','Salt-pepper noise (1%)','Speckle noise (1%)','Average filter','Median filter','Gaussian LPF'})
legend('Proposed method','[12]','[35]');
xlabel('Attack');
ylabel('NC');





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
xticklabels({'Blurring','Salt and pepper noise','Gaussian noise','Average filter','Sharpening','Cropping'})
legend('Proposed method','[12]','[35]');
xlabel('Attack');
ylabel('ACC');









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
legend('Proposed method','[12]','[35]');
xlabel('Attack');
ylabel('ACC');
