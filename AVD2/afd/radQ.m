%%% calculate normal force/shear/moment distribution within a heavy frame due to a
%%% radial loading Q acting on theta given radius r(anticlockwise)
%%% n number of section 
%%% clockwise shear force as positve

function [N,S,M,si]=radQ(Q,theta,n,r)
      si=linspace(0,2*pi,n);
      si=si+deg2rad(theta);
      N=Q/(2*pi)*[3/2.*cos(si)+(pi-si).*sin(si)];
      S=Q/(2*pi)*[(pi-si).*cos(si)-1/2.*sin(si)];
      M=Q*r/(2*pi)*[1+0.5.*cos(si)-(pi-si).*sin(si)];
      
    k=0;
    for i=1:n
       if si(i)>2*pi
          k=k+1; 
          si_1(k)=si(i)-2*pi; 
          N_1(k)=N(i);
          S_1(k)=S(i);
          M_1(k)=M(i);
       end
    end
    si_1(k+1:n)=si(1:n-k);
    si=si_1;
    N_1(k+1:n)=N(1:n-k);
    N=N_1;
    S_1(k+1:n)=S(1:n-k);
    S=S_1;
    M_1(k+1:n)=M(1:n-k);
    M=M_1;
    si=rad2deg(si);
end