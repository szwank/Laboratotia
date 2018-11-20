X_cale(:,1) = It_out.signals.values;
X_cale(:,2) = Iw_out.signals.values;
X_cale(:,3) = Omega_out.signals.values;
X_cale(:,4) = Uw_in.signals.values;
X_cale(:,5) = Ut_in.signals.values;
X_cale(:,6) = M_in.signals.values;

XT_cale(:,1) = It_out1.signals.values;
XT_cale(:,2) = Iw_out1.signals.values;
XT_cale(:,3) = Omega_out1.signals.values;
XT_cale(:,4) = Uw_in.signals.values;
XT_cale(:,5) = Ut_in.signals.values;
XT_cale(:,6) = M_in.signals.values;

[N,M] = size(X_cale);
[NT,MT] = size(XT_cale);

granica_rozruchu = 1000;

for j=1:M
    for i=1:granica_rozruchu
        X_rozruch(i,j) = X_cale(i, j);
    end
end
for j=1:MT
    for i=1:granica_rozruchu
        XT_rozruch(i,j) = XT_cale(i,j);
    end
end

for j=1:M
    for i=(granica_rozruchu+1):N
        X_praca(i-granica_rozruchu,j) = X_cale(i, j);
    end
end
for j=1:MT
    for i=(granica_rozruchu+1):NT
        XT_praca(i-granica_rozruchu,j) = XT_cale(i,j);
    end
end

