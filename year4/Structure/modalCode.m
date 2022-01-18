clear
clc

%Script used to calculate the matrix in modal coordinates.
phi = [1,1;2,3];
phiT = phi.';
M = [13,-5;-5,2];
K = [17,-7;-7,3];
smallm = phiT * M * phi;
smallk = phiT * K * phi;


%the function which will get the omega using rayleigh-ritz equation
function omegaSquare = getOmega(phi,k,m)
    omegaSquare = phi.' * k * phi/(phi.' * M * phi);
end