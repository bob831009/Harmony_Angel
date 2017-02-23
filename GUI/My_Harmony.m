function varargout = My_Harmony(varargin)
% MY_HARMONY MATLAB code for My_Harmony.fig
%      MY_HARMONY, by itself, creates a new MY_HARMONY or raises the existing
%      singleton*.
%
%      H = MY_HARMONY returns the handle to a new MY_HARMONY or the handle to
%      the existing singleton*.
%
%      MY_HARMONY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MY_HARMONY.M with the given input arguments.
%
%      MY_HARMONY('Property','Value',...) creates a new MY_HARMONY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before My_Harmony_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to My_Harmony_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help My_Harmony

% Last Modified by GUIDE v2.5 14-Jun-2016 11:03:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @My_Harmony_OpeningFcn, ...
                   'gui_OutputFcn',  @My_Harmony_OutputFcn, ...
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


% --- Executes just before My_Harmony is made visible.
function My_Harmony_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to My_Harmony (see VARARGIN)

% Choose default command line output for My_Harmony
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% BackGround Image Part

% UIWAIT makes My_Harmony wait for user response (see UIRESUME)
% uiwait(handles.figure1);
B = imread('Image_Base/1.jpg');
axes(handles.BackGround_fig);
image(B);
set(handles.BackGround_fig,'Visible','off');
handles


% --- Outputs from this function are returned to the command line.
function varargout = My_Harmony_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in RecordBotton.
function RecordBotton_Callback(hObject, eventdata, handles)
% hObject    handle to RecordBotton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Record_State, 'String', 'Recording, Please Wait!');
recObj = audiorecorder;
disp('Start speaking.')
recordblocking(recObj, 15);
disp('End of Recording.');
y = getaudiodata(recObj);
y = y*5;
audiowrite('MyRecord.wav', y, recObj.SampleRate);
set(handles.Record_State, 'String', 'Record Finish! Continue!');


% --- Executes on button press in ListenBotton.
function ListenBotton_Callback(hObject, eventdata, handles)
% hObject    handle to ListenBotton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[y, fs] = audioread('MyRecord.wav');
sound(y);


% --- Executes on button press in DeleteBotton.
function DeleteBotton_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteBotton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete('MyRecord.wav');


% --- Executes on button press in ContinueBotton.
function ContinueBotton_Callback(hObject, eventdata, handles)
% hObject    handle to ContinueBotton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wObj = myAudioRead('MyRecord.wav');
opt = pitchShift('defaultOpt');
addpath('../../toolbox/sap/');
ptOpt=ptOptSet(wObj.fs, wObj.nbits);
[wObj.frame_pitch] = pitchTrack('MyRecord.wav', ptOpt);

folderName = 'Harmony';
if( ~isequal(exist(folderName, 'dir'),7) )
    mkdir(folderName);
end

Change_Set = [4, 7, -5, -8];
Change_Note = [3, 5, -3, -5];
for i = 1:length(Change_Set)
    change_semi = Change_Set(i);
    change_note = Change_Note(i);
    opt.pitchShiftAmount= change_semi;
    wObj2= pitchShift(wObj, opt);
    if(length(wObj2.signal) > length(wObj.signal))
        wObj2.signal(length(wObj.signal)+1:length(wObj2.signal))=[];
    end
    output_path = strcat(folderName, '/Change', num2str(change_note), 'Note.wav');
    audiowrite(output_path, wObj2.signal, wObj2.fs);
end

Result_list;
close My_Harmony;
