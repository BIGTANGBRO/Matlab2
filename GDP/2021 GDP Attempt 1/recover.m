function [acc, vel, vol, epow, eenergy, mpow, menergy, cap, torque] = recover(out)
% Inputs: Output structure
% Outputs: Acceleration, Velocity, Voltage, Elec Power, Capacity used

acc = out.acc.data;
vel = out.velocity.data;
vol = out.voltage.data;
epow = out.elec_power.data;
eenergy = out.elec_energy.data;
mpow = out.mech_power.data;
menergy = out.mech_energy.data;
cap = (2.95 - out.cap_used.data ) ./ 2.95 .* 100;
torque = out.torque.data;

end

