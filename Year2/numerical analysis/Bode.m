%%Script to draw the bode diagram

result = makeBode(0,0,1,1,20,100);

function x = makeBode(a,b,c,d,e,f)
    h = tf([a,b,c],[d,e,f]);
    bode(h);
    x = true;    
end