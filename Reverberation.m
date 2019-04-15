%%%  Schroeder混响模型由8个并联的低通梳状滤波器，2个串联的全通滤波器组成(具体模型结构和filter函数参数请见pdf文档)                       
clc;close;clear;
%测试音频
%filename = 'G:\Workfiles\Reverberation\experiment\Algorithm Reverberation\拍手声\clap.wav'
%filename = 'F:\改进Schroeder Reverberation（效果较好）\测试数据\clap.wav';
filename = 'F:\改进Schroeder Reverberation（效果较好）\测试数据\music\See You Again.mp3';
[X,FS]=audioread(filename); % 将 WAV 文件转换成变量
n=8;
%roomsize=input('please input a number between 0 and 1:');
f=0.84*0.8;     %（0.84为控制混响空间大小参数，范围在0-1之间，可调节，越大混响空间越大）
%sound(x,FS);
%signal_out = filter(num,den,signal_in);

x=X([1:length(X)],1);
%x=X([7500+128:7700],1);
%%%%  第一个声道 
%%%%  8th lowpass filter
m1=1557+1;    %回音间隔0.0353
num1 = zeros(m1,1);
num1(m1-1)=1;
num1(m1) = -0.2;   %越大回音越长

den1 = zeros(m1,1);
den1(1)=1;
den1(2)=-0.2;
den1(m1) = -f;   %越大回音越长
lowpass1=filter([1,den1(2)],den1,x/n);

m2=1617+1;    %回音间隔0.0367
num2 = zeros(m2,1);
num2(m2-1)=1;
num2(m2) = -0.2;   %越大回音越长

den2 = zeros(m2,1);
den2(1)=1;
den2(2)=-0.2;
den2(m2) = -f;   %越大回音越长
lowpass2=filter([1,den2(2)],den2,x/n);

m3=1491+1;    %回音间隔0.0338
num3 = zeros(m3,1);
num3(m3-1)=1;
num3(m3) = -0.2;   %越大回音越长

den3 = zeros(m3,1);
den3(1)=1;
den3(2)=-0.2;
den3(m3) = -f;   %越大回音越长
lowpass3=filter([1,den3(2)],den3,x/n);

m4=1422+1;    %回音间隔0.0322
num4 = zeros(m4,1);
num4(m4-1)=1;
num4(m4) = -0.2;   %越大回音越长

den4 = zeros(m4,1);
den4(1)=1;
den4(2)=-0.2;
den4(m4) = -f;   %越大回音越长
lowpass4=filter([1,den4(2)],den4,x/n);

low1=lowpass1+lowpass2+lowpass3+lowpass4;

m5=1277+1;    %回音间隔0.02895
num5 = zeros(m5,1);
num5(m5)=1;
num5(m5) = -0.2;   %越大回音越长

den5 = zeros(m5,1);
den5(1)=1;
den5(2)=-0.2;
den5(m5) = -f;   %越大回音越长
lowpass5=filter([1,den5(2)],den5,x/n);

m6=1356+1;    %回音间隔0.0307
num6 = zeros(m6,1);
num6(m6)=1;
num6(m6) = -0.2;   %越大回音越长

den6 = zeros(m6,1);
den6(1)=1;
den6(2)=-0.2;
den6(m6) = -f;   %越大回音越长
lowpass6=filter([1,den6(2)],den6,x/n);

m7=1188+1;    %回音间隔0.0269
num7 = zeros(m7,1);
num7(m7-1)=1;
num7(m7) = -0.2;   %越大回音越长

den7 = zeros(m7,1);
den7(1)=1;
den7(2)=-0.2;
den7(m7) = -f;   %越大回音越长
lowpass7=filter([1,den7(2)],den7,x/n);

m8=1116+1;    %回音间隔0.0253
num8 = zeros(m8,1);
num8(m8-1)=1;
num8(m8) = -0.2;   %越大回音越长

den8 = zeros(m8,1);
den8(1)=1;
den8(2)=-0.2;
den8(m8) = -f;   %越大回音越长
lowpass8=filter([1,den8(2)],den8,x/n);

low2=lowpass5+lowpass6+lowpass7+lowpass8;
low=low1+low2;
%%%%  the first allpass filter
n1=225+1;  %0.0051
g1=0.5;
numallpass1=zeros(n1,1);
numallpass1(1)=-g1;
numallpass1(n1)=1;

denallpass1=zeros(n1,1);
denallpass1(1)=1;
denallpass1(n1)=-g1;
allpass1=filter(numallpass1,denallpass1,low);
%%%%  the second allpass filter
n2=556+1;   %0.0126
g2=0.5;
numallpass2=zeros(n2,1);
numallpass2(1)=-g2;
numallpass2(n2)=1;

denallpass2=zeros(n2,1);
denallpass2(1)=1;
denallpass2(n2)=-g2;
allpass2=filter(numallpass2,denallpass2,allpass1);

%allpass=allpass4;
%sound(allpass2,FS);
%audiowrite( 'G:\Workfiles\Reverberation\experiment\Algorithm Reverberation\Schroeder Reverberation\yuyin\yuyin_reverb_test.wav',allpass2,FS);
%audiowrite( 'G:\Workfiles\Reverberation\experiment\myreverb\guitar_sound\guitar_reverb_test.wav',allpass,FS);
%audiowrite( 'G:\Workfiles\Reverberation\experiment\Algorithm Reverberation\拍手声\clap_reverb_Schroeder_test.wav',allpass2,FS);

i=23;

y=X([1:length(X)],2);
%y=X([7500+128:7700],2);
%%%%  第二个声道
%%%%  8th lowpass filter
m12=1557+1+i;    %回音间隔0.0353
num12 = zeros(m12,1);
num12(m12-1)=1;
num12(m12) = -0.2;   %越大回音越长

den12 = zeros(m12,1);
den12(1)=1;
den12(2)=-0.2;
den12(m12) = -f;   %越大回音越长
lowpass12=filter([1,den12(2)],den12,y/n);

m22=1617+1+i;    %回音间隔0.0367
num22 = zeros(m22,1);
num22(m22-1)=1;
num22(m22) = -0.2;   %越大回音越长

den22 = zeros(m22,1);
den22(1)=1;
den22(2)=-0.2;
den22(m22) = -f;   %越大回音越长
lowpass22=filter([1,den22(2)],den22,y/n);

m32=1491+1+i;    %回音间隔0.0338
num32 = zeros(m32,1);
num32(m32-1)=1;
num32(m32) = -0.2;   %越大回音越长

den32 = zeros(m32,1);
den32(1)=1;
den32(2)=-0.2;
den32(m32) = -f;   %越大回音越长
lowpass32=filter([1,den32(2)],den32,y/n);

m42=1422+1+i;    %回音间隔0.0322
num42 = zeros(m42,1);
num42(m42-1)=1;
num42(m42) = -0.2;   %越大回音越长

den42 = zeros(m42,1);
den42(1)=1;
den42(2)=-0.2;
den42(m42) = -f;   %越大回音越长
lowpass42=filter([1,den42(2)],den42,y/n);

low12=lowpass12+lowpass22+lowpass32+lowpass42;

m52=1277+1+i;    %回音间隔0.02895
num52 = zeros(m52,1);
num52(m52-1)=1;
num52(m52) = -0.2;   %越大回音越长

den52 = zeros(m52,1);
den52(1)=1;
den52(2)=-0.2;
den52(m52) = -f;   %越大回音越长
lowpass52=filter([1,den52(2)],den52,y/n);

m62=1356+1+i;    %回音间隔0.0307
num62 = zeros(m62,1);
num62(m62-1)=1;
num62(m62) = -0.2;   %越大回音越长

den62 = zeros(m62,1);
den62(1)=1;
den62(2)=-0.2;
den62(m62) = -f;   %越大回音越长
lowpass62=filter([1,den62(2)],den62,y/n);

m72=1188+1+i;    %回音间隔0.0269
num72 = zeros(m72,1);
num72(m72-1)=1;
num72(m72) = -0.2;   %越大回音越长

den72 = zeros(m72,1);
den72(1)=1;
den72(2)=-0.2;
den72(m72) = -f;   %越大回音越长
lowpass72=filter([1,den72(2)],den72,y/n);

m82=1116+1+i;    %回音间隔0.0253
num82 = zeros(m82,1);
num82(m82-1)=1;
num82(m82) = -0.2;   %越大回音越长

den82 = zeros(m82,1);
den82(1)=1;
den82(2)=-0.2;
den82(m82) = -f;   %越大回音越长
lowpass82=filter([1,den82(2)],den82,y/n);

low22=lowpass52+lowpass62+lowpass72+lowpass82;
lowpass=low12+low22;
%%%%  the first allpass filter
n12=225+1+i;  %0.0051
g12=0.5;
numallpass12=zeros(n12,1);
numallpass12(1)=-g12;
numallpass12(n12)=1;

denallpass12=zeros(n12,1);
denallpass12(1)=1;
denallpass12(n12)=-g12;
allpass12=filter(numallpass12,denallpass12,lowpass);
%%%%  the second allpass filter
n22=556+1+i;   %0.0126
g22=0.5;
numallpass22=zeros(n22,1);
numallpass22(1)=-g22;
numallpass22(n22)=1;

denallpass22=zeros(n22,1);
denallpass22(1)=1;
denallpass22(n22)=-g22;
allpass22=filter(numallpass22,denallpass22,allpass12);

allpass=[allpass2,allpass22];

%sound(allpass,FS);
audiowrite('F:\改进Schroeder Reverberation（效果较好）\测试数据\music\See You Again0.84.wav',allpass,FS);
