A = (0.2);
cumul_total = (0.0);
for iii = 1:1e6
    cumul_total = cumul_total + A;
end

format long
cumul_total_s = single(cumul_total);
fprintf('%.22f\n\n', cumul_total_s);
fprintf('%.22f\n\n', cumul_total);
