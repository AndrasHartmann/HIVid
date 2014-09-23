function varargout = HIVId(varargin)
% HIVID M-file for HIVId.fig
%      HIVID, by itself, creates a new HIVID or raises the existing
%      singleton*.
%
%      H = HIVID returns the handle to a new HIVID or the handle to
%      the existing singleton*.
%
%      HIVID('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HIVID.M with the given input arguments.
%
%      HIVID('Property','Value',...) creates a new HIVID or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HIVId_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HIVId_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HIVId

% Last Modified by GUIDE v2.5 12-Jan-2012 16:34:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @HIVId_OpeningFcn, ...
    'gui_OutputFcn',  @HIVId_OutputFcn, ...
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

% --- Executes just before HIVId is made visible.
function HIVId_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HIVId (see VARARGIN)

% Choose default command line output for HIVId
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HIVId wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%Write some license info to output
licensestr =' HIVId  Copyright (C) 2012  Andras Hartmann, ahartmann@kdbio.inesc-id.pt\n This program comes with ABSOLUTELY NO WARRANTY;\n For details read license file attached to this program.\n This is free software, and you are welcome to redistribute it under certain conditions\n'; 

fprintf(licensestr);


% --- Outputs from this function are returned to the command line.
function varargout = HIVId_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function load_parameters_Callback(hObject, eventdata, handles)
% hObject    handle to load_parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.mat', 'Choose a file');
if isequal(filename,0)
    disp('User selected Cancel')
    return;
else
    disp(['User selected', fullfile(pathname, filename)])
end
params = load(fullfile(pathname, filename));
if isstruct(params)
    fnames = fieldnames(params);
    params = params.(fnames{1});
end

set(handles.edit_S,'String', num2str(params(1)));
set(handles.edit_d,'String', num2str(params(2)));
set(handles.edit_b,'String', num2str(params(3)));
set(handles.edit_b2,'String', num2str(params(3)));
set(handles.edit_miu,'String', num2str(params(4)));
set(handles.edit_k,'String', num2str(params(5)));
set(handles.edit_c,'String', num2str(params(6)));

% --------------------------------------------------------------------
function load_init_Callback(hObject, eventdata, handles)
% hObject    handle to load_init (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.mat', 'Choose a file');
if isequal(filename,0)
    disp('User selected Cancel')
    return;
else
    disp(['User selected', fullfile(pathname, filename)])
end
initvalues = load(fullfile(pathname, filename));
if isstruct(initvalues)
    fnames = fieldnames(initvalues);
    initvalues = initvalues.(fnames{1});
end
set(handles.edit_T0,'String', num2str(initvalues(1)));
set(handles.edit_Ti0,'String', num2str(initvalues(2)));
set(handles.edit_v0,'String', num2str(initvalues(3)));


% --------------------------------------------------------------------
function load_data_Callback(hObject, eventdata, handles)
% hObject    handle to load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile({'*.csv', '*.mat'}, 'Choose a file');
if isequal(filename,0)
    disp('User selected Cancel')
    return;
else
    disp(['User selected', fullfile(pathname, filename)])
end
%handles.datafilename = fullfile(pathname, filename);
% save the changes to the structure
%guidata(hObject,handles)
setappdata(0,'datafilename',fullfile(pathname, filename));


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2



function edit_S_Callback(hObject, eventdata, handles)
% hObject    handle to edit_S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_S as text
%        str2double(get(hObject,'String')) returns contents of edit_S as a double
S = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(S))
    set(hObject,'String','S');
end

% --- Executes during object creation, after setting all properties.
function edit_S_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_d_Callback(hObject, eventdata, handles)
% hObject    handle to edit_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_d as text
%        str2double(get(hObject,'String')) returns contents of edit_d as a double
d = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(d))
    set(hObject,'String','d')
end


% --- Executes during object creation, after setting all properties.
function edit_d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_b_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b as text
%        str2double(get(hObject,'String')) returns contents of edit_b as a double
b = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(b))
    set(hObject,'String','b');
end
set(handles.edit_b2,'String', get(hObject,'String'));
%guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function edit_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_miu_Callback(hObject, eventdata, handles)
% hObject    handle to edit_miu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_miu as text
%        str2double(get(hObject,'String')) returns contents of edit_miu as a double
miu = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(miu))
    set(hObject,'String','miu')
end


% --- Executes during object creation, after setting all properties.
function edit_miu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_miu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_b2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b2 as text
%        str2double(get(hObject,'String')) returns contents of edit_b2 as a double
b = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(b))
    set(hObject,'String','b')
end
set(handles.edit_b,'String', get(hObject,'String'))
%guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit_b2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_k_Callback(hObject, eventdata, handles)
% hObject    handle to edit_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_k as text
%        str2double(get(hObject,'String')) returns contents of edit_k as a double

miu = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(miu))
    set(hObject,'String','k')
end
set(handles.edit_miu,'String', get(hObject,'String'))


% --- Executes during object creation, after setting all properties.
function edit_k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c as text
%        str2double(get(hObject,'String')) returns contents of edit_c as a double
c = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(c))
    set(hObject,'String','c')
end


% --- Executes during object creation, after setting all properties.
function edit_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_T0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_T0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_T0 as text
%        str2double(get(hObject,'String')) returns contents of edit_T0 as a double

T0 = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(T0))
    set(hObject,'String','T0')
end


% --- Executes during object creation, after setting all properties.
function edit_T0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_T0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_Ti0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Ti0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Ti0 as text
%        str2double(get(hObject,'String')) returns contents of edit_Ti0 as a double
Ti0 = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(Ti0))
    set(hObject,'String','Ti0')
end


% --- Executes during object creation, after setting all properties.
function edit_Ti0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Ti0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_v0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_v0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_v0 as text
%        str2double(get(hObject,'String')) returns contents of edit_v0 as a double

v0 = str2num(get(hObject,'String'));

%checks to see if input is empty. if so, default input1_editText to zero
if (isempty(v0))
    set(hObject,'String','v0')
end

% --- Executes during object creation, after setting all properties.
function edit_v0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_v0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_sim.
function push_sim_Callback(hObject, eventdata, handles)
% hObject    handle to push_sim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function view_Callback(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function tools_Callback(hObject, eventdata, handles)
% hObject    handle to tools (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function data_init_Callback(hObject, eventdata, handles)
% hObject    handle to data_init (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (~isappdata(0,'datafilename'))
    msgbox('Please load a data file first', 'Error', 'error');
    return;
end

data = load(getappdata(0,'datafilename'));
if isstruct(data)
    fnames = fieldnames(data);
    data = data.(fnames{1});
end
initvalues = [data(1,2)*0.8 data(1,2)*0.2 data(1,3)];
set(handles.edit_T0,'String', num2str(initvalues(1)));
set(handles.edit_Ti0,'String', num2str(initvalues(2)));
set(handles.edit_v0,'String', num2str(initvalues(3)));


% --------------------------------------------------------------------
function plot_data_Callback(hObject, eventdata, handles)
% hObject    handle to plot_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (~isappdata(0,'datafilename'))
    msgbox('Please load a data file first', 'Error', 'error');
    return;
end

data = load(getappdata(0,'datafilename'));
if isstruct(data)
    fnames = fieldnames(data);
    data = data.(fnames{1});
end

ts = data (:,1)';
y = data (:,2:3)';
%y(y==5.01187234e+001) = -1;

%state estimates
figure(2);
close;
figure(2);
subplot(2,1,1)
semilogy(ts,y(2,:),'o')
ylabel('V');
xlabel('time (days)');
set(gca,'xgrid', 'on', 'ygrid', 'on');
set(gca,'xlim', [-10 ts(end)+10]);
set(gca,'ylim', [10 200000]);
set(gca,'ytick', [10 1000 100000]);
% title([titles{i} subtitles1{i}]);

subplot(2,1,2)
plot(ts,y(1,:),'o')
ylabel('T+T^*');
xlabel('time (days)');
set(gca,'xgrid', 'on', 'ygrid', 'on');
set(gca,'ylim', [200 1000]);
set(gca,'xlim', [-10 ts(end)+10]);
% title([titles{i} subtitles1{i}]);
% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function aboutme_Callback(hObject, eventdata, handles)
% hObject    handle to aboutme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpwin about;


% --------------------------------------------------------------------
function webpage_Callback(hObject, eventdata, handles)
% hObject    handle to webpage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web http://kdbio.inesc-id.pt/~hdbandi/software


% --------------------------------------------------------------------
function helpme_Callback(hObject, eventdata, handles)
% hObject    handle to helpme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpwin Contents;


% --------------------------------------------------------------------
function license_Callback(hObject, eventdata, handles)
% hObject    handle to license (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpwin _License_;


% --------------------------------------------------------------------
function simulate_Callback(hObject, eventdata, handles)
% hObject    handle to simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%addpath ../models

params = [ str2double(get(handles.edit_S,'String')) str2double(get(handles.edit_d,'String')) str2double(get(handles.edit_b,'String')) str2double(get(handles.edit_miu,'String')) str2double(get(handles.edit_k,'String')) str2double(get(handles.edit_c,'String'))];

if(hasInfNaN(params))
    msgbox('Please load or fill all the parameters before simulation', 'Error', 'error');
    return;
end

X0 = [ str2double(get(handles.edit_T0,'String')) str2double(get(handles.edit_Ti0,'String')) str2double(get(handles.edit_v0,'String'))];

if(hasInfNaN(X0))
    msgbox('Please load or fill all the initial values before simulation', 'Error', 'error');
    return;
end

[tsim, xsim] = ode15s(@modelall, linspace(0,200), X0, [], params);
ysim = [xsim(:,1)+xsim(:,2) xsim(:,3)];

%state estimates
figure(3);
close;
figure(3);
subplot(2,1,1)
semilogy(tsim,ysim(:,2))
ylabel('V');
xlabel('time (days)');
set(gca,'xgrid', 'on', 'ygrid', 'on');
set(gca,'xlim', [-10 tsim(end)+10]);
set(gca,'ylim', [10 200000]);
set(gca,'ytick', [10 1000 100000]);
% title([titles{i} subtitles1{i}]);

subplot(2,1,2)
plot(tsim,ysim(:,1))
ylabel('T+T^*');
xlabel('time (days)');
set(gca,'xgrid', 'on', 'ygrid', 'on');
plot(tsim,ysim(:,1))
set(gca,'xgrid', 'on', 'ygrid', 'on');
set(gca,'ylim', [200 1000]);
set(gca,'xlim', [-10 tsim(end)+10]);

% --------------------------------------------------------------------
function identify_Callback(hObject, eventdata, handles)
% hObject    handle to identify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ekf_Callback(hObject, eventdata, handles)
% hObject    handle to ekf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%reading values

if (~isappdata(0,'datafilename'))
    msgbox('Please load a data file before identification', 'Error', 'error');
    return;
end

params = [ str2double(get(handles.edit_S,'String')) str2double(get(handles.edit_d,'String')) str2double(get(handles.edit_b,'String')) str2double(get(handles.edit_miu,'String')) str2double(get(handles.edit_k,'String')) str2double(get(handles.edit_c,'String'))];

if(hasInfNaN(params))
    msgbox('Please load or fill all the parameters before identification', 'Error', 'error');
    return;
end

X0 = [ str2double(get(handles.edit_T0,'String')) str2double(get(handles.edit_Ti0,'String')) str2double(get(handles.edit_v0,'String'))];

if(hasInfNaN(X0))
    msgbox('Please load or fill all the initial values before identification', 'Error', 'error');
    return;
end

[tsim, xsim] = ode15s(@modelall, linspace(0, 200), X0, [], params);

setappdata(0,'params',params);
setappdata(0,'X0',X0);
ekf_options;

% --------------------------------------------------------------------
function pf_Callback(hObject, eventdata, handles)
% hObject    handle to pf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (~isappdata(0,'datafilename'))
    msgbox('Please load a data file before identification', 'Error', 'error');
    return;
end

%reading values
params = [ str2double(get(handles.edit_S,'String')) str2double(get(handles.edit_d,'String')) str2double(get(handles.edit_b,'String')) str2double(get(handles.edit_miu,'String')) str2double(get(handles.edit_k,'String')) str2double(get(handles.edit_c,'String'))];

if(hasInfNaN(params))
    msgbox('Please load or fill all the parameters before identification', 'Error', 'error');
    return;
end

X0 = [ str2double(get(handles.edit_T0,'String')) str2double(get(handles.edit_Ti0,'String')) str2double(get(handles.edit_v0,'String'))];

if(hasInfNaN(X0))
    msgbox('Please load or fill all the initial values before identification', 'Error', 'error');
    return;
end

setappdata(0,'params',params);
setappdata(0,'X0',X0);
pf_options;

% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Remove all the application data
app=getappdata(0); %get all the appdata of 0
appdatas = fieldnames(app);
for i = 1:length(appdatas)
    rmappdata(0,char(appdatas(i)));
end
%deleting sub-guis
delete(get(0,'Children'));
%and hObject
delete(hObject);


% --------------------------------------------------------------------
function smooth_Callback(hObject, eventdata, handles)
% hObject    handle to smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (~isappdata(0,'datafilename'))
    msgbox('Please load a data file first', 'Error', 'error');
    return;
end

data = load(getappdata(0,'datafilename'));
if isstruct(data)
    fnames = fieldnames(data);
    data = data.(fnames{1});
end

% addpath ../general;

v = (preprocess(data(:,[1,3])));
t = (preprocess(data(:,[1,2])));

%different regularizers to the 4 ts
%reg = [0.3; 0.2; 0.3; 0.2];
%reg = [0.2; 0.2]
figure(4)
close
figure(4)

vhat = smoothts(v);
that = smoothts(t);

ts = data (:,1)';
y = data (:,2:3)';
y(y==5.01187234e+001) = -1;

%state estimates
figure(4);
close;
figure(4);

subplot(2,1,1)
semilogy(ts,y(2,:),'o')
hold on
semilogy(v(:,1),vhat)
ylabel('V');
xlabel('time (days)');
set(gca,'xgrid', 'on', 'ygrid', 'on');
set(gca,'xlim', [-10 ts(end)+10]);
set(gca,'ylim', [10 200000]);
set(gca,'ytick', [10 1000 100000]);
% title([titles{i} subtitles1{i}]);

subplot(2,1,2)
plot(ts,y(1,:),'o')
hold on
plot(t(:,1),that)
ylabel('T+T^*');
xlabel('time (days)');
set(gca,'xgrid', 'on', 'ygrid', 'on');
set(gca,'ylim', [200 1000]);
set(gca,'xlim', [-10 ts(end)+10]);

Q =[ std((log(t(:,2))-log(that))) 0; 0 std((log(v(:,2))-log(vhat)))];
setappdata(0,'Q',Q);


% --------------------------------------------------------------------
function steady_state_Callback(hObject, eventdata, handles)
% hObject    handle to steady_state (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

params = [ str2double(get(handles.edit_S,'String')) str2double(get(handles.edit_d,'String')) str2double(get(handles.edit_b,'String')) str2double(get(handles.edit_miu,'String')) str2double(get(handles.edit_k,'String')) str2double(get(handles.edit_c,'String'))];

if(hasInfNaN(params))
    msgbox('Please load or fill all the parameters first', 'Error', 'error');
    return;
end

s=params(1);
d=params(2);
b=params(3);
miu=params(4);
k=params(5);
c=params(6);

V0 = k*s/(miu*c)-d/b;
T0 = miu*c/(b*k);
Ti0 = c/k*V0;

set(handles.edit_T0,'String', num2str(T0));
set(handles.edit_Ti0,'String', num2str(Ti0));
set(handles.edit_v0,'String', num2str(V0));


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
addpath utils;
