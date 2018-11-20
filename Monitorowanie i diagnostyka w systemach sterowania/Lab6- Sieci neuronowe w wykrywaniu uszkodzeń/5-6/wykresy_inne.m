%% T^2 i SPE, X i XT osobno
figure
subplot(2,2,1)
plot(t,wektor_T2)
hold on;
plot(T2,'ro')
hold on;
plot (T2_, 'g*');
legend ('limit', 'T^2 dla ca쿮go', 'T^2 dla zredukowanego');    %, 'Location', 'WestOutside'
title('T^2 silnik sprawny');

subplot(2,2,2)
plot(t,wektor_SPE)
hold on;
plot(SPE,'mo')
title('SPE silnik sprawny');

subplot(2,2,3)
plot(tT,wektor_T2T, 'c')
hold on;
plot(T2T,'bx')
hold on;
plot (T2T_, 'ko');
legend ('limit', 'T^2 dla ca쿮go', 'T^2 dla zredukowanego');    %, 'Location', 'WestOutside'
title('T^2 silnik uszkodzony');

subplot(2,2,4)
plot(tT,wektor_SPET, 'b')
hold on;
plot(SPET,'c*')
title('SPE silnik uszkodzony');

%% T^2 i SPE, X i XT razem
figure
subplot(1,2,1)
plot(t,wektor_T2)
hold on;
plot(T2,'ro')
hold on;
plot (T2_, 'g*');
hold on;
plot(tT,wektor_T2T)
title('T^2 XT');
hold on;
plot(T2T,'bx')
hold on;
plot (T2T_, 'ko');
legend ('limit - silnik sprawny', 'T^2 dla ca쿮go - silnik sprawny', 'T^2 dla zredukowanego - silnik sprawny',...
    'limit - silnik uszkodzony', 'T^2 dla ca쿮go - silnik uszkodzony', 'T^2 dla zredukowanego - silnik uszkodzony');
title('T^2');

subplot(1,2,2)
plot(t,wektor_SPE)
hold on;
plot(SPE,'mo')
hold on;
plot(tT,wektor_SPET, 'b')
hold on;
plot(SPET,'c*')
legend ('limit - silnik sprawny', 'SPE - silnik sprawny', 'limit - silnik uszkodzony', 'SPE - silnik uszkodzony');
title('SPE');












%% X, X znormalizowany, X zredukowany, X PCA, X PCA zredukowany
figure
subplot(2,2,1)
plot(X, '.');
title('X');
grid on;

subplot(2,2,2)
plot(Xnorm, '.');
title('X znormalizowany');
grid on;

subplot(2,2,3)
plot(Xpca, '.');
title('X PCA');
grid on;

subplot(2,2,4)
plot(Xpca_zredukowane, '.');
title('X PCA zredukowane');
grid on;

%% rekonstrukcja
figure
subplot(1,2,1)
plot(Xnorm,'bo');
hold on;
plot(Xzrekonstruowane,'r.');
title ('X zrekonstruowane');
%legend ('Xnorm', 'Xzrekonstruowane', 'Location', 'NorthOutside');
grid on;

subplot(1,2,2)
plot(Xnorm,'bo');
hold on;
plot(Xzrekonstruowane_,'r.');
title ('X zrekonstruowane zredukowane');
%legend ('Xnorm', 'Xzrekonstruowane', 'Location', 'NorthOutside');
grid on;

%% XT, XT znormalizowany, XT zredukowany, XT PCA, XT PCA zredukowany
figure
subplot(2,2,1)
plot(XT, '.');
title('XT');
grid on;

subplot(2,2,2)
plot(XTnorm, '.');
title('XT znormalizowany');
grid on;

subplot(2,2,3)
plot(XTpca, '.');
title('XT PCA');
grid on;

subplot(2,2,4)
plot(XTpca_zredukowane, '.');
title('XT PCA zredukowane');
grid on;
