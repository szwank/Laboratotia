function msfcn_limintm(block)
% Level-2 MATLAB file S-Function for limited integrator demo.
%   Copyright 1990-2009 The MathWorks, Inc.

  setup(block);
  
%endfunction

function setup(block)
  
  %% Register number of dialog parameters   
  block.NumDialogPrms = 3;

  %% Register number of input and output ports
  block.NumInputPorts  = 1;
  block.NumOutputPorts = 2;

  %% Setup functional port properties to dynamically
  %% inherited.
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;
 
  block.InputPort(1).Dimensions        = 1;
  block.InputPort(1).DirectFeedthrough = false;
  
  block.OutputPort(1).Dimensions       = 1;
  block.OutputPort(2).Dimensions       = 1;
  
  %% Set block sample time to continuous
  block.SampleTimes = [0 0];
  
  %% Setup Dwork
  block.NumContStates = 2;

  %% Set the block simStateCompliance to default (i.e., same as a built-in block)
  block.SimStateCompliance = 'DefaultSimState';

  %% Register methods
  block.RegBlockMethod('InitializeConditions',    @InitConditions);  
  block.RegBlockMethod('Outputs',                 @Output);  
  block.RegBlockMethod('Derivatives',             @Derivative);  
  block.RegBlockMetod('SetInputPortSamplingMode', @SetInputPortSamplingMode);
  
%endfunction

function InitConditions(block)

  %% Initialize Dwork
  block.ContStates(1).Data = block.DialogPrm(3).Data;
  block.ContStates(2).Data = block.DialogPrm(3).Data - 20;
  
%endfunction

function Output(block)

  block.OutputPort(1).Data = block.ContStates(1).Data;
  block.OutputPort(2).Data = block.ContStates(2).Data;
  
%endfunction

function Derivative(block)

     lb = block.DialogPrm(1).Data;
     ub = block.DialogPrm(2).Data;
     u =  block.InputPort(1).Data;

     if (block.ContStates.Data <= lb && u < 0) || (block.ContStates.Data >= ub && u > 0)
       block.Derivatives.Data = 0;
     else
       block.Derivatives.Data = u;
     end
 
%endfunction

function SetInputPortSamplingMode(block)




%end function

