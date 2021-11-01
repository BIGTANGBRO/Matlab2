function [y] = KS (b,h)
y = zeros(size(b));
if length(b)>length(h)
    for i = 1: length (b)
        k = b(i)/h;
        if k < 0.49
            a = 1.1./0.49^2;
            c = 4.8;
            y(i) = a.*k.^2+c;
        else
            A = [0.49^2, 0.49, 1; 0.8^2, 0.8, 1; 1 ,1 ,1];
            p = [5.9;7;8.4];
            B = A\p;
            a = B(1);e = B(2); c = B(3);
            y(i) = a.*k.^2+e.*k+c;
        end
    end
else
    for i = 1: length (h)
        k = b/h(i);
        if k < 0.49
            a = 1.1./0.49^2;
            c = 4.8;
            y(i) = a.*k.^2+c;
        else
            A = [0.49^2, 0.49, 1; 0.8^2, 0.8, 1; 1 ,1 ,1];
            p = [5.9;7;8.4];
            B = A\p;
            a = B(1);e = B(2); c = B(3);
            y(i) = a.*k.^2+e.*k+c;
        end
    end
end
end