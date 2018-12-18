clear
N = 13;
Nu = 10;
D = 13;
u = [0,0,0,0,0,ones(1,33)];
lambda = 3;
y = zeros(1,10);
for i = 4:33

   y(i) = 0.5*y(i-1) + 0.2*u(i-3);
 
end
% close all
% figure
% hold on
% plot(y)
% plot(u)

for i = 1:D
    
    s{i} = y(i+2);
    s_g1(1,i) = s{i};
end

% ilosc_zerowych = 0;
% s_g1Cutted = 0;
% for i = 1:length(s_g1)
%    if s_g1(i) ~= 0           
%         s_g1Cutted(end+1) = s_g1(i);
%    else
%        ilosc_zerowych = ilosc_zerowych + 1;
%    end
% end    
% s_g1Cutted(1) = [];
% s_g1 = [0,0,0.3163,0.4787,0.5620,...
%  0.6048,0.6268,0.6381,0.6439,...
%  0.6469,0.6484,0.6492];

for i = 1:Nu
    
   M(:,i) = [zeros(i-1,1);s_g1(1:N+1-i)'];
    
end
M

for i = 1:D-1
   
   for j = 1:N
        if N-1 < j+i
            wektor(j) = s_g1(end);
        else    
            wektor(j) = s_g1(j+1);
        end
        wektor2(j) = s_g1(i);
   end
   
   Mp(:,i) = wektor' - wektor2';
    
end
Mp
% przyklad = hankel(1:4)
% M = fliplr(hankel(s_g1Cutted,zeros(1,length(s_g1Cutted))))'
MT = M';
Ml = MT*M+lambda*eye(length(M(1,:)));
K = (inv(Ml))*MT;
Kl = K(1,:);

for i = 1:length(Mp(1,:))
    
    Ku{i} = Kl*Mp(:,i);
     
end
Ku

Ke = 0;
for i = 1:length(K(1,:))
    
    Ke = Ke + K(1,i);
     
end  
Ke