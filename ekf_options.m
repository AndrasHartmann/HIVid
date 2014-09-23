function varargout = ekf_options(varargin)
% EKF_OPTIONS M-file for ekf_options.fig
%      EKF_OPTIONS, by itself, creates a new EKF_OPTIONS or raises the existing
%      singleton*.
%
%      H = EKF_OPTIONS returns the handle to a new EKF_OPTIONS or the handle to
%      the existing singleton*.
%
%      EKF_OPTIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EKF_OPTIONS.M with the given input arguments.
%
%      EKF_OPTIONS('Property','Value',...) creates a new EKF_OPTIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ekf_options_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ekf_options_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ekf_options

% Last Modified by GUIDE v2.5 08-Jan-2012 20:37:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ekf_options_OpeningFcn, ...
    'gui_OutputFcn',  @ekf_options_OutputFcn, ...
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


% --- Executes just before ekf_options is made visible.
function ekf_options_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ekf_options (see VARARGIN)

% Choose default command line output for ekf_options
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ekf_options wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ekf_options_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function edit_sigma1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sigma1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sigma1 as text
%        str2double(get(hObject,'String')) returns contents of edit_sigma1 as a double

sigma1 = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(sigma1))
    set(hObject,'String','sigma1')
end


% --- Executes during object creation, after setting all properties.
function edit_sigma1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sigma1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

if (isappdata(0,'Q'))
    Q = getappdata(0,'Q');
    set(hObject, 'String', num2str(sqrt(Q(1))));
end


function edit_sigma2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sigma2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sigma2 as text
%        str2double(get(hObject,'String')) returns contents of edit_sigma2 as a double

sigma2 = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input2_editText to zero
if (isempty(sigma2))
    set(hObject,'String','sigma2')
end

% --- Executes during object creation, after setting all properties.
function edit_sigma2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sigma2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

if (isappdata(0,'Q'))
    Q = getappdata(0,'Q');
    set(hObject, 'String', num2str(sqrt(Q(4))));
end

% --- Executes on button press in identify.
function identify_Callback(hObject, eventdata, handles)
% hObject    handle to identify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


params = getappdata(0,'params');
X0 = getappdata(0,'X0');
data = load(getappdata(0,'datafilename'));
if isstruct(data)
    fnames = fieldnames(data);
    data = data.(fnames{1});
end

ts = data (:,1)';
y = data (:,2:3)';
y(y==5.01187234e+001) = -1;

Q = diag([ str2double(get(handles.edit_sigma1,'String')), str2double(get(handles.edit_sigma2,'String'))]).^2;
if(hasInfNaN(Q))
    msgbox('Please load or fill all the covariances before identification', 'Error', 'error');
    return;
end
setappdata(0,'Q',Q);

R = diag([0 0 0 0]);

estimates = ekfid(X0, params(:), Q, R, y, ts)
delete(hObject);
close(ekf_options);
