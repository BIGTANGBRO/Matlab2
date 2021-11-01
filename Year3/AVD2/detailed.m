%% reliability of finite element analysis

x = [1.5,1.8,2,3.5,4,4.5,5];
displacement = [0.3015,0.3015,0.3014,0.3004,0.3002,0.2999,0.2998];
plot(x,displacement);
xlabel("Element size/mm");
ylabel("Maximum displacement/mm");
grid on