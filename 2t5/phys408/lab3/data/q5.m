%% Initialize the camera
clear mypi mycam;    % in case it wasn't cleaned up after last use

% Rasperry Pi address (specific to each station)
piAddress='142.103.238.20';    

% Useful parameters (use ">>help cameraboard" to see available parameters)
frameRate=30;       % rate of recording a movie in [frames/s]
imageAngle=0;       % degree of rotation in [deg]
imageResolution='640x480'; % resolution 

% Initialize
mypi = raspi(piAddress,'pi','raspberry'); 
mycam = cameraboard(mypi,'Resolution',imageResolution,...
                         'Rotation',imageAngle,...
                         'FrameRate',frameRate);
                
%% Init motors    

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

%%

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

%% Extract total normalized brightness in the region of interest
% Clear the buffer by taking 5 pre-shots
for k=1:5; snapshot(mycam); end;

% Take the final image
colorImage = snapshot(mycam);
bwImage = rgb2gray(colorImage);  % convert to gray scale

% Plot the image
figure;
imagesc(bwImage);
colormap gray;

clf;
imagesc(bwImage);
colormap gray;

% % Draw the rectangular ROI
% roi=drawrectangle;
% roiPosition=round(roi.Position);
% delete(roi);

% click at a spot on the image
roi=ginput(1);
roiPosition=round([roi(1) roi(2) 50 50]);

% Extract the roi part of the image (notice the proper indexing!)
roiImage=bwImage(roiPosition(2):roiPosition(2)+roiPosition(4)-1,...
                 roiPosition(1):roiPosition(1)+roiPosition(3)-1);
totalBrightness=sum(sum(roiImage))/(roiPosition(3)*roiPosition(4))/256;

%% Record a movie and play it

newSpeed=0.003;  % in [mm/s]
newPosition=currentPosition+1.5; % in [mm]

% wait until motor has finished moving
timeToWait = round(abs(newPosition-currentPosition)/newSpeed);

% Time of recording in [s], must be longer than 4 s!
recordingTime=timeToWait+2;

% Start motor
myStage.SetVelParams(motor_id, min_v, accel, newSpeed);
myStage.SetAbsMovePos(motor_id, newPosition); 
myStage.MoveAbsolute(motor_id, false);
currentPosition=newPosition;

% Record the movie
record(mycam, 'raspi.h264', recordingTime);
pause(recordingTime+1);

% copy the video recording from the raspberry pi to the current directory
getFile(mypi, 'raspi.h264');
pause(1);

% use ffmpeg to convert the "raspi.h264" video file to a "raspi.mp4" file.
if isfile('raspi.mp4'); delete 'raspi.mp4'; end;    % delete if exists
ffmpegDir = 'C:\Users\Public\Desktop\Michelson\ffmpeg\ffmpeg-2021-10-28-git-e84c83ef98-essentials_build';
cmd = ['"' fullfile(ffmpegDir, 'bin', 'ffmpeg.exe') '" -r ' num2str(frameRate) ' -i raspi.h264 -vcodec copy raspi.mp4 -y'];


[status, message] = system(cmd);
pause(1);

 
% read in the mp4 video
vidObj=VideoReader('raspi.mp4');

% Create an axes
currAxes = axes;
colormap gray;

contrast = zeros(recordingTime*30, 1);
% Play the movie
i = 1;
while hasFrame(vidObj)
    colorFrame = readFrame(vidObj);
    bwFrame = rgb2gray(colorFrame);  % convert to gray scale
    image(bwFrame, 'Parent', currAxes);
    currAxes.Visible = 'off';
    %pause(1/vidObj.FrameRate);
    
    roiImage=bwFrame(roiPosition(2):roiPosition(2)+roiPosition(4)-1,...
                 roiPosition(1):roiPosition(1)+roiPosition(3)-1);
    contrast(i) = max(roiImage, [], "all") - min(roiImage, [], "all");
    i = i+1;
end

% Clean up the video object
clear vidObj;

%%
[peaks, locs] = findpeaks(I(200:1200));
period = mean(diff(locs))/30
