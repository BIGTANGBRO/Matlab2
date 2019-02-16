clear
clc
load('delrin.mat');
load('al.mat');
load('cf.mat');
load('time_al.mat');
load('time_delrin.mat');
load('time_cf.mat');
E_delrin=table2array(G1Copy1(1:551,1));
F_delrin=table2array(G1Copy1(1:551,2));
E_cf=table2array(G1(1:202,1));
F_cf=table2array(G1(1:202,2));
E_al=table2array(G1CopyCopy(1:344,1));
F_al=table2array(G1CopyCopy(1:344,2));                   

strain_delrin=E_delrin./20;
stress_delrin=F_delrin./(12.19*1.02*0.000000001);
strain_cf=E_cf./80;
stress_cf=F_cf./(10.05*0.9*0.000000001);
strain_al=E_al./50;
stress_al=F_al./(6.19*2.51*0.000000001);

strainT_delrin=log(strain_delrin+1);
strainT_cf=log(strain_cf+1);
strainT_al=log(strain_al+1);

stressT_delrin=stress_delrin.*(1+strain_delrin);
stressT_cf=stress_cf.*(1+strain_cf);
stressT_al=stress_al.*(1+strain_al);

timeal=table2array(time_al);
for i=1:344
    k=char(timeal(i,1));
    num_time_al(i)=str2num(k(1,[1,2,4,5,7,8]));
end
[num_edit_time_al,index_al]=sort(num_time_al);
for j=1:344
    num=index_al(j);
    stressTT_al(j)=stressT_al(num);
    strainTT_al(j)=strainT_al(num);
    stressN_al(j)=stress_delrin(num);
    strainN_al(j)=strain_delrin(num);
end

timecf=table2array(time_cf);
for i=1:202
    k=char(timecf(i,1));
    num_time_cf(i)=str2num(k(1,[1,2,4,5,7,8]));
end
[num_edit_time_cf,index_cf]=sort(num_time_cf);
for j=1:202
    num=index_cf(j);
    stressTT_cf(j)=stressT_cf(num);
    strainTT_cf(j)=strainT_cf(num);
    stressN_cf(j)=stress_cf(num);
    strainN_cf(j)=strain_cf(num);
end

timedelrin=table2array(time_delrin);
for i=1:551
    k=char(timedelrin(i,1));
    num_time_delrin(i)=str2num(k(1,[1,2,4,5,7,8]));
end
[num_edit_time_delrin,index_delrin]=sort(num_time_delrin);
for j=1:551
    num=index_delrin(j);
    stressTT_delrin(j)=stressT_delrin(num);
    strainTT_delrin(j)=strainT_delrin(num);
    stressN_delrin(j)=stress_delrin(num);
    strainN_delrin(j)=strain_delrin(num);
end


plot(strainTT_delrin,stressTT_delrin,'-r');
hold on
plot(strainTT_cf,stressTT_cf,'-k');
hold on
plot(strainTT_al,stressTT_al,'-b');
hold off






