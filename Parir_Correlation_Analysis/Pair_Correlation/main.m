function varargout = main(varargin)
%%PC GUI, Initial
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 08-Mar-2016 16:51:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calculateBut.
function calculateBut_Callback(hObject, eventdata, handles)
% hObject    handle to calculateBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global red green x;
switch x
    case 'p'
        set(handles.resultEdit, 'String','Calculating...');
        redBin = tiffToBinary(red);
        greenBin = tiffToBinary(green);
        pairCorr = pearsonCorr(redBin,greenBin);
        set(handles.resultEdit, 'String',pairCorr);
    case 'o'
        set(handles.resultEdit, 'String','Calculating...');
        redBin = tiffToBinary(red);
        greenBin = tiffToBinary(green);
        pairCorr = overlapCorr(redBin,greenBin);
        set(handles.resultEdit, 'String',pairCorr);
        
    case 'k'
        set(handles.resultEdit, 'String','Calculating...');
        redBin = tiffToBinary(red);
        greenBin = tiffToBinary(green);
        pairCorr = koverlapCorr(redBin,greenBin);
        set(handles.resultEdit, 'String',pairCorr);
    case 'm'
        set(handles.resultEdit, 'String','Calculating...');
        [pairCorrRed, pairCorrGreen] = mandersCorr(red,green);
        set(handles.resultEdit, 'String',pairCorr);
        
    case 'l'
        set(handles.resultEdit, 'String','Calculating...');
        pairCorr = liCorr(red,green);
        set(handles.resultEdit, 'String',pairCorr);
end


function imagePath1_Callback(hObject, eventdata, handles)
% hObject    handle to imagePath1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imagePath1 as text
%        str2double(get(hObject,'String')) returns contents of imagePath1 as a double


% --- Executes during object creation, after setting all properties.
function imagePath1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imagePath1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function imgPath2_Callback(hObject, eventdata, handles)
% hObject    handle to imgPath2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imgPath2 as text
%        str2double(get(hObject,'String')) returns contents of imgPath2 as a double


% --- Executes during object creation, after setting all properties.
function imgPath2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imgPath2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browseImg1.
function browseImg1_Callback(hObject, eventdata, handles)
% hObject    handle to browseImg1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[redFName, redFFolder] = uigetfile('G:\.tif', 'Select a red tiff file for correlation analysis');
redFPath = fullfile(redFFolder, redFName);
global red;
redRaw = importdata(redFPath);
red = reshape(redRaw,1,[]);

set(handles.imagePath1, 'String', redFPath);

% --- Executes on button press in browseImg2.
function browseImg2_Callback(hObject, eventdata, handles)
% hObject    handle to browseImg2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[greenFName, greenFFolder] = uigetfile('G:\.tif', 'Select a green tiff file for correlation analysis');
greenFPath = fullfile(greenFFolder, greenFName);
global green;
greenRaw = importdata(greenFPath);
green = reshape(greenRaw, 1, []);

set(handles.imgPath2, 'String', greenFPath);

% --- Executes on button press in pearsonCheck.
function pearsonCheck_Callback(hObject, eventdata, handles)
% hObject    handle to pearsonCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
x = 'p';
% Hint: get(hObject,'Value') returns toggle state of pearsonCheck


% --- Executes on button press in overlayCheck.
function overlayCheck_Callback(hObject, eventdata, handles)
% hObject    handle to overlayCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
x = 'o';
% Hint: get(hObject,'Value') returns toggle state of overlayCheck


% --- Executes on button press in kOverlapCheck.
function kOverlapCheck_Callback(hObject, eventdata, handles)
% hObject    handle to kOverlapCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
x = 'k';
% Hint: get(hObject,'Value') returns toggle state of kOverlapCheck


% --- Executes on button press in lisCheck.
function lisCheck_Callback(hObject, eventdata, handles)
% hObject    handle to lisCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
x = 'l';
% Hint: get(hObject,'Value') returns toggle state of lisCheck


% --- Executes on button press in mandersCheck.
function mandersCheck_Callback(hObject, eventdata, handles)
% hObject    handle to mandersCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
x = 'm';
% Hint: get(hObject,'Value') returns toggle state of mandersCheck



function resultEdit_Callback(hObject, eventdata, handles)
% hObject    handle to resultEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of resultEdit as text
%        str2double(get(hObject,'String')) returns contents of resultEdit as a double


% --- Executes during object creation, after setting all properties.
function resultEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resultEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
