Lw = 125; 
Rw = 300; 
Lt = 46; 
Rt = 5; 
G = 4.2;
J = 1; 

Lw_zepsute = 125;
Rw_zepsute = 350;
Lt_zepsute = 46;
Rt_zepsute = 5;
G_zepsute = 4.2;
J_zepsute = 1;

%% Lw praca red 2
%400 - T^2 dla ca³ego zaczyna siê pokazywaæ, 700 - T^2 dla ca³ego widaæ,
%ze zwiêkszaniem T^2 dla zredukowanego maleje (15000)
%poni¿ej 40 d³ugo miele, dla 40 nic nie widaæ

%% Rw praca red 2
%330 - T^2 w zredukowanym nie widaæ, 350 - w ka¿dym widaæ, 250 - T^2 w
%zredukowanym s³abo widaæ

%% Lt praca red 2
%100 - T^2 dla ca³ego widaæ (200 zdecydowanie), 400 - SPE coœ zaczyna siê
%pojawiaæ, 1000 - w red T^2 widaæ ró¿nicê, nie chce przeskoczyæ lim (1.5k),
%1 - T^2 dla ca³ego maleje, reszta podobnie, 0.001 d³ugo mieli³

%% Rt praca red 2
%10 - T^2 dla ca³ego siê pokazuje, 50 - SPE i T^2 ca³ym widaæ
%100 - we wszystkich, 0.1 - T^2 dla ca³ego, 0.001 - SPE powoli

%% G praca red 2
%4.3 - T^2 dla ca³ego szaleje ju¿, 4.5 - widaæ te¿ w SPE
%5 - najgorzej T^2 zredukowany, ale coœ siê pojawia, 10 - dla wszystkich ok
%4 - T^2 szaleje, 3.5 - widaæ we wszystkich

%% J praca red 2
%10 - widaæ we wszystkich, 5 - widaæ we wszystkich (ale T^2 red mieœci siê)
%2 - widaæ w T^2 ca³y
%0.5 - zaczyna siê w T^2 dla ca³ego, jeszcze mniejsze to siê polepsza chyba
