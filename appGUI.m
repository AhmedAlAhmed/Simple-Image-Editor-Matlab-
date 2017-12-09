function varargout = appGUI(varargin)


%global variables 
%global I map stackPointer;
%brightnessVal = 0.5;

changesStack = [];










% APPGUI MATLAB code for appGUI.fig
%      APPGUI, by itself, creates a new APPGUI or raises the existing
%      singleton*.
%
%      H = APPGUI returns the handle to a new APPGUI or the handle to
%      the existing singleton*.
%
%      APPGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APPGUI.M with the given input arguments.
%
%      APPGUI('Property','Value',...) creates a new APPGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before appGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to appGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help appGUI

% Last Modified by GUIDE v2.5 26-Dec-2016 12:58:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @appGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @appGUI_OutputFcn, ...
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


function save_to_temp()
n = getappdata(0, 'maxupdates');
n = n + 1;
setappdata(0, 'maxupdates', n);
imwrite(getappdata(0, 'Image'), strcat(strcat('tmp\\tmp', num2str(n)) , '.png'));
setappdata(0, 'stackPointer', n);

function loadTemp(H)
h = getappdata(0, 'stackPointer');
h = h - 1;
if h < 1 return; end

setappdata(0, 'stackPointer', h);
X = imread(strcat('tmp\\tmp', num2str(h), '.png'));
axes(H.axes1);
setappdata(0, 'Image', X);
imshow(X);


function redo(H)
h = getappdata(0, 'stackPointer');
h = h +1;
if h > getappdata(0, 'maxupdates') return; end

setappdata(0, 'stackPointer', h);
X = imread(strcat('tmp\\tmp', num2str(h), '.png'));
axes(H.axes1);
setappdata(0, 'Image', X);
imshow(X);


% --- Executes just before appGUI is made visible.
function appGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to appGUI (see VARARGIN)

% Choose default command line output for appGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes appGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = appGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;

[patch,user_cance]=imgetfile();
if user_cance 
    return
end 
setappdata(0,'brightnessVal',0.5);
setappdata(0, 'is_hsv', 0);
setappdata(0,'stackPointer', 0);
setappdata(0, 'maxupdates', 0);

[I1 map]=imread(patch);
I1=im2double(I1);
IBackup=I1; %for backup process :)
set(handles.edit1,'string',patch);
axes(handles.axes1);
imshow(I1);

setappdata(0, 'Image', I1);
setappdata(0, 'map', []);
save_to_temp();


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
bnv = get(handles.slider1,'Value');


gImage = getappdata(0, 'Image');

stackPointer1 = getappdata(0, 'stackPointer');
brightnessVal1 = getappdata(0, 'brightnessVal');

sz = size(gImage);
if sz(1) == 0 && sz(2) == 0 
    return;
end;

q = [];

if bnv > brightnessVal1
     q = imadd(gImage, ((bnv-brightnessVal1)/2));
else
    q = imsubtract(gImage, ((brightnessVal1-bnv)/2));
end
brightnessVal1 = bnv;    

setappdata(0, 'brightnessVal', bnv);
setappdata(0, 'Image', q);

getappdata(0, 'Image')

save_to_temp();

axes(handles.axes1);
imshow(q);



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
bnv = get(handles.slider2,'Value');

setappdata(0,'Image',imadjust(getappdata(0,'Image'),[bnv bnv+0.1],[0;1]));
axes(handles.axes1);
save_to_temp();
imshow(getappdata(0, 'Image'));

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
resv = get(handles.slider3,'Value');
Im = getappdata(0, 'Image');

sz = size(Im);
if sz(1) == 0 && sz(2) == 0 
    return;
end;
Im = imresize(Im, resv);

setappdata(0, 'Image', Im);


save_to_temp()

axes(handles.axes1);
imshow(Im);

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Im = getappdata(0, 'Image');
%sz = size(Im);
%if sz(1) == 0 && sz(2) == 0 
 %   return;
%end;
Im1 = imrotate(Im, 90.0);

setappdata(0, 'Image', Im1);

save_to_temp()

axes(handles.axes1);
imshow(getappdata(0,'Image'));

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Im = getappdata(0, 'Image');
sz = size(Im);
if sz(1) == 0 && sz(2) == 0 
    return;
end;
Im = imrotate(Im, -90.0);

setappdata(0, 'Image', Im);

save_to_temp()

axes(handles.axes1);
imshow(Im);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Im = getappdata(0, 'Image');
sz = size(Im);
if sz(1) == 0 && sz(2) == 0 
    return;
end;
Im = imcrop(Im);
setappdata(0, 'Image', Im);

save_to_temp()

axes(handles.axes1);
imshow(Im);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
allItems = get(handles.popupmenu2,'string')
selectedIndex = get(handles.popupmenu2,'Value')
selectedItem = allItems{selectedIndex};

Im = getappdata(0, 'Image');
sz = size(Im);
if sz(1) == 0 && sz(2) == 0 
    return;
end;
if  strcmp(selectedItem , 'Vertical Flip')  
    Im = flipdim(Im,1);
else    
    Im = flipdim(Im,2);
end

save_to_temp()

setappdata(0, 'Image', Im);
axes(handles.axes1);
imshow(Im);


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
allItems = get(handles.popupmenu3,'string')
selectedIndex = get(handles.popupmenu3,'Value')
selectedItem = allItems{selectedIndex};

Im = getappdata(0, 'Image');

sz = size(Im);
if sz(1) == 0 && sz(2) == 0 
    return;
end;

if  strcmp(selectedItem , 'From RGB To Index')  
    [I, map] = rgb2ind(Im, 256);
    setappdata(0, 'map', map);
elseif strcmp(selectedItem , 'From RGB to Gray Scale')  
    I = rgb2gray(Im);
elseif strcmp(selectedItem, 'From Index To Gray Scale')
    I = ind2gray(Im, getappdata(0, 'map'));
elseif strcmp(selectedItem, 'From Gray Scale To Index')
    [I map] = gray2ind(Im);
    setappdata(0, 'map', map);
elseif strcmp(selectedItem, 'From Index To RGB')
    I = ind2rgb(Im, getappdata(0, 'map'));
end

setappdata(0, 'Image', I);

save_to_temp()


axes(handles.axes1);
imshow(I);


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4
allItems = get(handles.popupmenu4,'string')
selectedIndex = get(handles.popupmenu4,'Value')
selectedItem = allItems{selectedIndex};

switch(selectedItem)
    
    case 'Winter'
        colormap winter;
    case 'Hot' 
        colormap 'Hot';
    case 'Jet'
        colormap 'Jet';
    case 'HSV'
        colormap 'HSV';
    case 'Gray'
        colormap 'Gray';
    case 'Bone'
        colormap 'Bone';
    case 'Copper'
        colormap 'Coller';
    case 'Pink'
        colormap 'Pink';
    case 'White'
        colormap 'White';
    case 'Flag'
        colormap 'Flag';
    case 'Lines'
        colormap 'Lines';
    case 'Color Cube'
        colormap Colorcube;
    case 'VGA'
        colormap 'VGA';
    case 'Cool'
        colormap 'Cool';
    case 'Autumn'
        colormap 'Autumn';
    case 'Spring'
        colormap 'Spring';
    case 'Summer'
        colormap 'Summer';
end

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

loadTemp(handles);

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
redo(handles);

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I = getappdata(0, 'Image');
axes(handles.axes1);
imshow(I);


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I = getappdata(0, 'Image');


I = rgb2hsv(I);
setappdata(0, 'Image', I);
setappdata(0, 'is_hsv', 1);
save_to_temp()

axes(handles.axes1);
imshow(I);

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[patch,PathName]=uiputfile();

Im = getappdata(0, 'Image');
imwrite(Im, strcat(strcat(PathName, patch) , '.png'));


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h = getappdata(0, 'is_hsv');
if h == 1
    Im = getappdata(0, 'Image');
    Im = hsv2rgb(Im);
    Im = rgb2ntsc(Im);
    axes(handles.axes1);
    imshow(Im);
    setappdata(0, 'Image', Im);
    save_to_temp()
end
