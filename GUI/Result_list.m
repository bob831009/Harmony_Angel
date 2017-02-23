function varargout = Result_list(varargin)
% RESULT_LIST MATLAB code for Result_list.fig
%      RESULT_LIST, by itself, creates a new RESULT_LIST or raises the existing
%      singleton*.
%
%      H = RESULT_LIST returns the handle to a new RESULT_LIST or the handle to
%      the existing singleton*.
%
%      RESULT_LIST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULT_LIST.M with the given input arguments.
%
%      RESULT_LIST('Property','Value',...) creates a new RESULT_LIST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Result_list_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Result_list_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Result_list

% Last Modified by GUIDE v2.5 18-Jun-2016 18:39:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Result_list_OpeningFcn, ...
                   'gui_OutputFcn',  @Result_list_OutputFcn, ...
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


% --- Executes just before Result_list is made visible.
function Result_list_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Result_list (see VARARGIN)

% Choose default command line output for Result_list
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Result_list wait for user response (see UIRESUME)
% uiwait(handles.figure1);
B = imread('Image_Base/1.jpg');
axes(handles.BackGround_fig);
image(B);
set(handles.BackGround_fig,'Visible','off');
handles

% --- Outputs from this function are returned to the command line.
function varargout = Result_list_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Higher5_Note.
function Higher5_Note_Callback(hObject, eventdata, handles)
% hObject    handle to Higher5_Note (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Result_Specfic([5]);
close Result_list;


% --- Executes on button press in Higher_3and5_Note.
function Higher_3and5_Note_Callback(hObject, eventdata, handles)
% hObject    handle to Higher_3and5_Note (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Result_Specfic([3, 5]);
close Result_list;


% --- Executes on button press in Lower_3_Note.
function Lower_3_Note_Callback(hObject, eventdata, handles)
% hObject    handle to Lower_3_Note (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Result_Specfic([-3]);
close Result_list;

% --- Executes on button press in Higher_5_Lower_3_Note.
function Higher_5_Lower_3_Note_Callback(hObject, eventdata, handles)
% hObject    handle to Higher_5_Lower_3_Note (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Result_Specfic([5, -3]);
close Result_list;

% --- Executes on button press in Higher5_Note_listen.
function Higher5_Note_listen_Callback(hObject, eventdata, handles)
% hObject    handle to Higher5_Note_listen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OrgObj = myAudioRead('MyRecord.wav');
ChangeObj = myAudioRead('./Harmony/Change5Note.wav');
sound(0.75*OrgObj.signal+0.25*ChangeObj.signal);


% --- Executes on button press in Higher_3and5_Note_listen.
function Higher_3and5_Note_listen_Callback(hObject, eventdata, handles)
% hObject    handle to Higher_3and5_Note_listen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OrgObj = myAudioRead('MyRecord.wav');
ChangeObj1 = myAudioRead('./Harmony/Change3Note.wav');
ChangeObj2 = myAudioRead('./Harmony/Change5Note.wav');
sound(0.5*OrgObj.signal+0.25*ChangeObj1.signal+0.25*ChangeObj2.signal);



% --- Executes on button press in Lower_3_Note_listen.
function Lower_3_Note_listen_Callback(hObject, eventdata, handles)
% hObject    handle to Lower_3_Note_listen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OrgObj = myAudioRead('MyRecord.wav');
ChangeObj = myAudioRead('./Harmony/Change-3Note.wav');
sound(0.75*OrgObj.signal+0.25*ChangeObj.signal);


% --- Executes on button press in Higher_5_Lower_3_Note_listen.
function Higher_5_Lower_3_Note_listen_Callback(hObject, eventdata, handles)
% hObject    handle to Higher_5_Lower_3_Note_listen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OrgObj = myAudioRead('MyRecord.wav');
ChangeObj1 = myAudioRead('./Harmony/Change5Note.wav');
ChangeObj2 = myAudioRead('./Harmony/Change-3Note.wav');
sound(0.5*OrgObj.signal+0.25*ChangeObj1.signal+0.25*ChangeObj2.signal);
