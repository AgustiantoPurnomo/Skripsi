function varargout = extractfig(varargin)
% EXTRACTFIG MATLAB code for extractfig.fig
%      EXTRACTFIG, by itself, creates a new EXTRACTFIG or raises the existing
%      singleton*.
%
%      H = EXTRACTFIG returns the handle to a new EXTRACTFIG or the handle to
%      the existing singleton*.
%
%      EXTRACTFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXTRACTFIG.M with the given input arguments.
%
%      EXTRACTFIG('Property','Value',...) creates a new EXTRACTFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before extractfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to extractfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help extractfig

% Last Modified by GUIDE v2.5 11-Apr-2018 21:33:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @extractfig_OpeningFcn, ...
    'gui_OutputFcn',  @extractfig_OutputFcn, ...
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


% --- Executes just before extractfig is made visible.
function extractfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to extractfig (see VARARGIN)

% Choose default command line output for extractfig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes extractfig wait for user response (see UIRESUME)
% uiwait(handles.extractfig);


% --- Outputs from this function are returned to the command line.
function varargout = extractfig_OutputFcn(hObject, eventdata, handles)
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
global imgbit namaimg namatxt;
proyek = guidata(gcbo);
try
    [namafile,direktori]=uigetfile({'*.png'},'Open Image');
    image = imread(namafile);
    imgbit = imfinfo(namafile);
    imgbit = imgbit.BitDepth;
    [folder, baseFileName, extension] = fileparts(namafile);
    namaimg = baseFileName;
    set(proyek.extractfig,'CurrentAxes',proyek.resultImg);
    set(imshow(image));
    set(proyek.resultImg,'Userdata',image);
    namatxt = namafile;
    textbin = '';
    set(proyek.textlist,'Value',1);
    set(proyek.textlist,'String',textbin);
    set(proyek.textlist,'Userdata',textbin);
catch
end

% --- Executes on button press in extractfig.
function extract_Callback(hObject, eventdata, handles)
% hObject    handle to extractfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imgbit namaimg namatxt;
proyek = guidata(gcbo);
img = get(proyek.resultImg,'Userdata');

switch get(proyek.metode,'Value');
    case 1
        try
            textbin = stegoXDWT2(img);
            set(proyek.textlist,'Value',1);
            set(proyek.textlist,'String',textbin);
            set(proyek.textlist,'Userdata',textbin);
            
            catnama = strcat('extract',namaimg,'.txt');
            teks = fopen(catnama,'w');
            pesan = get(proyek.textlist,'Userdata');
            fprintf(teks,pesan);
            fclose(teks);
        catch
            msgbox('Pesan gagal diekstrak dengan DWT','Ekstrak');
        end
    case 2
        try
            textbin = ExtractLsb(img);
            set(proyek.textlist,'Value',1);
            set(proyek.textlist,'String',textbin);
            set(proyek.textlist,'Userdata',textbin);
            
            catnama = strcat('extract',namaimg,'.txt');
            teks = fopen(catnama,'w');
            pesan = get(proyek.textlist,'Userdata');
            fprintf(teks,pesan);
            fclose(teks);
        catch
            msgbox('Pesan gagal di ekstrak Lsb','Ekstrak');
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
