A=[-100 0 0;
   1 -15 0;
   0 1 0];
B=[1000;
   0;
   0];
C=[0 0 0.4];
syms l1 l2 l3;
Acl=A-B*[l1 l2 l3];
syms p p1 p2 p3;
wielomian=det(A-[p1 0 0; 0 p2 0; 0 0 p3]);
wielomian2=det(Acl-[p1 0 0; 0 p2 0; 0 0 p3]);

wielomian3=det([p1 0 0; 0 p2 0; 0 0 p3]-Acl);

%% moja wersja

wielomian4=det([p 0 0; 0 p 0; 0 0 p]-Acl)
