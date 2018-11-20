t=1:N;
wektor_T2 = I*T2_lim;
wektor_SPE = I*SPE_lim;
tT=1:NT;
wektor_T2T = IT*T2_limT;
wektor_SPET = IT*SPE_limT;

%% wyplotowane X
figure
subplot(2,3,1)
plot(X_cale(:,1));
hold on;
plot(XT_cale(:,1));
legend ('sprawny','uszkodzony', 'Location', 'SouthEast');
title('It');

subplot(2,3,2)
plot(X_cale(:,2));
hold on;
plot(XT_cale(:,2));
legend ('sprawny','uszkodzony', 'Location', 'SouthEast');
title('Iw');

subplot(2,3,3)
plot(X_cale(:,3));
hold on;
plot(XT_cale(:,3));
legend ('sprawny','uszkodzony', 'Location', 'SouthEast');
title('Omega');

subplot(2,3,4)
plot(X_cale(:,4));
hold on;
plot(XT_cale(:,4));
legend ('sprawny','uszkodzony', 'Location', 'SouthEast');
title('Uw');

subplot(2,3,5)
plot(X_cale(:,5));
hold on;
plot(XT_cale(:,5));
legend ('sprawny','uszkodzony', 'Location', 'SouthEast');
title('Ut');

subplot(2,3,6)
plot(X_cale(:,6));
hold on;
plot(XT_cale(:,6));
legend ('sprawny','uszkodzony', 'Location', 'SouthEast');
title('M');

%% T^2 i SPE, ca³y i zredukowany osobno (razem dla X i XT)
figure
subplot(2,2,1)
plot(t,wektor_T2)           %T2_lim
hold on;
plot(T2,'ro')               %T2 X
hold on;
plot(tT,wektor_T2T, 'c')    %T2_limT
hold on;
plot(T2T,'bx')              %T2 XT
legend ('limit - silnik sprawny', 'T^2 - silnik sprawny', 'limit - silnik uszkodzony', 'T^2 - silnik uszkodzony');
title('T^2 ca³y');

subplot(2,2,2)
plot(t,wektor_SPE)          %SPE_lim
hold on;
plot(SPE,'mo')              %SPE X
hold on;
plot(tT,wektor_SPET, 'b')   %SPE_limT
hold on;
plot(SPET,'c*')             %SPE XT
legend ('limit - silnik sprawny', 'SPE - silnik sprawny', 'limit - silnik uszkodzony', 'SPE - silnik uszkodzony');
title('SPE');

subplot(2,2,3)
plot(t,wektor_T2)           %T2_lim
hold on;
plot (T2_, 'g*');           %T2 zredukowany X
hold on;
plot(tT,wektor_T2T, 'c')    %T2_limT
hold on;
plot (T2T_, 'ko');          %T2 zredukowany XT
legend ('limit - silnik sprawny', 'T^2 - silnik sprawny zredukowany', 'limit - silnik uszkodzony', 'T^2 - silnik uszkodzony zredukowany');
title('T^2 zredukowany');

%% wszytsko osobno: T2,T2red,T2T,T2Tred,SPE,SPET,T2lim,SPElim
figure
subplot(2,3,1)
plot(t,wektor_T2)           %T2_lim
hold on;
plot(T2,'ro')               %T2 X
hold on;
title('T^2 - sprawny');

subplot(2,3,2)
plot(tT,wektor_T2T, 'c')    %T2_limT
hold on;
plot(T2T,'bx')              %T2 XT
title('T^2 - uszkodzony');

subplot(2,3,4)
plot(t,wektor_T2)           %T2_lim
hold on;
plot (T2_, 'g*');           %T2 zredukowany X
title('T^2red - sprawny');

subplot(2,3,5)
plot(tT,wektor_T2T, 'c')    %T2_limT
hold on;
plot (T2T_, 'ko');          %T2 zredukowany XT
title('T^2red - uszkodzony');

subplot(2,3,3)
plot(t,wektor_SPE)          %SPE_lim
hold on;
plot(SPE,'mo')              %SPE X
title('SPE - sprawny');

subplot(2,3,6)
plot(tT,wektor_SPET, 'b')   %SPE_limT
hold on;
plot(SPET,'c*')             %SPE XT
title('SPE - uszkodzony');
