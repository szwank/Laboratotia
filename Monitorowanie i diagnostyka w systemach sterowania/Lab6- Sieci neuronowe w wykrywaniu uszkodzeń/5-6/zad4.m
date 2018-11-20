[N,M] = size(X);
[NT,MT] = size(XT);
I = ones(N,1);      %wektor jednostkowy
IT = ones(NT,1);

%% normalizacja
Xmean = mean(X);
sigma = std(X);
odchylenie =  diag(sigma);
Xnorm = (X - I*Xmean) * inv(odchylenie);
XTnorm = (XT - IT*Xmean) * inv(odchylenie);

%% korelacja i kowariancja
R = (Xnorm' * Xnorm)/(N-1);     %korelacja
C = cov(Xnorm);                 %kowariancja

%% wektory i wartoœci w³asne
[V,D] = eigs(R, M, 'sm');       %V - wektory w³asne, D = wartoœci w³asne

%% redukcja
redukcja;
        
%% tworzenie modelu PCA
Xpca = Xnorm * V;
Xpca_zredukowane = Xnorm * wektory;
XTpca = XTnorm * V;
XTpca_zredukowane = XTnorm * wektory;

%% rekonstrukcja
Xzrekonstruowane_ = Xpca_zredukowane * inv(V);
Xzrekonstruowane = Xpca * inv(V);

%% miary 
% T^2
alfa = 0.95;
T2_lim = M*(N-1)/(N-M)*finv(alfa, M, N-M);
T2 = diag(Xpca*inv(D)*Xpca');                       %T2 = diag(Xnorm*wektory*inv(D)*wektory'*Xnorm');
T2_ = diag(Xpca_zredukowane*inv(D)*Xpca_zredukowane');
T2_limT = MT*(NT-1)/(NT-MT)*finv(alfa, MT, NT-MT);
T2T = diag(XTpca*inv(D)*XTpca');                       %T2 = diag(Xnorm*wektory*inv(D)*wektory'*Xnorm');
T2T_ = diag(XTpca_zredukowane*inv(D)*XTpca_zredukowane');

% SPE
SPE_lim = SPElimit(M, D, alfa, poziom_redukcji);
for i = 1:N
    SPE(i,1) = norm((Xnorm(i,:)*(V - wektory)), 2)^2;
end
SPE_limT = SPElimit(MT, D, alfa, poziom_redukcji);
for i = 1:NT
    SPET(i,1) = norm((XTnorm(i,:)*(V - wektory)), 2)^2;
end
