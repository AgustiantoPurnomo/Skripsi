function varargout = stego(varargin)
% STEGO MATLAB code for stego.fig
%      STEGO, by itself, creates a new STEGO or raises the existing
%      singleton*.
%
%      H = STEGO returns the handle to a new STEGO or the handle to
%      the existing singleton*.
%
%      STEGO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEGO.M with the given input arguments.
%
%      STEGO('Property','Value',...) creates a new STEGO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stego_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stego_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stego

% Last Modified by GUIDE v2.5 10-Apr-2018 11:27:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stego_OpeningFcn, ...
                   'gui_OutputFcn',  @stego_OutputFcn, ...
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


% --- Executes just before stego is made visible.
function stego_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stego (see VARARGIN)

% Choose default command line output for stego
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes stego wait for user response (see UIRESUME)
% uiwait(handles.stego);


% --- Outputs from this function are returned to the command line.
function varargout = stego_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in openImg.
function openImg_Callback(hObject, eventdata, handles)
% hObject    handle to openImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
proyek = guidata(gcbo);
try
[namafile,direktori]=uigetfile({'*.jpg';'*.bmp';'*.png'},'Open Image');
image = imread(namafile);
set(proyek.stego,'CurrentAxes',proyek.coverImg);
set(imshow(image));
set(proyek.coverImg,'Userdata',image);
set(proyek.txtNamaFile,'String',namafile);
set(proyek.txtNamaFile,'Userdata',namafile);
catch
end

% --- Executes on button press in openTxt.
function openTxt_Callback(hObject, eventdata, handles)
% hObject    handle to openTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
proyek = guidata(gcbo);
try
[namafile,direktori]=uigetfile('*.txt','Open Text');
teks = fopen(namafile,'r');
set(proyek.stego,'Userdata',teks)
charteks = fread(teks,'uint8=>char');
fclose(teks);
pesan = sprintf(charteks);
set(proyek.namafiletxt,'String',namafile);
set(proyek.namafiletxt,'Userdata',namafile);
set(proyek.namafiletxt,'visible','on')
set(proyek.textlist,'String',pesan);
set(proyek.textlist,'Userdata',pesan);
catch
end

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


% --- Executes on selection change in textlist.
function textlist_Callback(hObject, eventdata, handles)
% hObject    handle to textlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns textlist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from textlist


% --- Executes during object creation, after setting all properties.
function textlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in saveImg.
function saveImg_Callback(hObject, eventdata, handles)
% hObject    handle to saveImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
proyek = guidata(gcbo);
%try
[namafile,direktori]=uiputfile({'*.bmp';'*.png'},'Simpan Gambar');
gbr2=get(proyek.resultImg,'Userdata');
imwrite(uint8(gbr2), namafile);

msgbox('Gambar berhasil disimpan','Simpan Gambar');
%catch
%end

% --- Executes on button press in saveTxt.
function saveTxt_Callback(hObject, eventdata, handles)
% hObject    handle to saveImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
proyek = guidata(gcbo);
%try
[namafile,direktori]=uiputfile('*.txt','Simpan teks');
teks = fopen(namafile,'w');
pesan = get(proyek.textlist,'Userdata');
fprintf(teks,pesan);
fclose(teks);
msgbox('Pesan berhasil disimpan','Simpan teks');

% --- Executes on button press in stegano.
function stegano_Callback(hObject, eventdata, handles)
% hObject    handle to stegano (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
proyek = guidata(gcbo);
img = get(proyek.coverImg,'Userdata');
namafile = get(proyek.namafiletxt,'Userdata');
try
gbr2=stegolsb(img,namafile);
set(proyek.stego,'CurrentAxes',proyek.resultImg);
set(imshow(gbr2));
set(proyek.resultImg,'Userdata',gbr2);
textbin = ExtractLsb(uint8(gbr2));
set(proyek.textResult,'String',textbin);
set(proyek.textResult,'Userdata',textbin);
msgbox('Gambar berhasil distego','Stego');
catch
msgbox('Gambar gagal di stego','Stego');    
end


% --- Executes on selection change in textResult.
function textResult_Callback(hObject, eventdata, handles)
% hObject    handle to textResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns textResult contents as cell array
%        contents{get(hObject,'Value')} returns selected item from textResult


% --- Executes during object creation, after setting all properties.
function textResult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
