%% An example script for communicating with a Raspberry Pi camera
%
% IMPORTANT: 
%   1. If you used a web interface to watch the rasPi camera in real time, 
%   make sure you stopped the camera in that interface (press "Stop Camera").
%
%   2. If neither the web interface nor Matlab can communicate with the camera (freeze), use MobaXTerm:
%   >> ssh pi@142.103.238.17 (change address accordingly, password = raspberry)
%   >> sudo reboot now

clear all; close all;

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

%% Take a single image and plot it

% Clear the buffer by taking 5 pre-shots
for k=1:5; snapshot(mycam); end;

% Take the final image
colorImage = snapshot(mycam);
bwImage = rgb2gray(colorImage);  % convert to gray scale

% Plot the image
figure;
imagesc(bwImage);
colormap gray;

%% Extract total normalized brightness in the region of interest
clf;
imagesc(bwImage);
colormap gray;

% % Draw the rectangular ROI
% roi=drawrectangle;
% roiPosition=round(roi.Position);
% delete(roi);

% click at a spot on the image
roi=ginput(1);
roiPosition=round([roi(1) roi(2) 10 10]);

% Extract the roi part of the image (notice the proper indexing!)
roiImage=bwImage(roiPosition(2):roiPosition(2)+roiPosition(4)-1,...
                 roiPosition(1):roiPosition(1)+roiPosition(3)-1);
totalBrightness=sum(sum(roiImage))/(roiPosition(3)*roiPosition(4))/256


%% Record a movie and play it

% Time of recording in [s], must be longer than 4 s!
recordingTime=150;

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

I = zeros(recordingTime*30-3, 1);
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
    I(i)=sum(sum(roiImage))/(roiPosition(3)*roiPosition(4))/256;
    i = i+1;
end

% Clean up the video object
clear vidObj;

%% Clean up hardware objects
clear mycam mypi

