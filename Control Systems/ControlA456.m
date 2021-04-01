%Assignment 6

% elevator to pitch angle transfer function
s=tf('s');
tf_theta_de=-(1072.8*s+380.6)/(871.5*s*(s^2+0.936*s+1.78));

% Please complete our code on eigenmode analysis and closed-loop system design



K=-0.18; % Your chosen gain K (a real number)
G_AFCS=K/(1/tf_theta_de+K) % Transfer Function from \theta_r to \theta

DDs_cl=pole(G_AFCS)
Index=1:length(DDs_cl);
for i=1:length(Index)
    if imag(DDs_cl(i))==0
        Index(i)=0;
    else
        Index(i)=i;
    end
end
Index=find(Index);
mag_DDs_cl=zeros(1,length(Index));
for i=1:length(Index)
    mag_DDs_cl(i)=abs(DDs_cl(Index(i)));
end
index=find(mag_DDs_cl==max(mag_DDs_cl));
lambda_cl=DDs_cl(Index(index(1))); %Select the pole corresponding to short period
omega_n_cl=sqrt((real(lambda_cl))^2+(imag(lambda_cl))^2);
zeta_cl=-(real(lambda_cl))/sqrt((real(lambda_cl))^2+(imag(lambda_cl))^2);
disp(['Natural Frequency: ',num2str(omega_n_cl),'[rad/s]'])
disp(['Damping Ratio: ',num2str(zeta_cl),' [-]'])

% Pilot describing transfer function
Kp=4.5;
tau_e=0.2;
Yp=Kp*exp(-s*tau_e);

% loop transfer function L(s)=Yp(s)G_AFCS(s)
L=series(Yp,G_AFCS);

% create figures - Bode plot
margin(L);
ylim([-200 60]);

% calculate gain margin, phase margin and associated frequencies
S = allmargin(L);
disp(['Gain margin: ',num2str(20*log10(min(S.GainMargin))),'[dB]'])
disp(['Phase margin: ',num2str(S.PhaseMargin),' [deg]'])


