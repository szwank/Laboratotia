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
%400 - T^2 dla ca�ego zaczyna si� pokazywa�, 700 - T^2 dla ca�ego wida�,
%ze zwi�kszaniem T^2 dla zredukowanego maleje (15000)
%poni�ej 40 d�ugo miele, dla 40 nic nie wida�

%% Rw praca red 2
%330 - T^2 w zredukowanym nie wida�, 350 - w ka�dym wida�, 250 - T^2 w
%zredukowanym s�abo wida�

%% Lt praca red 2
%100 - T^2 dla ca�ego wida� (200 zdecydowanie), 400 - SPE co� zaczyna si�
%pojawia�, 1000 - w red T^2 wida� r�nic�, nie chce przeskoczy� lim (1.5k),
%1 - T^2 dla ca�ego maleje, reszta podobnie, 0.001 d�ugo mieli�

%% Rt praca red 2
%10 - T^2 dla ca�ego si� pokazuje, 50 - SPE i T^2 ca�ym wida�
%100 - we wszystkich, 0.1 - T^2 dla ca�ego, 0.001 - SPE powoli

%% G praca red 2
%4.3 - T^2 dla ca�ego szaleje ju�, 4.5 - wida� te� w SPE
%5 - najgorzej T^2 zredukowany, ale co� si� pojawia, 10 - dla wszystkich ok
%4 - T^2 szaleje, 3.5 - wida� we wszystkich

%% J praca red 2
%10 - wida� we wszystkich, 5 - wida� we wszystkich (ale T^2 red mie�ci si�)
%2 - wida� w T^2 ca�y
%0.5 - zaczyna si� w T^2 dla ca�ego, jeszcze mniejsze to si� polepsza chyba
