function i=Isprime(n)
if (n<=2)
    i=1;
else
    for i=2:round(n/2)
        if mod(n,i)==0
            i=0;
            p=1;
            break
        else
            p=0;
        end
    end
    if p==0
        i=1;
    end
end
disp(i);
end


    