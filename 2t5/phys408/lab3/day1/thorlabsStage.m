%% An example script for communicating with a Thorlabs translation stage
%
% REF: thorlabsStage_ProgrammingManual.pdf

clear all; close all;

%% Initialize the controller and the translation stage

% Motor serial number (specific to each station)
motorSN=83810095;

% Start system
myController=actxcontrol('MG17SYSTEM.MG17SystemCtrl.1', [0 0 100 100]);
myController.StartCtrl;

% Start motor
myStage=actxcontrol('MGMOTOR.MGMotorCtrl.1',[0,0,300,300]);
myStage.HWSerialNum = motorSN; 
myStage.StartCtrl;

% Hide the control panel out of the way
%set(gcf,'Visible','off');

motor_id = 0;
pause(2.0);

%% Get current position and current speed setting

% Position in [mm]
currentPosition=myStage.GetPosition_Position(motor_id);

% Speed in [mm/s]
[status, min_v, accel, currentSpeed] = myStage.GetVelParams(motor_id, 0,0,0);

%% Move with a new speed to a new position

newSpeed=0.01;  % in [mm/s]
myStage.SetVelParams(motor_id, min_v, accel, newSpeed);

newPosition=currentPosition+0.1; % in [mm]
myStage.SetAbsMovePos(motor_id, newPosition); 
myStage.MoveAbsolute(motor_id, false);

% wait until motor has finished moving
timeToWait = round(abs(newPosition-currentPosition)/newSpeed);
pause(timeToWait + 2.0);


%% Clean up hardware objects
myController.StopCtrl;
myStage.StopCtrl;
clear myStage myController;
close(1);