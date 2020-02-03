function eta = etas(n)

if n == 2
    eta(1) = -1/sqrt(3);
    eta(2) = 1/sqrt(3);
elseif n == 3
    eta(1) = -sqrt(3/5);
    eta(2) = 0;
    eta(3) = sqrt(3/5);
elseif n == 4
    eta(1) = -sqrt((3+2*sqrt(6/5))/7);
    eta(2) = -sqrt((3-2*sqrt(6/5))/7);
    eta(3) = sqrt((3-2*sqrt(6/5))/7);
    eta(4) = sqrt((3+2*sqrt(6/5))/7);
end