%%Script to draw the bode diagram

result = makeBode(1,2,3,4,5,6);

function x = makeBode(a,b,c,d,e,f)
    h = tf([a,b,c],[d,e,f]);
    bode(h);
    x = true;    
end