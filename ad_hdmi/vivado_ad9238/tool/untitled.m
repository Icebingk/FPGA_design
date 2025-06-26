clc;
close all;
clear;
%%triangle wave
k=1/50;
t0=0:1:24;
t1=25:1:49;
a0=k*t0;
a1=k*t1;
t2=50:1:99;
a2=1-k*(t2-50);
a=[a1,a2,a0];
t=[t0,t1,t2];
y0=round(a*1024);
 plot (y0)
 hold on
%%sine wave
 t3=0:1:999;
 A=0.25*sin(2*pi*t3/1000)+0.5;% 1000Hz
y1=round(A*1024);
plot(y1)
%%
l1=length(t);%三角波的长度
l2=length(t3);%正弦波的序列长度


%%生成文件三角波coe文件
fid1=fopen('triwave.coe','w+');
fprintf(fid1,'memory_initialization_radix = 16;\n');
fprintf(fid1,'memory_initialization_vector =\n');
for i=1:l1-1
fprintf(fid1,'%x',y0(i));
fprintf(fid1,',\n');
end
fprintf(fid1,'%x',y0(l1));
fprintf(fid1,';');
fclose(fid1);

%%生成正弦波coe文件
fid1=fopen('sinwave.coe','w+');
fprintf(fid1,'memory_initialization_radix = 16;\n');
fprintf(fid1,'memory_initialization_vector =\n');
for i=1:l2-1
fprintf(fid1,'%x',y1(i));
fprintf(fid1,',\n');
end
fprintf(fid1,'%x',y1(l1));
fprintf(fid1,';');
fclose(fid1);
