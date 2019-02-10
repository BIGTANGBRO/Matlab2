function i=myList(start,step,e)
t=start;
i=[start];
c=1;
while t<=(e-step)
    t=step*c+start;
    i=[i,t];
    c=c+1;
    
end
end
