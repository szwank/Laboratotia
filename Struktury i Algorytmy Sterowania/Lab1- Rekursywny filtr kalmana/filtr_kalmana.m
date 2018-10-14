function msfuntmpl_basic(block)
%MSFUNTMPL_BASIC A Template for a Level-2 MATLAB S-Function
%   The MATLAB S-function is written as a MATLAB function with the
%   same name as the S-function. Replace 'msfuntmpl_basic' with the 
%   name of your S-function.
%
%   It should be noted that the MATLAB S-function is very similar
%   to Level-2 C-Mex S-functions. You should be able to get more
%   information for each of the block methods by referring to the
%   documentation for C-Mex S-functions.
%
%   Copyright 2003-2010 The MathWorks, Inc.

%%
%% The setup method is used to set up the basic attributes of the
%% S-function such as ports, parameters, etc. Do not add any other
%% calls to the main body of the function.
%%
setup(block);

%endfunction

%% Function: setup ===================================================
%% Abstract:
%%   Set up the basic characteristics of the S-function block such as:
%%   - Input ports
%%   - Output ports
%%   - Dialog parameters
%%   - Options
%%
%%   Required         : Yes
%%   C-Mex counterpart: mdlInitializeSizes
%%
function setup(block)

% Register number of ports
block.NumInputPorts  = 2;
block.NumOutputPorts = 1;

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic; % mozliwoœc przekazywania informacij miêdzy symulinkiem a blokiem(Wejœciem)
block.SetPreCompOutPortInfoToDynamic;

% Override input port properties
block.InputPort(1).Dimensions        = 2;   % U
block.InputPort(1).DatatypeID  = 0;  % double
block.InputPort(1).Complexity  = 'Real';
block.InputPort(1).DirectFeedthrough = true;

block.InputPort(2).Dimensions        = 2;       % y(pomiary)
block.InputPort(2).DatatypeID  = 0;  % double
block.InputPort(2).Complexity  = 'Real';
block.InputPort(2).DirectFeedthrough = true;

% Override output port properties
block.OutputPort(1).Dimensions       = 4;       % xHat
block.OutputPort(1).DatatypeID  = 0; % double
block.OutputPort(1).Complexity  = 'Real';

% Register parameters
block.NumDialogPrms     = 1;                    % x0(4,1)

% Register sample times
%  [0 offset]            : Continuous sample time
%  [positive_num offset] : Discrete sample time
%
%  [-1, 0]               : Inherited sample time
%  [-2, 0]               : Variable sample time
block.SampleTimes = [0.0001 0];

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'CustomSimState',  < Has GetSimState and SetSimState methods
%    'DisallowSimState' < Error out when saving or restoring the model sim state
block.SimStateCompliance = 'DefaultSimState';

%% -----------------------------------------------------------------
%% The MATLAB S-function uses an internal registry for all
%% block methods. You should register all relevant methods
%% (optional and required) as illustrated below. You may choose
%% any suitable name for the methods and implement these methods
%% as local functions within the same file. See comments
%% provided for each function for more information.
%% -----------------------------------------------------------------

block.RegBlockMethod('PostPropagationSetup',    @DoPostPropSetup);
%block.RegBlockMethod('InitializeConditions', @InitializeConditions);
block.RegBlockMethod('Start', @Start);
block.RegBlockMethod('Outputs', @Outputs);     % Required
block.RegBlockMethod('Update', @Update);
%block.RegBlockMethod('Derivatives', @Derivatives);
block.RegBlockMethod('Terminate', @Terminate); % Required

%end setup

%%
%% PostPropagationSetup:
%%   Functionality    : Setup work areas and state variables. Can
%%                      also register run-time methods here
%%   Required         : No
%%   C-Mex counterpart: mdlSetWorkWidths
%%
function DoPostPropSetup(block)
block.NumDworks = 5;
  
  block.Dwork(1).Name            = 'xHat';
  block.Dwork(1).Dimensions      = 4;
  block.Dwork(1).DatatypeID      = 0;      % double
  block.Dwork(1).Complexity      = 'Real'; % real
  block.Dwork(1).UsedAsDiscState = true;
  
  block.Dwork(2).Name            = 'P1';
  block.Dwork(2).Dimensions      = 4;
  block.Dwork(2).DatatypeID      = 0;      % double
  block.Dwork(2).Complexity      = 'Real'; % real
  block.Dwork(2).UsedAsDiscState = true;
  
  block.Dwork(3).Name            = 'P2';
  block.Dwork(3).Dimensions      = 4;
  block.Dwork(3).DatatypeID      = 0;      % double
  block.Dwork(3).Complexity      = 'Real'; % real
  block.Dwork(3).UsedAsDiscState = true;
  
  block.Dwork(4).Name            = 'P3';
  block.Dwork(4).Dimensions      = 4;
  block.Dwork(4).DatatypeID      = 0;      % double
  block.Dwork(4).Complexity      = 'Real'; % real
  block.Dwork(4).UsedAsDiscState = true;
  
  block.Dwork(5).Name            = 'P4';
  block.Dwork(5).Dimensions      = 4;
  block.Dwork(5).DatatypeID      = 0;      % double
  block.Dwork(5).Complexity      = 'Real'; % real
  block.Dwork(5).UsedAsDiscState = true;
  

%%
%% InitializeConditions:
%%   Functionality    : Called at the start of simulation and if it is 
%%                      present in an enabled subsystem configured to reset 
%%                      states, it will be called when the enabled subsystem
%%                      restarts execution to reset the states.
%%   Required         : No
%%   C-MEX counterpart: mdlInitializeConditions
%%
%function InitializeConditions(block)

%end InitializeConditions


%%
%% Start:
%%   Functionality    : Called once at start of model execution. If you
%%                      have states that should be initialized once, this 
%%                      is the place to do it.
%%   Required         : No
%%   C-MEX counterpart: mdlStart
%%
function Start(block)


                   
                   
                   
                  
P0 = block.DialogPrm(1).Data * block.DialogPrm(1).Data';   % P0
block.Dwork(2).Data = P0(1,:);
block.Dwork(3).Data = P0(2,:);
block.Dwork(4).Data = P0(3,:);
block.Dwork(5).Data = P0(4,:);


block.Dwork(1).Data = block.DialogPrm(1).Data;      % nadpisanie w pierwszej iteracij xHat = x0


% Wyznaczenie P0

%end Start

%%
%% Outputs:
%%   Functionality    : Called to generate block outputs in
%%                      simulation step
%%   Required         : Yes
%%   C-MEX counterpart: mdlOutputs
%%
function Outputs(block)
Ad = [1 0 0.0001 0;              % inicjalizacja Ad
      0 1 0 0.0001;
      0 0 1 0;
      0 0 0 1];
                   
Bd = [0 0;                % inicjalizacja Bd
      0 0;
      0.0001 0;
      0 0.0001];
                   
Cd = [1 0 0 0;                 % inicjalizacja Cd
      0 1 0 0];

Z = [10 0;                 % inicjalizacja Z
     0 10];
                   
V = [10 0;                     % inicjalizacja V
     0 10];                   
                   
G = [0 0;                % inicjalizacja G
      0 0;
      0.001 0;
      0 0.001]; 
 
xHat = block.Dwork(1).Data;    % podstawienie za xHat

P = [block.Dwork(2).Data';      % z³o¿enie macierzy P
     block.Dwork(3).Data';
     block.Dwork(4).Data';
     block.Dwork(5).Data'];

% xHat_kk1:
xHat_kk1 = Ad * xHat + Bd * block.InputPort(1).Data; %(Ad * x + Bd * u)

% P_kk1:
P_kk1 = Ad * P * Ad' + G * Z * G';   %(P_kk1 = Ad * P * Ad' + G * Z * G')

K = P_kk1 * Cd' * inv(Cd * P_kk1 * Cd' + V);    % (P_kk1 * Cd' * inv(Cd * P_kk1 * Cd' + V))

% P:
P = (eye(4) - K * Cd) * P_kk1 *(eye(4) - K * Cd)' + ...
                      K * V * K'; % (eye(4) - K * Cd) * P_kk1 * (eye(4) - K * Cd)' + K * V * K'
                  
block.Dwork(2).Data = P(1,:);       % aktualizacja P
block.Dwork(3).Data = P(2,:);
block.Dwork(4).Data = P(3,:);
block.Dwork(5).Data = P(4,:);
                  
% xHat:                  
block.OutputPort(1).Data = xHat_kk1 + K * (block.InputPort(2).Data - ...
                           Cd * xHat_kk1); % xHat_kk1 + K * [y - Cd * xHat_kk1]
%end Outputs

%%
%% Update:
%%   Functionality    : Called to update discrete states
%%                      during simulation step
%%   Required         : No
%%   C-MEX counterpart: mdlUpdate
%%
function Update(block)

block.Dwork(1).Data = block.OutputPort(1).Data; %zaktualizowanie xHat

%end Update

%%
%% Derivatives:
%%   Functionality    : Called to update derivatives of
%%                      continuous states during simulation step
%%   Required         : No
%%   C-MEX counterpart: mdlDerivatives
%%
%function Derivatives(block)

%end Derivatives

%%
%% Terminate:
%%   Functionality    : Called at the end of simulation for cleanup
%%   Required         : Yes
%%   C-MEX counterpart: mdlTerminate
%%
function Terminate(block)

%end Terminate

