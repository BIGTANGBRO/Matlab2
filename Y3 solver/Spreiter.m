%use of spreiter method
%transonic flow

clear
clc

mInf = [0.73 0.74 0.75];
CLOld = [0.721 0.733 0.743];
CDOld = [0.013 0.019 0.024];
tau = 0.121;
k=2.4.*mInf.^2;
tauNew = 0.1;
bigX = (1-mInf.^2)./(tau.*k).^(2/3);

%calculate the new minf
mNew = [];
for i = 1:length(bigX)
    minDiff = 10;
    for m = 0.7:0.001:0.85
        kNew=2.4.*m.^2;
        bigXNew = (1-m.^2)./(tauNew.*kNew).^(2/3);
        diff = abs(bigXNew- bigX(i));
        if diff < minDiff
            minDiff = diff;
        else
            break;
        end
    end
    mNew = [mNew m-0.001];
end
kInfNew = 2.4.*mNew.^2;
CLNew = ((k./kInfNew)./(tau./tauNew).^2).^(1/3).*CLOld;
CDNew = ((k./kInfNew)./(tau./tauNew).^5).^(1/3).*CDOld;

