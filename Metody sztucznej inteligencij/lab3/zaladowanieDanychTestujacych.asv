for i = 1:3
   bufor = zeros(100,3);
   A = imread(strjoin({'LTest',num2str(i),'.png'},''));
   LTest(:,:,i) = A(:,:,1);
   LTestOdp(i) = 1;
   for j = 1:10
    for k = 1:10 
        if LTest(j,k,i)==255;
            LTest(j,k,i)=0;
        else
            LTest(j,k,i)=1;
        end
    end
   end
   
   for j = 1:10
    for k = 1:10
        bufor((j-1)*10+k,i) = LTest(j,k,i);%%stowrzenie wektora z tablic
    end
   end
end
LTest = bufor;

for i = 1:3
   A = imread(strjoin({'OTest',num2str(i),'.png'},''));
   OTest(:,:,i) = A(:,:,1);
    OTestOdp(i) = 1;
    
   for j = 1:10
    for k = 1:10 
        if OTest(j,k,i)==255;
            OTest(j,k,i)=0;
        else
            OTest(j,k,i)=1;
        end
    end
   end
   
   for j = 1:10
    for k = 1:10
        bufor((j-1)*10+k,i) = OTest(j,k,i);%%stowrzenie wektora z tablic
    end
   end
end
OTest = bufor;

for i = 1:3
   A = imread(strjoin({'VTest',num2str(i),'.png'},''));
   VTest(:,:,i) = A(:,:,1);
    LTestOdp(i) = 1;
   for j = 1:10
    for k = 1:10 
        if VTest(j,k,i)==255;
            VTest(j,k,i)=0;
        else
            VTest(j,k,i)=1;
        end
    end
   end
   
   for j = 1:10
    for k = 1:10
        bufor((j-1)*10+k,i) = VTest(j,k,i);%%stowrzenie wektora z tablic
    end
   end
end
VTest = bufor;

odpowiedzTestowa = ones(1,3);
odpowiedzTestowa(2,4:6) = ones(1,3);
odpowiedzTestowa(3,7:9) = ones(1,3);
odpowiedzTestowa = double(odpowiedzTestowa);
daneTestowe = LTest;
daneTestowe(:,4:6) = OTest;
daneTestowe(:,7:9) = VTest;
daneTestowe = double(daneTestowe);