for i = 1:7
   A = imread(strjoin({'L',num2str(i),'.png'},''));
   L(:,:,i) = A(:,:,1);
   LOdp(i) = 1;
   %%%%%%%%%%%%%%%%%%%%%%%%% zmiana wartoœci
   for j = 1:10
    for k = 1:10 
        if L(j,k,i)==255;
            L(j,k,i)=0;
        else
            L(j,k,i)=1;
        end
    end
   end
   %%%%%%%%%%%%%%%%%% zmiana wartoœci
   %%%%%%%%%%%%%%%%%% zmiana na wektor
   for j = 1:10
    for k = 1:10
        bufor((j-1)*10+k,i) = L(j,k,i);%%stowrzenie wektora z tablic
    end
   end
end
L=bufor;

for i = 1:7
   A = imread(strjoin({'O',num2str(i),'.png'},''));
   O(:,:,i) = A(:,:,1);
     OOdp(i) = 1;
   for j = 1:10
    for k = 1:10 
        if O(j,k,i)==255;
            O(j,k,i)=0;
        else
            O(j,k,i)=1;
        end
    end
   end
   
   for j = 1:10
    for k = 1:10
        bufor((j-1)*10+k,i) = O(j,k,i);%%stowrzenie wektora z tablic
    end
   end
end
O = bufor;

for i = 1:7
   A = imread(strjoin({'V',num2str(i),'.png'},''));
   V(:,:,i) = A(:,:,1);
    VOdp(i) = 1;
   for j = 1:10
    for k = 1:10 
        if V(j,k,i)==255;
            V(j,k,i)=0;
        else
            V(j,k,i)=1;
        end
    end
   end
   
   for j = 1:10
    for k = 1:10
        bufor((j-1)*10+k,i) = V(j,k,i);%%stowrzenie wektora z tablic
    end
   end
end
V=bufor;

%% zlo¿enie ca³oœci
daneUczace = L;
daneUczace(:,8:14) = O;
daneUczace(:,15:21) = V;
daneUczace=double(daneUczace);

odpowiedz = LOdp;
odpowiedz(2,8:14) = OOdp;
odpowiedz(3,15:21) = VOdp;
odpowiedz=double(odpowiedz);