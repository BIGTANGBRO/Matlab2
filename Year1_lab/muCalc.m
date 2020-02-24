function u=muCalc(T)
u=(1.716*10e-5*(T/273.15)^1.5)*((273.15+110.4)/(T+110.4));
disp(u);
end
