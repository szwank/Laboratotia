function y = Ciezarowka_cwiczenie_sieci(x)
% hObject    handle to start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dlugosc = 80;

fi_rad = 20/180*pi;
xc = 100;
yc = 300;
fi_deg=radtodeg(fi_rad);
theta_deg=0;
global flaga_skret;
global odleglosc;
iter = 1;



start_button_value = true;
start_button_on = true;

net = network(1,3,[0;0;0],[1; zeros(2,1)],[0 0 0; 1 0 0; 0 1 0],[0 0 1]);
net.inputs{1}.range = [-200 200; 0 400; -pi pi];
net.layers{1}.size = 14;
net.layers{2}.size = 14;
net.layers{3}.size = 1;
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
%%zmiana wag sieci
net.IW{1} = reshape(x(1:14*3),[14,3]);
net.LW{2,1} = reshape(x(14*3+1:14*3+14*14),[14,14]);
net.LW{3,2} = reshape(x(14*3+14*14+1:end),[1,14]);
while start_button_value == start_button_on;
    
theta_deg = net([xc(iter);yc(iter);fi_rad(iter)]);
    

    
    

%             theta_deg = net(xc,yc,fi_rad);
            % do uzupelnienia/wymyslenia
            
           
             if theta_deg > 45 
                theta_deg = 45;
            end
            
            if theta_deg < -45 
                theta_deg = -45;
            end

        

    
    theta_rad=degtorad(theta_deg);          % sieæ steruje
    
      if (yc(iter) > 0 && yc(iter) < 400) && (xc(iter) > -200 && xc(iter) < 200)                                                              %//zabepieczenie prrzed wyjazdem poza PLAC
        xc(iter+1)=xc(iter)+sin(theta_rad+fi_rad(iter))-sin(theta_rad)*cos(fi_rad(iter));            %// model matematyczny pojazdu
        yc(iter+1)=yc(iter)-cos(theta_rad+fi_rad(iter))-sin(theta_rad)*sin(fi_rad(iter));            %//fi - kat obrotu osi pojazdu
        fi_rad(iter+1)=fi_rad(iter)-asin(2*sin(theta_rad)/dlugosc);                      %//theta - kat skretu kol
        
        if(fi_rad(iter)>degtorad(180)) fi_rad(iter)=degtorad(-180);
        end
        if(fi_rad(iter)<degtorad(-180)) fi_rad(iter)=degtorad(180);
        end
        
        fi_deg=radtodeg(fi_rad(iter));
      else
          start_button_on = false;
          y = yc(iter) + 10* (pi/2 - fi_rad(iter));
%         xc(iter+1)=xc(iter);            %// model matematyczny pojazdu
%         yc(iter+1)=yc(iter);            %//fi - kat obrotu osi pojazdu
%         fi_rad(iter+1)=fi_rad(iter)-asin(2*sin(theta_rad)/dlugosc);  
      end  

 
    
%     %//-------------------------------------------------------RYSOWANIE
%      cla;                                                                   %//usuwa cala grafike
%      plac = newplot;
%     %//------------------------------------------------------------SLAD
%     xc_rys(iter)=xc;
%     yc_rys(iter)=yc;
%     
%     if(get(handles.rysuj_button,'Value')==(get(hObject,'Max')))            %//rysowanie sladu
%         
%         line(xc_rys,yc_rys)
%         
%     end
%     
%     set(plac,'XLim',[-200,200],'XTick',[-200 -150 -100 -50 0 50 100 150 200]);
%     set(plac,'YLim',[0,400],'YTick',[0 50 100 150 200 250 300 350 400]);
%     
%     xtyl = [xc-14; xc-14; xc+14; xc+14];
%     ytyl = [yc+2; yc+20; yc+20; yc+2];
%     zdata=ones(4,1);
%     tyl=patch(xtyl,ytyl,zdata,'FaceColor','r','EdgeColor','r');
%     
%     xkadlub = [xc-10; xc-10; xc+10; xc+10];
%     ykadlub = [yc+0; yc+dlugosc; yc+dlugosc; yc+0];
%     zdata=ones(4,1);
%     kadlub=patch(xkadlub,ykadlub,zdata,'FaceColor','b','EdgeColor','b');
%     
%     xprzod_l = [xc-14; xc-14; xc-10; xc-10];
%     yprzod_l = [yc+dlugosc-22; yc+dlugosc-2; yc+dlugosc-2; yc+dlugosc-22];
%     zdata=ones(4,1);
%     przod_l=patch(xprzod_l,yprzod_l,zdata,'FaceColor','m','EdgeColor','m');
%     
%     xprzod_p = [xc+10; xc+10; xc+14; xc+14];
%     yprzod_p = [yc+dlugosc-22; yc+dlugosc-2; yc+dlugosc-2; yc+dlugosc-22];
%     zdata=ones(4,1);
%     przod_p=patch(xprzod_p,yprzod_p,zdata,'FaceColor','r','EdgeColor','r');
%     
%     xrampa = [-30; -30; 30; 30];
%     yrampa = [0; 10; 10; 0];
%     zdata=ones(4,1);
%     rampa=patch(xrampa,yrampa,zdata,'FaceColor','b','EdgeColor','b');
%         
%     rotate(przod_l,[0 0 1],theta_deg,[xc-12 yc+dlugosc-11 0]);             %//obrot kol
%     rotate(przod_p,[0 0 1],theta_deg,[xc+12 yc+dlugosc-11 0]);
%     rotate(kadlub,[0 0 1],radtodeg(fi_rad),[xc yc 0]);                     %// obrot pojazdu
%     rotate(tyl,[0 0 1],radtodeg(fi_rad),[xc yc 0]);
%     rotate(przod_l,[0 0 1],radtodeg(fi_rad),[xc yc 0]);
%     rotate(przod_p,[0 0 1],radtodeg(fi_rad),[xc yc 0]);
%     drawnow;
%     
%     %//---------------------------------------------------RYSOWANIE-END
    
    %//-------------------------------------------obliczanie odleglosci
    
    if(iter>=2)
        odleglosc=odleglosc+sqrt((xc(iter)-xc(iter-1))^2+(yc(iter)-yc(iter-1))^2);
    end
    
    
%     %// Wyswietlanie zmiennyh
%     set(handles.fi_show,'String',num2str(radtodeg(fi_rad)));
%     set(handles.theta_show,'String',num2str(radtodeg(theta_rad)));
%     set(handles.xc_show,'String',num2str(xc));
%     set(handles.yc_show,'String',num2str(yc));
%     set(handles.iter_show,'String',num2str(odleglosc));
    
    %//----------------------------------------------------ZAPIS DO TXT
    %log=[xc yc theta_deg];
    %save('log.txt', 'log','-ASCII','-append');
    if (fi_rad(iter) < 1.6057 && fi_rad(iter) > 1.5359) && (xc(iter) < 50 && xc(iter) > 40) && (yc(iter) < 40 && yc(iter) > 0)      % warunek zakoñczenia
                start_button_on = false;
                y = yc(iter) + 10* (pi/2 - fi_rad(iter));
    elseif iter > 10000
        start_button_on = false;
        y = yc(iter) + 10 * abs(pi/2 - fi_rad(iter));
    end
    iter=iter+1; % zwiêkszenie iteratora

end;