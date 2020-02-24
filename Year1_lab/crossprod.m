function y=crosspord(a,b)
if length(a)~=length(b)
    disp('dimension error');
    y=0;
else
    y=[a(2)*b(3)-a(3)*b(2),a(3)*b(1)-a(1)*b(3),a(1)*b(2)-a(2)*b(1)];
end
