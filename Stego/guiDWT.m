function varargout = guiDWT(varargin)
% GUIDWT MATLAB code for guiDWT.fig
%      GUIDWT, by itself, creates a new GUIDWT or raises the existing
%      singleton*.
%
%      H = GUIDWT returns the handle to a new GUIDWT or the handle to
%      the existing singleton*.
%
%      GUIDWT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDWT.M with the given input arguments.
%
%      GUIDWT('Property','Value',...) creates a new GUIDWT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guiDWT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guiDWT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guiDWT

% Last Modified by GUIDE v2.5 11-Apr-2018 20:52:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @guiDWT_OpeningFcn, ...
    'gui_OutputFcn',  @guiDWT_OutputFcn, ...
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


% --- Executes just before guiDWT is made visible.
function guiDWT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guiDWT (see VARARGIN)

% Choose default command line output for guiDWT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guiDWT wait for user response (see UIRESUME)
% uiwait(handles.guiDWT);


% --- Outputs from this function are returned to the command line.
function varargout = guiDWT_OutputFcn(hObject, eventdata, handles)
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
    [namafile,direktori]=uigetfile({'*.bmp';'*.png'},'Open Image');
    [folder, baseFileName, extension] = fileparts(strcat(direktori,namafile));
    fullpath = strcat(direktori,namafile);
    image = imread(fullpath);
    global imgbit namaimg extimg;
    imgbit = imfinfo(strcat(direktori,namafile));
    imgbit = imgbit.BitDepth;
    namaimg = baseFileName;
    extimg = extension;
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
global namatxt;
try
    [namafile,direktori]=uigetfile('*.txt','Open Text');
    namatxt = strcat(direktori,namafile);
    teks = fopen(strcat(direktori,namafile),'r');
    set(proyek.stego,'Userdata',teks);
    charteks = fread(teks,'uint8=>char');
    fclose(teks);
    pesan = sprintf(charteks);
    set(proyek.textlist,'String',pesan);
    set(proyek.textlist,'Userdata',pesan);
catch
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

% --- Executes on button press in stegano.
function stegano_Callback(hObject, eventdata, handles)
% hObject    handle to stegano (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imgbit namaimg namatxt extimg;

if(imgbit == 24)
    bitdepth = 'int8';
else
    bitdepth = 'int16';
end

proyek = guidata(gcbo);
img = get(proyek.coverImg,'Userdata');

switch get(proyek.metode,'Value');
    case 1
        try
            gbrstg = stegoDWT2(img,namatxt,bitdepth);
            
            catnama = strcat('dwt-',namaimg,extimg);
            imwrite(gbrstg,catnama);
            
            msgbox('Gambar berhasil distego','Stego');
        catch
            msgbox('Gambar gagal di stego','Stego');
        end
    case 2
        try
            gbr2=stegolsb(img,namatxt);
            
            catnama = strcat('lsb-',namaimg,extimg);
            imwrite(gbr2,catnama);
                        
            msgbox('Gambar berhasil distego','Stego');
        catch
            msgbox('Gambar gagal di stego','Stego');
        end
end
% --- Executes on selection change in metode.
function metode_Callback(hObject, eventdata, handles)
% hObject    handle to metode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns metode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from metode


% --- Executes during object creation, after setting all properties.
function metode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to metode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
