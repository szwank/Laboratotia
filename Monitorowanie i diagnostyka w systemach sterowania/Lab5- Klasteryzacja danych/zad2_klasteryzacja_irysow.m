load('irysy.mat')

clc
close all

% przyk³adowe dane
X = irisInputs';
plot(X(:,1), X(:,2),'.')
%axis([0 5 0 5])
grid on

Y = pdist(X, 'euclidean');
            % lub np.Y1 = pdist(X,'cityblock')

% funkcja pdist pozwala na obliczanie dystansu pomiêdzy poszczególnymi punktami 
% zbioru X na podstawie przyjêtej metryki. Szczegó³y funkcji dostêpne w  
% doc help pdist. 
% Za pomoc¹ funkcji squareform mo¿liwe jest utworzenie macierzy kwadratowej 
% zawieraj¹cej te odleg³oœci

dist_matrix1=squareform(Y);
            % lub np. dist_matrix1=squareform(Y1)

% w powy¿szym przyk³adzie element 1,1 jest odleg³oœci¹ elementu pierwszego 
% od pierwszego, 1,2  - jest odleg³oœci¹ elementu pierwszego od drugiego itd... 

% funkcja linkage korzystaj¹c z informacji wygenerowanej przez pdist, ³¹czy
% ze sob¹ elementy le¿¹ce "najbli¿ej" siebie w clustry (2 elementowe).
% Nastêpnie do³¹cza kolejne elementy itd a¿ zostanie utworzone ca³e
% hierarchiczne drzewo zawieraj¹ce wsyztskie elementy.

Z = linkage(Y)

% ka¿dy z wierszy Z okreœla po³¹czenie elementów lub klastrów. Pierwsze 2
% kolumny okreœlaj¹ po³¹czone obiekty, a trzecia kolumna okreœla odleg³oœæ
% pomiedzy nimi. 
% w powy¿szym przyk³adzie w 3 wierszu pojawia siê po³¹czenie elementu 6 i
% 7 (dane orginalne zawiera³y jedynie 5 danych). Element 6 jest klastem
% zawieraj¹cym orginalne elementy 4 i 5, natomiast element 7 jest klastem
% zawieraj¹cym orginalne elementy 1 i 3 .Element 8 to zgrupowane dane 1,3,4,5
% informacje zawarte w linkage mo¿na zwizualizowac w postaci grafu (drzewa)
% przy pomocy funkcji dendrogram

figure;
dendrogram(Z)

% oœ pozioma okreœla indeksy orginalnych danych. Wysokoœæ drzewa okreœlona 
% jest poprzez odleg³oœci pomiêdzy klastrami. Np. link reprezentuj¹cy klaster 
% zawieraj¹cy element 1 i 3 ma wysokoœæ 1. link reprezentuj¹cy klaster 
% grupuj¹cy element 2 z 8 ma wysokoœæ 2.5 (jest to wysokoœæ pomiêdzy elementami 2 i 8)

% elementy sk³adowe klastrów powinny byæ jak najbardziej ze sob¹
% skorelowane. Do analizy korelacji tych s³u¿y funkcja cophenet. Im bli¿sze 
% jej wyjœcie jest wartoœci 1 tym lepiej.

c  = cophenet(Z,Y)

%  kolejna z funkcji inconsistent pozwala na obliczanie "odleg³oœci" 
%  (ró¿nica wysokoœci klastra  i œredni¹ wysokoœci¹ klastra, normalizowana 
%  przez odchylenie standardowe).  

I  = inconsistent(Z)

% Tworzenie klastrów 
% *************************************************************************
% 
% Klastry mo¿na utworzyæ na dwa sposoby:
% 1. Na podstawie ustalanie poziomu miary inconsistent, poprzez "przeciêcie" 
% drzewa w miejscu gdy miara ta przekroczy za³o¿ony podzia³: 

T  = cluster(Z,'cutoff',1.2)

% lub np
%T  = cluster(Z,'cutoff',0.8)

% wyjscie z funkcji okreœla który obiekt zosta³ przydzielony do którego
% klastra.

% 2. Na podstawie za³o¿onej apriori liczby klastrów

T  = cluster(Z,'maxclust',2)
% lub np
%T  = cluster(Z,'maxclust',3)

% Na koniec mo¿na wyrysowaæ dane po podziale, np tak: 

figure;                
plot(X(T==1,1),X(T==1,2),'r.','MarkerSize',20)
hold on
plot(X(T==2,1),X(T==2,2),'b.','MarkerSize',20)
hold on
plot(X(T==3,1),X(T==3,2),'g.','MarkerSize',20)

legend('Cluster 1','Cluster 2','Cluster 3','Location','NW')
%%

% *************************************************************************
% ************            klasteryzacja typu k-means    *******************
% *************************************************************************

%close all;
clear;
clc

% przyk³adowe dane 

% funkcja kmeans dzieli dane na z góry okreœlon¹ iloœæ klustrów pos³uguj¹c siê 
% okreœlon¹ metryk¹ odleg³oœci, np:  
load('irysy.mat')
X = irisInputs';

% aby sprawdziæ czy ten podzia³ jest adekwatny, mo¿na u¿yæ funkcji silhouette.
% funkcja ta zwraca wartoœæ 1 gdy punkt jest "idealnie wpasowany w dany klaster, 
% 0 gdy tak samo pasuje do tego jak i innego klastra oraz 1 gdy na pewno nie 
% nale¿y do tego klastra (wartoœci pomiêdzy -1 a 1 niuansuj¹ powy¿sze).



% zwiêksz i zmniejsz liczbê klastrów aby zobaczyæ która z nich jest
% najlepsza. 
% U¿yj funkcji mean aby obliczyæ precyzyjnie œredni¹ wartoœæ silhouette 

%mean(silh3)

% parametr kmeans 'replicates' pozwala na ponawianie iteracyjne algorytmu w
% celu unikniêcia wpadania w lokalne minima. 

[idx4,centroids,sumdist] = kmeans(X, 2,'dist','city',...
'display','final','replicates',5);

figure;
[silh3,h] = silhouette(X,idx4,'city','display','iter');
set(get(gca,'Children'),'FaceColor',[.8 .8 1])
xlabel('Silhouette Value')
ylabel('Cluster')

sum(sumdist)

% dane pogrupowane s¹ do zbiorów, np:
% X(idx4==1); X(idx4==2); X(idx4==3); X(idx4==4);
% X_klaster1=X(idx4==1,1:size(X,2))
% X_klaster1=X(idx4==2,1:size(X,2))
% X_klaster1=X(idx4==3,1:size(X,2))
% X_klaster1=X(idx4==4,1:size(X,2))

% ostatecznie mo¿na wyrysowaæ klastry

figure;                
plot(X(idx4==1,1),X(idx4==1,2),'r.','MarkerSize',12)
hold on
plot(X(idx4==2,1),X(idx4==2,2),'b.','MarkerSize',12)
hold on
plot(X(idx4==3,1),X(idx4==3,2),'g.','MarkerSize',12)
hold on
plot(X(idx4==4,1),X(idx4==4,2),'y.','MarkerSize',12)
plot(centroids(:,1),centroids(:,2),'kx',...
      'MarkerSize',12,'LineWidth',2)
plot(centroids(:,1),centroids(:,2),'ko',...
      'MarkerSize',12,'LineWidth',2)
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Centroids',...
      'Location','NW')

% zwróæ uwagê i¿ dane orginalne (i pogrupowane) s¹ wymiaru nx4 wiêc
% powinniœmy obejrzeæ równie¿ inne wymiary np:

figure;                
plot(X(idx4==1,1),X(idx4==1,4),'r.','MarkerSize',12)
hold on
plot(X(idx4==2,1),X(idx4==2,4),'b.','MarkerSize',12)
hold on
plot(X(idx4==3,1),X(idx4==3,4),'g.','MarkerSize',12)
hold on
plot(X(idx4==4,1),X(idx4==4,4),'y.','MarkerSize',12)
plot(centroids(:,1),centroids(:,4),'kx',...
      'MarkerSize',12,'LineWidth',2)
plot(centroids(:,1),centroids(:,4),'ko',...
      'MarkerSize',12,'LineWidth',2)
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Centroids',...
      'Location','NW')
  
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% podpunkt czwarty
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc

load('irysy.mat')
X = irisInputs';

T = clusterdata(X,'Maxclust',2); 

figure;                
plot(X(T==1,1),X(T==1,2),'r.','MarkerSize',20)
hold on
plot(X(T==2,1),X(T==2,2),'b.','MarkerSize',20)
hold on



