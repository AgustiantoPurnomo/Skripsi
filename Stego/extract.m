function varargout = extract(varargin)
%EXTRACT MATLAB code file for extract.fig
%      EXTRACT, by itself, creates a new EXTRACT or raises the existing
%      singleton*.
%
%      H = EXTRACT returns the handle to a new EXTRACT or the handle to
%      the existing singleton*.
%
%      EXTRACT('Property','Value',...) creates a new EXTRACT using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to extract_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      EXTRACT('CALLBACK') and EXTRACT('CALLBACK',hObject,...) call the
%      local function named CALLBACK in EXTRACT.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help extract

% Last Modified by GUIDE v2.5 11-Jan-2018 22:55:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @extract_OpeningFcn, ...
                   'gui_OutputFcn',  @extract_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before extract is made visible.
function extract_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for extract
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes extract wait for user response (see UIRESUME)
% uiwait(handles.figur);


% --- Outputs from this function are returned to the command line.
function varargout = extract_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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

% --- Executes on button press in openImg.
function openImg_Callback(hObject, eventdata, handles)
% hObject    handle to openImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
proyek = guidata(gcbo);
try
[namafile,direktori]=uigetfile({'*.bmp';'*.jpg';'*.png'},'Buka Gambar');
image = imread(namafile);
set(proyek.figur,'CurrentAxes',proyek.resultImg);
set(imshow(image));
set(proyek.resultImg,'Userdata',image);
catch exception
end

% --- Executes on button press in extract.
function extract_Callback(hObject, eventdata, handles)
% hObject    handle to extract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
proyek = guidata(gcbo);
img = get(proyek.resultImg,'Userdata');

switch get(proyek.popupmenu1,'Value');
    case 1
    case 2
        try
        textbin = ExtractLsb(img);
        set(proyek.textlist,'String',textbin);
        set(proyek.textlist,'Userdata',textbin);
        catch
            msgbox('Pesan gagal di ekstrak Lsb','Ekstrak'); 
        end 
end

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
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
%catch    
%end


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
