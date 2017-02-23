function varargout = Result_Specfic(varargin)
% RESULT_SPECFIC MATLAB code for Result_Specfic.fig
%      RESULT_SPECFIC, by itself, creates a new RESULT_SPECFIC or raises the existing
%      singleton*.
%
%      H = RESULT_SPECFIC returns the handle to a new RESULT_SPECFIC or the handle to
%      the existing singleton*.
%
%      RESULT_SPECFIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULT_SPECFIC.M with the given input arguments.
%
%      RESULT_SPECFIC('Property','Value',...) creates a new RESULT_SPECFIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Result_Specfic_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Result_Specfic_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Result_Specfic

% Last Modified by GUIDE v2.5 14-Jun-2016 13:14:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Result_Specfic_OpeningFcn, ...
                   'gui_OutputFcn',  @Result_Specfic_OutputFcn, ...
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


% --- Executes just before Result_Specfic is made visible.
function Result_Specfic_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Result_Specfic (see VARARGIN)

% Choose default command line output for Result_Specfic
B = imread('Image_Base/1.jpg');
image(B,'Parent',handles.BackGround_fig)
set(handles.BackGround_fig,'Visible','off');

% need to import Roger Jang`s sap toolbox
tool_box_path = '../../toolbox/sap/';

handles.output = hObject;
handles.type = varargin{1};
addpath(tool_box_path);
au=myAudioRead('MyRecord.wav');
ptOpt=ptOptSet(au.fs, au.nbits);
[org_pitch] = pitchTrack('MyRecord.wav', ptOpt);
org_pitch = org_pitch(find(org_pitch ~= 0));
org_time=(1:length(org_pitch))/au.fs;
plot(handles.org_fig, org_time, org_pitch);

hold on;
plot(handles.mix_fig, org_time, org_pitch);
for i=1:length(handles.type)
    change_type = handles.type(i);
    change_file_path = strcat('./Harmony/Change', num2str(change_type), 'Note.wav');
    au=myAudioRead(change_file_path);
    ptOpt=ptOptSet(au.fs, au.nbits);
    [change_pitch] = pitchTrack(change_file_path, ptOpt);
    change_pitch = change_pitch(find(change_pitch ~= 0));
    change_time=(1:length(change_pitch))/au.fs;
    plot(handles.mix_fig, change_time, change_pitch);
end
hold off;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Result_Specfic wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Result_Specfic_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Listen_original.
function Listen_original_Callback(hObject, eventdata, handles)
% hObject    handle to Listen_original (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
orgObj = myAudioRead('MyRecord.wav');
sound(orgObj.signal);

% --- Executes on button press in Listen_Harmony.
function Listen_Harmony_Callback(hObject, eventdata, handles)
% hObject    handle to Listen_Harmony (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=1:length(handles.type)
    change_type = handles.type(i);
    change_file_path = strcat('./Harmony/Change', num2str(change_type), 'Note.wav');
    ChangeObj = myAudioRead(change_file_path);
    sound(ChangeObj.signal);
    pause(floor(length(ChangeObj.signal)/ChangeObj.fs)+1);
end;

% --- Executes on button press in Listen_Both.
function Listen_Both_Callback(hObject, eventdata, handles)
% hObject    handle to Listen_Both (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
orgObj = myAudioRead('MyRecord.wav');
if(length(handles.type) == 1)
    change_file_path = strcat('./Harmony/Change', num2str(handles.type), 'Note.wav');
    ChangeObj = myAudioRead(change_file_path);
    sound(0.5*ChangeObj.signal + 0.5*orgObj.signal);
elseif(length(handles.type) == 2)
    change_file_path1 = strcat('./Harmony/Change', num2str(handles.type(1)), 'Note.wav');
    change_file_path2 = strcat('./Harmony/Change', num2str(handles.type(2)), 'Note.wav');
    ChangeObj1 = myAudioRead(change_file_path1);
    ChangeObj2 = myAudioRead(change_file_path2);
    sound(0.5*orgObj.signal + 0.25*ChangeObj1.signal+0.25*ChangeObj2.signal);
end


% --- Executes on button press in Back_Botton.
function Back_Botton_Callback(hObject, eventdata, handles)
% hObject    handle to Back_Botton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Result_list;
close Result_Specfic;
