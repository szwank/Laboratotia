load('przyklad2.mat')
options = optimoptions('linprog','Algorithm','dual-simplex');
unnamed = [cell2mat(A);
            B{1},zeros(32,83);
            zeros(27,53),B{2},zeros(27,36);
            zeros(8,100),B{3},zeros(8,25);
            zeros(8,111),B{4},zeros(8,14);
            zeros(5,122),B{5};]


[x,f]=linprog(cell2mat(C), [], [], unnamed, [b0;cell2mat(b')],zeros(length(unnamed)),[],[],options)
