L=input('input the number of the lower bound');
H=input('input the number of the higher bound');
k=[];
for i=L:H
    t=isprime(i);
    k=[k,t];
   
    
end
p=[L:1:H];
plot(p,k);
