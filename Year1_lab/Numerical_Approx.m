clear 
clc
whether_true=0;
while whether_true==0
    x=input('input the variable you want to evaluate:');
    if x>0&&x<1
        whether_true=1;
        break
    end
end
y=0;
d=1;
k=1;
while d>eps
    y(k+1)=y(k)+x^k/k;
    d=y(k+1)-y(k);
    k=k+1;
    
end
disp(y(k));
    

    
