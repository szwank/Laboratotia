clc;
clear;
A = [0 1 0;
     0 0 1
     -52 -30 -4];
B = [0;
     0;
     1];
C = [20 1 0];

%% podpunkt a
bieguny = eig(A)
sterowalnosc = rank(ctrb(A,B))
%% podpunkt b
sys=ss(A,B,C,0);
[y,t,x]=step(sys);
subplot(1,2,1);
plot(t,x(:,1),t,x(:,2),t,x(:,3))
title('x1,x2')
ylim([-0.15 0.15])
subplot(1,2,2);
plot(t,y)
title('y')
ylim([0 1.2])

%% podpunkt c
chcianeBieguny = [-1 -10 -5] %nie jestem pewny czy o takie wartoœci chodzi³o, nie jednoznacznie okreœlone
%% podpunkt d
L=place(A,B,chcianeBieguny);
%% podpunkt e
sysL=ss(A-B*L,B,C,0);
[y,t,x]=step(sysL);
figure;
subplot(1,2,1);
plot(t,x(:,1),t,x(:,2),t,x(:,3))
title('x1,x2- sysL')
ylim([-0.15 0.15])
subplot(1,2,2);
plot(t,y)
title('y- sysL')
ylim([0 1.2])

%% podpunkt f
Ahat = [A zeros(3,1);
        -C 0];
Bhat = [B;
        0];
Lhat = acker(Ahat,Bhat,[chcianeBieguny -5]);
%% podpunkt g
AA = [A-B*Lhat(1:3) B*-Lhat(4);
      -C 0];
BB = [zeros(3,1);
      1];
sysLL=ss(AA,BB,[C 0],0);
[y,t,x]=step(sysLL);
figure;
subplot(1,2,1);
plot(t,x(:,1),t,x(:,2),t,x(:,3))
title('x1,x2- sysLL')
ylim([-0.15 0.15])
subplot(1,2,2);
plot(t,y)
title('y- sysLL')
ylim([0 1.2])

%% podpunkt h
E = [0.1;
     0.1;
     0.1];
AA = [A-B*Lhat(1:3) B*-Lhat(4);
      -C 0];
BB = [zeros(3,1) E zeros(3,1);
      1 0 1];
sysLL=ss(AA,BB,[C 0],0);
[y,t,x]=step(sysLL);
figure;
subplot(1,2,1);
plot(t,x(:,1),t,x(:,2),t,x(:,3))
title('x1,x2- sysLL- szum')
ylim([-0.15 0.15])
subplot(1,2,2);
plot(t,y(:,:,1))
title('y- sysLL- szum')
ylim([0 1.2])

%% podpunkt i
A = [0 1.2 0;
     0 0 1.2;
     -55 -34 -4.2];

AA = [A-B*Lhat(1:3) B*-Lhat(4);
      -C 0];
BB = [zeros(3,1) E zeros(3,1);
      1 0 1];
sysLL=ss(AA,BB,[C 0],0);
[y,t,x]=step(sysLL);
figure;
subplot(1,2,1);
plot(t,x(:,1),t,x(:,2),t,x(:,3))
title('x1,x2- sysLL-A')
ylim([-0.15 0.15])
subplot(1,2,2);
plot(t,y(:,:,1))
title('y- sysLL-A')
ylim([0 1.2])

%% podpunkt j
sys=ss(A,B,C,0,0.001);

Ahat = [sys.A zeros(3,1);
        -sys.C 0];
Bhat = [sys.B;
        0];
Lhat = acker(Ahat,Bhat,[chcianeBieguny -5]);

AA = [sys.A-sys.B*Lhat(1:3) B*-Lhat(4);
      -sys.C 0];
BB = [zeros(3,1);
      1];
sysLL=ss(AA,BB,[C 0],0);
[y,t,x]=step(sysLL);
figure;
subplot(1,2,1);
plot(t,x(:,1),t,x(:,2),t,x(:,3))
title('x1,x2- sysLL-T0.001')
ylim([-0.15 0.15])
subplot(1,2,2);
plot(t,y)
title('y- sysLL-T0.001')
ylim([0 1.2])

%% podpunkt k I
sys=ss(A,B,C,0,0.01);

Ahat = [sys.A zeros(3,1);
        -sys.C 0];
Bhat = [sys.B;
        0];
Lhat = acker(Ahat,Bhat,[chcianeBieguny -5]);

AA = [sys.A-sys.B*Lhat(1:3) B*-Lhat(4);
      -sys.C 0];
BB = [zeros(3,1);
      1];
sysLL=ss(AA,BB,[C 0],0);
[y,t,x]=step(sysLL);
figure;
subplot(1,2,1);
plot(t,x(:,1),t,x(:,2),t,x(:,3))
title('x1,x2- sysLL-T0.01')
ylim([-0.15 0.15])
subplot(1,2,2);
plot(t,y)
title('y- sysLL-T0.01')
ylim([0 1.2])

%% podpunkt k II
sys=ss(A,B,C,0,0.1);

Ahat = [sys.A zeros(3,1);
        -sys.C 0];
Bhat = [sys.B;
        0];
Lhat = acker(Ahat,Bhat,[chcianeBieguny -5]);

AA = [sys.A-sys.B*Lhat(1:3) B*-Lhat(4);
      -sys.C 0];
BB = [zeros(3,1);
      1];
sysLL=ss(AA,BB,[C 0],0);
[y,t,x]=step(sysLL);
figure;
subplot(1,2,1);
plot(t,x(:,1),t,x(:,2),t,x(:,3))
title('x1,x2- sysLL-T0.1')
ylim([-0.15 0.15])
subplot(1,2,2);
plot(t,y)
title('y- sysLL-T0.1')
ylim([0 1.2])