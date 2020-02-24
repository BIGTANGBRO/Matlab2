function w = weights(n)

if n == 2
    w(1) = 1;
    w(2) = 1;
elseif n == 3
    w(1) = 5/9;
    w(2) = 8/9;
    w(3) = 5/9;
elseif n == 4
    w(1) = (18-sqrt(30))/36;
    w(2) = (18+sqrt(30))/36;
    w(3) = (18+sqrt(30))/36;
    w(4) = (18-sqrt(30))/36;
end
