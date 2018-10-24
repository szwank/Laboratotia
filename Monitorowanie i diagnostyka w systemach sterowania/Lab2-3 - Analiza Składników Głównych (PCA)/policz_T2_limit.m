function [ T2_limit ] = policz_T2_limit( X_PCA )
%Policzenie limitu ufno�ci T2
N = length(X_PCA(:,1));         % przepisanie d�ugo�ci macierzy X_PCA
M = length(X_PCA(1,:));

T2_limit = M*(N - 1) / (N - M) * finv(0.95,M,N-M);

end

