% Materia� wprowadzaj�cy do zagadnienia klasteryzacji danych. Materia�
% obejmuje funkcje zawarte w Matlab Statistic Toolbox, dotycz�ce metod:
% klasteryzacji hierarchicznej; klasteryzacji typu k-means, klasteryzacji
% typu: Gaussian Mixture oraz Soft Clustering Using Gaussian Mixture Distributions.

% Opracowa� dr in�. Micha� Grchowski, na podstawie Matlab Statistic Toolbox.

%%

% *************************************************************************
% *********     klasteryzacja hierarchiczna "step by step"    *************
% *************************************************************************

clc
close all

% przyk�adowe dane
X = [1 2;2.5 4.5;2 2;4 1.5;4 2.5]
plot(X(:,1), X(:,2),'.')
axis([0 5 0 5])
grid on

Y = pdist(X, 'euclidean')
            % lub np.Y1 = pdist(X,'cityblock')

% funkcja pdist pozwala na obliczanie dystansu pomi�dzy poszczeg�lnymi punktami 
% zbioru X na podstawie przyj�tej metryki. Szczeg�y funkcji dost�pne w  
% doc help pdist. 
% Za pomoc� funkcji squareform mo�liwe jest utworzenie macierzy kwadratowej 
% zawieraj�cej te odleg�o�ci

dist_matrix1=squareform(Y)
            % lub np. dist_matrix1=squareform(Y1)

% w powy�szym przyk�adzie element 1,1 jest odleg�o�ci� elementu pierwszego 
% od pierwszego, 1,2  - jest odleg�o�ci� elementu pierwszego od drugiego itd... 

% funkcja linkage korzystaj�c z informacji wygenerowanej przez pdist, ��czy
% ze sob� elementy le��ce "najbli�ej" siebie w clustry (2 elementowe).
% Nast�pnie do��cza kolejne elementy itd a� zostanie utworzone ca�e
% hierarchiczne drzewo zawieraj�ce wsyztskie elementy.

Z = linkage(Y)

% ka�dy z wierszy Z okre�la po��czenie element�w lub klastr�w. Pierwsze 2
% kolumny okre�laj� po��czone obiekty, a trzecia kolumna okre�la odleg�o��
% pomiedzy nimi. 
% w powy�szym przyk�adzie w 3 wierszu pojawia si� po��czenie elementu 6 i
% 7 (dane orginalne zawiera�y jedynie 5 danych). Element 6 jest klastem
% zawieraj�cym orginalne elementy 4 i 5, natomiast element 7 jest klastem
% zawieraj�cym orginalne elementy 1 i 3 .Element 8 to zgrupowane dane 1,3,4,5
% informacje zawarte w linkage mo�na zwizualizowac w postaci grafu (drzewa)
% przy pomocy funkcji dendrogram

figure;
dendrogram(Z)

% o� pozioma okre�la indeksy orginalnych danych. Wysoko�� drzewa okre�lona 
% jest poprzez odleg�o�ci pomi�dzy klastrami. Np. link reprezentuj�cy klaster 
% zawieraj�cy element 1 i 3 ma wysoko�� 1. link reprezentuj�cy klaster 
% grupuj�cy element 2 z 8 ma wysoko�� 2.5 (jest to wysoko�� pomi�dzy elementami 2 i 8)

% elementy sk�adowe klastr�w powinny by� jak najbardziej ze sob�
% skorelowane. Do analizy korelacji tych s�u�y funkcja cophenet. Im bli�sze 
% jej wyj�cie jest warto�ci 1 tym lepiej.

c  = cophenet(Z,Y)

%  kolejna z funkcji inconsistent pozwala na obliczanie "odleg�o�ci" 
%  (r�nica wysoko�ci klastra  i �redni� wysoko�ci� klastra, normalizowana 
%  przez odchylenie standardowe).  

I  = inconsistent(Z)

% Tworzenie klastr�w 
% *************************************************************************
% 
% Klastry mo�na utworzy� na dwa sposoby:
% 1. Na podstawie ustalanie poziomu miary inconsistent, poprzez "przeci�cie" 
% drzewa w miejscu gdy miara ta przekroczy za�o�ony podzia�: 

T  = cluster(Z,'cutoff',1.2)

% lub np
%T  = cluster(Z,'cutoff',0.8)

% wyjscie z funkcji okre�la kt�ry obiekt zosta� przydzielony do kt�rego
% klastra.

% 2. Na podstawie za�o�onej apriori liczby klastr�w

T  = cluster(Z,'maxclust',2)
% lub np
%T  = cluster(Z,'maxclust',3)

% Na koniec mo�na wyrysowa� dane po podziale, np tak: 

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

close all;
clear;
clc

% przyk�adowe dane 
load kmeansdata;
size(X);

% funkcja kmeans dzieli dane na z g�ry okre�lon� ilo�� klustr�w pos�uguj�c si� 
% okre�lon� metryk� odleg�o�ci, np:  

idx3 = kmeans(X,3,'distance','city');

% aby sprawdzi� czy ten podzia� jest adekwatny, mo�na u�y� funkcji silhouette.
% funkcja ta zwraca warto�� 1 gdy punkt jest "idealnie wpasowany w dany klaster, 
% 0 gdy tak samo pasuje do tego jak i innego klastra oraz 1 gdy na pewno nie 
% nale�y do tego klastra (warto�ci pomi�dzy -1 a 1 niuansuj� powy�sze).

figure;
[silh3,h] = silhouette(X,idx3,'city','display','iter');
set(get(gca,'Children'),'FaceColor',[.8 .8 1])
xlabel('Silhouette Value')
ylabel('Cluster')

% zwi�ksz i zmniejsz liczb� klastr�w aby zobaczy� kt�ra z nich jest
% najlepsza. 
% U�yj funkcji mean aby obliczy� precyzyjnie �redni� warto�� silhouette 

mean(silh3)

% parametr kmeans 'replicates' pozwala na ponawianie iteracyjne algorytmu w
% celu unikni�cia wpadania w lokalne minima. 

[idx4,centroids,sumdist] = kmeans(X,4,'dist','city',...
'display','final','replicates',5);

sum(sumdist)

% dane pogrupowane s� do zbior�w, np:
% X(idx4==1); X(idx4==2); X(idx4==3); X(idx4==4);
% X_klaster1=X(idx4==1,1:size(X,2))
% X_klaster1=X(idx4==2,1:size(X,2))
% X_klaster1=X(idx4==3,1:size(X,2))
% X_klaster1=X(idx4==4,1:size(X,2))

% ostatecznie mo�na wyrysowa� klastry

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

% zwr�� uwag� i� dane orginalne (i pogrupowane) s� wymiaru nx4 wi�c
% powinni�my obejrze� r�wnie� inne wymiary np:

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


%%


% *************************************************************************
% ************      klasteryzacja typu Gaussian Mixture Models    *********
% *************************************************************************

% modele tego typu lepiej si� sprawdzaj� od k-means clustering w
% przypadkach gdy dane w klastrach maj� r�zny rozmiar i korelacj� wzajemn�.
% Algorytmy tego typu cz�sto nazywane s� "mi�kkimi" poniewa� umo�liwiaj�
% nale�enie do kilku klastr�w z pewnym stopniem przynalezno�ci. 

close all;
clear;
clc

% przyk�adowe dane 
mu1 = [1 2];
sigma1 = [3 .2; .2 2];
mu2 = [-1 -2];
sigma2 = [2 0; 0 1];
X = [mvnrnd(mu1,sigma1,200);mvnrnd(mu2,sigma2,100)];

figure;
scatter(X(:,1),X(:,2),10,'ko')

% Funkcja gmdistribution.fit "wpasowuje" Gaussian Mixture Model w dane. 
% W tym przypadku u�yli�my 2 klastr�w 

options = statset('Display','final');
gm = gmdistribution.fit(X,2,'Options',options)

% funkcja ezcontour umo�liwia wykre�lenie wykresu dla utworzonego modelu.

hold on
ezcontour(@(x,y)pdf(gm,[x y]),[-8 6],[-8 6]);
hold off

% funkcja cluster umo�liwia przypisanie danych do obu klastr�w
% wykorzystuj�c gmdistribution.fit

figure;
idx = cluster(gm,X);
cluster1 = (idx == 1);
cluster2 = (idx == 2);
scatter(X(cluster1,1),X(cluster1,2),10,'r+');
hold on
scatter(X(cluster2,1),X(cluster2,2),10,'bo');
hold off
legend('Cluster 1','Cluster 2','Location','NW')

% wiemy jednak �e punkty nie nale�� do danych klastr�w z r�wnym stopniem
% przynale�no�ci. Informacj� t� r�wniez mozemy wykorzysta� przy pomocy
% funkcji posterior

figure;
P = posterior(gm,X);
scatter(X(cluster1,1),X(cluster1,2),10,P(cluster1,1),'+')
hold on
scatter(X(cluster2,1),X(cluster2,2),10,P(cluster2,1),'o')
hold off
legend('Cluster 1','Cluster 2','Location','NW')
clrmap = jet(80); colormap(clrmap(9:72,:))
ylabel(colorbar,'Component 1 Posterior Probability')
 
%%
% *************************************************************************
% ** mi�kka klasteryzacja wykorzystuj�ca Gaussian Mixture Distributions ***
% *************************************************************************

% wykorzystuj�c funkcj� posterior, punkty mog� zosta� posortowane wzgl�dem
% stopni przynale�no�ci do klastr�w i przedtsawione w nast�puj�cy spos�b

figure;
[~,order] = sort(P(:,1));
plot(1:size(X,1),P(order,1),'r-',1:size(X,1),P(order,2),'b-');
legend({'Cluster 1 Score' 'Cluster 2 Score'},'location','NW');
ylabel('Cluster Membership Score');
xlabel('Point Ranking');

% jak wida� na tym wykresie separacja jest w miar� dok�adna (ostra).
% Niewiele punkt�w ma np stopie� przynalezno�ci 0.5. 

% Gaussian Mixture wa�ona macierz� covariancji jest bardzo zbli�ony do 
% fuzzy c - means clustering

gm2 = gmdistribution.fit(X,2,'CovType','Diagonal',...
'SharedCov',true)

figure;
P2 = posterior(gm2,X); 
% ewentualnie: [idx,P2] = cluster(gm2,X)
[~,order] = sort(P2(:,1));
plot(1:size(X,1),P2(order,1),'r-',1:size(X,1),P2(order,2),'b-');
legend({'Cluster 1 Score' 'Cluster 2 Score'},'location','NW');
ylabel('Cluster Membership Score');
xlabel('Point Ranking');


% *******   Przypisywanie nowych danych do utworzonych klastr�w   *********

% nowe dane (Y) mozemy przypisa� do istniejacych klastr�w w nast�puj�cy
% spos�b

figure
Y = [mvnrnd(mu1,sigma1,50);mvnrnd(mu2,sigma2,25)];
idx = cluster(gm,Y);
cluster1 = (idx == 1);
cluster2 = (idx == 2);
scatter(Y(cluster1,1),Y(cluster1,2),10,'r+');
hold on
scatter(Y(cluster2,1),Y(cluster2,2),10,'bo');
hold off
legend('Class 1','Class 2','Location','NW')



