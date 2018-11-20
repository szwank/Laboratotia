figure
subplot(1,2,1)
plotmatrix(X);
title('X sprawny');
subplot(1,2,2)
plotmatrix(XT);
title('X uszkodzony');

figure
subplot(1,2,1)
plotmatrix(Xpca);
title('Xpca sprawny');
subplot(1,2,2)
plotmatrix(XTpca);
title('Xpca uszkodzony');

figure
subplot(1,2,1)
plotmatrix(Xpca_zredukowane);
title('Xpca zredukowany sprawny');
subplot(1,2,2)
plotmatrix(XTpca_zredukowane);
title('Xpca zredukowany uszkodzony');
