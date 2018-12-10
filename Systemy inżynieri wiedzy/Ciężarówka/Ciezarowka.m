function varargout = Ciezarowka(varargin)
% CIEZAROWKA MATLAB code for Ciezarowka.fig
%      CIEZAROWKA, by itself, creates a new CIEZAROWKA or raises the existing
%      singleton*.
%
%      H = CIEZAROWKA returns the handle to a new CIEZAROWKA or the handle to
%      the existing singleton*.
%
%      CIEZAROWKA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CIEZAROWKA.M with the given input arguments.
%
%      CIEZAROWKA('Property','Value',...) creates a new CIEZAROWKA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Ciezarowka_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Ciezarowka_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Ciezarowka

% Last Modified by GUIDE v2.5 06-Nov-2013 22:02:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Ciezarowka_OpeningFcn, ...
                   'gui_OutputFcn',  @Ciezarowka_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Ciezarowka is made visible.
function Ciezarowka_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Ciezarowka (see VARARGIN)

% Choose default command line output for Ciezarowka
handles.output = hObject;



% Update handles structure
guidata(hObject, handles);
axes(handles.axes1);


% UIWAIT makes Ciezarowka wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Ciezarowka_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start_button.
function start_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dlugosc = 80;
global xc;
global yc;
global fi_rad;
global iter;

fi_deg=radtodeg(fi_rad);
theta_deg=0;
global xc_rys;
global yc_rys;
global flaga_skret;
global odleglosc;

start_button_value = get(hObject,'Value');
start_button_on=get(hObject,'Max');

while start_button_value == start_button_on;
    
    start_button_value = get(hObject,'Value');                             %//sprawdza czy nie ma STOPU
    
    iter=iter+1;
    
    if (get(handles.auto_box,'Value')==1)                                  %//sterowanie reczne
        theta_deg=get(handles.theta_slider,'Value');
        
    else
        
        if (get(handles.classic_box,'Value')==1)                           %//sterowanie klasyczne
            
            % do uzupelnieniea
           
            
           
            
            if xc < -100 && fi_rad < 0
                theta_deg = theta_deg - 10;
                
            elseif xc < -100 && yc < 60 && fi_rad < pi/2
                theta_deg = theta_deg - 20;

            elseif xc < -100 
                theta_deg = 0;

            end
            
             if xc >= -100 && fi_rad > -pi/4 && yc > 100
                theta_deg = theta_deg + 10;
            end
            
            if xc >= -100 && fi_rad < -pi/2 && yc > 100
                theta_deg = 0;
            end
            
            if (fi_rad < 1.6057 && fi_rad > 1.5359) && xc < 25
                theta_deg = 0;
            end
             if theta_deg > 45 
                theta_deg = 45;
            end
            
            if theta_deg < -45 
                theta_deg = -45;
            end
        end
        if (get(handles.fuzzy_box,'Value')==1)                             %//rozmyte
            
            % do uzupelnienia/wymyslenia
            
            %loadfis=readfis('xxxxxxxxxxxx');
            %theta_deg=evalfis([xc;yc;fi_deg],loadfis);
            
        end
        
    end
    
    theta_rad=degtorad(theta_deg);
    
    if yc>10                                                               %//zabepieczenie prrzed wyjazdem poza PLAC
        xc=xc+sin(theta_rad+fi_rad)-sin(theta_rad)*cos(fi_rad);            %// model matematyczny pojazdu
        yc=yc-cos(theta_rad+fi_rad)-sin(theta_rad)*sin(fi_rad);            %//fi - kat obrotu osi pojazdu
        fi_rad=fi_rad-asin(2*sin(theta_rad)/dlugosc);                      %//theta - kat skretu kol
        
        if(fi_rad>degtorad(180)) fi_rad=degtorad(-180)
        end
        if(fi_rad<degtorad(-180)) fi_rad=degtorad(180)
        end
        
        fi_deg=radtodeg(fi_rad);
        
    end
    
    
    %//-------------------------------------------------------RYSOWANIE
     cla;                                                                   %//usuwa cala grafike
     plac = newplot;
    %//------------------------------------------------------------SLAD
    xc_rys(iter)=xc;
    yc_rys(iter)=yc;
    
    if(get(handles.rysuj_button,'Value')==(get(hObject,'Max')))            %//rysowanie sladu
        
        line(xc_rys,yc_rys)
        
    end
    
    set(plac,'XLim',[-200,200],'XTick',[-200 -150 -100 -50 0 50 100 150 200]);
    set(plac,'YLim',[0,400],'YTick',[0 50 100 150 200 250 300 350 400]);
    
    xtyl = [xc-14; xc-14; xc+14; xc+14];
    ytyl = [yc+2; yc+20; yc+20; yc+2];
    zdata=ones(4,1);
    tyl=patch(xtyl,ytyl,zdata,'FaceColor','r','EdgeColor','r');
    
    xkadlub = [xc-10; xc-10; xc+10; xc+10];
    ykadlub = [yc+0; yc+dlugosc; yc+dlugosc; yc+0];
    zdata=ones(4,1);
    kadlub=patch(xkadlub,ykadlub,zdata,'FaceColor','b','EdgeColor','b');
    
    xprzod_l = [xc-14; xc-14; xc-10; xc-10];
    yprzod_l = [yc+dlugosc-22; yc+dlugosc-2; yc+dlugosc-2; yc+dlugosc-22];
    zdata=ones(4,1);
    przod_l=patch(xprzod_l,yprzod_l,zdata,'FaceColor','m','EdgeColor','m');
    
    xprzod_p = [xc+10; xc+10; xc+14; xc+14];
    yprzod_p = [yc+dlugosc-22; yc+dlugosc-2; yc+dlugosc-2; yc+dlugosc-22];
    zdata=ones(4,1);
    przod_p=patch(xprzod_p,yprzod_p,zdata,'FaceColor','r','EdgeColor','r');
    
    xrampa = [-30; -30; 30; 30];
    yrampa = [0; 10; 10; 0];
    zdata=ones(4,1);
    rampa=patch(xrampa,yrampa,zdata,'FaceColor','b','EdgeColor','b');
        
    rotate(przod_l,[0 0 1],theta_deg,[xc-12 yc+dlugosc-11 0]);             %//obrot kol
    rotate(przod_p,[0 0 1],theta_deg,[xc+12 yc+dlugosc-11 0]);
    rotate(kadlub,[0 0 1],radtodeg(fi_rad),[xc yc 0]);                     %// obrot pojazdu
    rotate(tyl,[0 0 1],radtodeg(fi_rad),[xc yc 0]);
    rotate(przod_l,[0 0 1],radtodeg(fi_rad),[xc yc 0]);
    rotate(przod_p,[0 0 1],radtodeg(fi_rad),[xc yc 0]);
    drawnow;
    
    %//---------------------------------------------------RYSOWANIE-END
    
    %//-------------------------------------------obliczanie odleglosci
    
    if(iter>=2)
        odleglosc=odleglosc+sqrt((xc_rys(iter)-xc_rys(iter-1))^2+(yc_rys(iter)-yc_rys(iter-1))^2);
    end
    
    
    %// Wyswietlanie zmiennyh
    set(handles.fi_show,'String',num2str(radtodeg(fi_rad)));
    set(handles.theta_show,'String',num2str(radtodeg(theta_rad)));
    set(handles.xc_show,'String',num2str(xc));
    set(handles.yc_show,'String',num2str(yc));
    set(handles.iter_show,'String',num2str(odleglosc));
    
    %//----------------------------------------------------ZAPIS DO TXT
    %log=[xc yc theta_deg];
    %save('log.txt', 'log','-ASCII','-append');
    
    
end;


% --- Executes on button press in stop_button.
function stop_button_Callback(hObject, eventdata, handles)
% hObject    handle to stop_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.start_button,'Value',0);



% --- Executes on slider movement.
function theta_slider_Callback(hObject, eventdata, handles)
% hObject    handle to theta_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function theta_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1



function xc_start_Callback(hObject, eventdata, handles)
% hObject    handle to xc_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xc_start as text
%        str2double(get(hObject,'String')) returns contents of xc_start as a double



% --- Executes during object creation, after setting all properties.
function xc_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xc_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yc_start_Callback(hObject, eventdata, handles)
% hObject    handle to yc_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yc_start as text
%        str2double(get(hObject,'String')) returns contents of yc_start as a double


% --- Executes during object creation, after setting all properties.
function yc_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yc_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fi_start_Callback(hObject, eventdata, handles)
% hObject    handle to fi_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fi_start as text
%        str2double(get(hObject,'String')) returns contents of fi_start as a double


% --- Executes during object creation, after setting all properties.
function fi_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fi_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in auto_box.
function auto_box_Callback(hObject, eventdata, handles)
% hObject    handle to auto_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of auto_box



function fi_show_Callback(hObject, eventdata, handles)
% hObject    handle to fi_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fi_show as text
%        str2double(get(hObject,'String')) returns contents of fi_show as a double


% --- Executes during object creation, after setting all properties.
function fi_show_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fi_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta_show_Callback(hObject, eventdata, handles)
% hObject    handle to theta_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta_show as text
%        str2double(get(hObject,'String')) returns contents of theta_show as a double


% --- Executes during object creation, after setting all properties.
function theta_show_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in init_button.
function init_button_Callback(hObject, eventdata, handles)
% hObject    handle to init_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 cla;                                                                      %//usuwa cala grafike
 
 global xc;
 global yc;
 global fi_rad;
 global iter;
 xc=str2num(get(handles.xc_start,'String'));                               %//inicjalizacja zmiennych srodka ciezarowki
 yc=str2num(get(handles.yc_start,'String'));
 fi_deg=str2num(get(handles.fi_start,'String'));
 fi_rad=degtorad(fi_deg);
 iter=0;
 
 global xc_rys;
 global yc_rys;
 xc_rys=[0];
 yc_rys=[0];
 global flaga_skret;
 flaga_skret=0;
 global odleglosc;
 odleglosc=0;
 
 if(xc<=-140 || xc>=140 || yc<=70 || yc>=310)
     msgbox('Pozycja poczatkowa poza dopuszczalnymi (xc <-140 140>, yc <70 310>). Wybierz wartosci wsrod dopuszczalnych.');
 end

 



function xc_show_Callback(hObject, eventdata, handles)
% hObject    handle to xc_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xc_show as text
%        str2double(get(hObject,'String')) returns contents of xc_show as a double


% --- Executes during object creation, after setting all properties.
function xc_show_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xc_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yc_show_Callback(hObject, eventdata, handles)
% hObject    handle to yc_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yc_show as text
%        str2double(get(hObject,'String')) returns contents of yc_show as a double


% --- Executes during object creation, after setting all properties.
function yc_show_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yc_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function iter_show_Callback(hObject, eventdata, handles)
% hObject    handle to iter_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iter_show as text
%        str2double(get(hObject,'String')) returns contents of iter_show as a double


% --- Executes during object creation, after setting all properties.
function iter_show_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iter_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rysuj_button.
function rysuj_button_Callback(hObject, eventdata, handles)
% hObject    handle to rysuj_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in classic_box.
function classic_box_Callback(hObject, eventdata, handles)
% hObject    handle to classic_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of classic_box
set(handles.fuzzy_box,'Value',0);


% --- Executes on button press in fuzzy_box.
function fuzzy_box_Callback(hObject, eventdata, handles)
% hObject    handle to fuzzy_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fuzzy_box
set(handles.classic_box,'Value',0);   
