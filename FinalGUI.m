function varargout = FinalGUI(varargin)
% FINALGUI MATLAB code for FinalGUI.fig
%      FINALGUI, by itself, creates a new FINALGUI or raises the existing
%      singleton*.
%
%      H = FINALGUI returns the handle to a new FINALGUI or the handle to
%      the existing singleton*.
%
%      FINALGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINALGUI.M with the given input arguments.
%
%      FINALGUI('Property','Value',...) creates a new FINALGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FinalGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FinalGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FinalGUI

% Last Modified by GUIDE v2.5 02-Dec-2014 19:40:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FinalGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FinalGUI_OutputFcn, ...
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


% --- Executes just before FinalGUI is made visible.
function FinalGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FinalGUI (see VARARGIN)

% Choose default command line output for FinalGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FinalGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FinalGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)

global I
[filename, pathname, filterindex]=uigetfile('*.jpg','JPEG File (*.jpg)');
var=strcat(pathname,filename);
I=imread(var);
imshow (I);

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
global I
global J
J = imnoise(I, 'salt & pepper', 0.05);
imshow (J);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
global I
global J
J = imnoise(I, 'Gaussian',0, 0.05);
imshow (J);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
global I
global J
J = imnoise(I, 'Speckle', 0.06);
imshow (J);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global J
[a,b,c] = size(J); % Convert pic into array

FilterPicture = zeros(a,b,c); % take empty size of array

Filter = [1 2 1 ; 2 4 2 ; 1 2 1];

for D = 1:c
  for i = 2:a-1 % image loops
    for j = 2:b-1
        temp = 0;
        FilterRows = 1;
        FilterColumn = 1;
        for k = (i - 1):i+1 % filter loops
            for l = (j-1):j+1
               
                %convolution
         
                pixel = double(J(k,l,D));
                temp = temp +  (pixel * Filter( FilterRows, FilterColumn));
                 FilterColumn =  FilterColumn +1;
            end
             FilterRows =  FilterRows + 1;
           FilterColumn = 1;
        end
        FilterPicture (i-1,j-1,D) = temp/16;
    end
  end
end         
axes(handles.axes1);imshow(uint8(FilterPicture));



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
global J
[a,b,c] = size(J);
FilterPicture = zeros(a,b,c);
Filter= fspecial('gaussian',[5,5]);
for D = 1:c
  for i = 3:a-1
    for j = 3:b-1
        temp = 0;
     FilterRows = 1;
        FilterColumn = 1;
        for k = (i - 2):i+1
            for l = (j-2):j+1
                pixel = double(J(k,l,D));
                temp = temp +  (pixel * Filter(FilterRows , FilterColumn));
                FilterColumn =  FilterColumn +1;
            end
         FilterRows  = FilterRows  + 1;
         FilterColumn = 1;
        end
       FilterPicture(i-1,j-1,D) = temp;
    end
  end
end   
axes(handles.axes1);imshow(uint8(FilterPicture));


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
global J
[a,b,c] = size(J);
FilterPicture= zeros(a,b,c);
Filter = [1 1 1 ; 1 1 1 ; 1 1 1];

for D = 1:c
  for i = 2:a-1
    for j = 2:b-1
        temp = 0;
   FilterRows = 1;
        FilterColumn = 1;
        linear_index = 1; 
        for k = (i - 1):i+1
            for l = (j-1):j+1
                %convolution
                pixel = double(J(k,l,D));
                %save values in linear array temp
                temp(linear_index) = pixel *Filter (FilterRows , FilterColumn);
                FilterColumn =  FilterColumn +1;
                linear_index = linear_index +1;
            end
            FilterRows  = FilterRows  + 1;
            FilterColumn= 1;
        end
        [array_Row,array_columns] = size(temp);
        %  Selection sort 
        for r = 1:array_columns-1
            max_value_index = r;
            for t = r+1:array_columns
                if(temp(max_value_index)< temp(t))
                    max_value_index = t;
                end
            end

            if(max_value_index ~= r)
                temp(r) = temp(r) + temp(max_value_index);
                temp(max_value_index) = temp(r) - temp(max_value_index);
                temp(r) = temp(r) - temp(max_value_index);
            end
        end
        medianVariable = (1 + array_columns)/2;
      FilterPicture(i-1,j-1,D) = temp(  medianVariable );
    end
  end
end 
axes(handles.axes1);imshow(uint8(FilterPicture));

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
global I
global J
J = imnoise(I, 'poisson');
imshow (J);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
global J
%image=s;
% Saving the rotated image
[filename,pathname] = uiputfile( ...
       {'*.jpg', 'JPEG Image File'; ...
        '*.*',   'All Files (*.*)'}, ...
        'Save current image as');
    
var=strcat(pathname,filename,'.jpg');
imwrite(uint8(J),var);

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)

axes(handles.axes1);cla reset;

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
