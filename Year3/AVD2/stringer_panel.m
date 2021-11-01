%d_h=0.3;
clear
clc

ts_t2=1.1;
As_bt_target=1.6;
c=3.85839;%box width
count=0;
for ts=1:1:10
    t2=ts/ts_t2;
    for h=30:10:100
    d=0.3*h;
    As=h*ts+2*d*ts;
    for n=20:1:40;
    b=(c/n)*1000;
    As_bt=As/(b*t2);
    b1=c/(n+1);
    panelA=b1*t2*1000;
    totalW=panelA*(n+1)+As*n;
    if abs(As_bt-As_bt_target)<0.01
        count=count+1;
        ts_choose_key(count)=ts;
        t2_choose(count)=t2;
        h_choose_key(count)=h;
        d_choose(count)=d;
        n_choose_key(count)=n;
        b_choose(count)=b;
        W_choose(count)=totalW;
    end
    end
    end
end

choice=find(W_choose==min(W_choose))
fprintf("ts = %5.3f \n",ts_choose_key(2));
fprintf("t2 = %5.3f \n",t2_choose(2));
fprintf("h = %5.3f \n",h_choose_key(2));
fprintf("d = %5.3f \n",d_choose(2));
fprintf("n = %5.3f \n",n_choose_key(2));
fprintf("b = %5.3f \n",b_choose(2));
fprintf("w = %5.3f \n",W_choose(2));