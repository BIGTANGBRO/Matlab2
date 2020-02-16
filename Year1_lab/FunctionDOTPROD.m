function y=dotprod(a,b)
if length(a)~=length(b)
    disp('Error on different dimensions of the array');
    y=0;
else
    y=0;
    for i=1:length(a)
        y=y+a(i)*b(i);
    end
    
end
