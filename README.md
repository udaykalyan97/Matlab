# Matlab
Alpha Power Plotting and Visualization of
EEG data
This document explains on how to plot 2D image of alpha power (8 to 11Hz) from the EEG data in MATLAB using EEGLAB toolbox and visualize this data by creating a motion picture of the images plotted. 
Alpha Power from the data is calculated for every 50ms from 0 to 1150ms. “0ms” here does not refer to absolute zero, but to “24ms.” Power at 24ms is calculated separately and stored in the array Power as the starting of the index. Rest of the power calculation in done in the step intervals of every 50ms starting from 50ms to 1150ms. 
Step 1:
Alpha power plotting - MATLAB source code:
% This Matlab code computes the alpha power spectrum of grand averaged data at specific latencies.
% Set the following frequency bands:
[spectra,freqs] = spectopo(EEG.data(1,:,:), 0, EEG.times(1,464));
alphaIdx = find(freqs>6 & freqs<13);
%build Index (All sensor locations)
A1 = 1:222;
A1 = num2cell(A1');
A2 = [{"sensor"} {"band"}];
A3 = [{"alpha"}];
for index_value=1:222
IndexAlpha(index_value+1,1) = A1(index_value,1);
IndexAlpha(index_value+1,2) = A3(1,1);
end
IndexAlpha(1,1) = A2(1,1);
IndexAlpha(1,2) = A2(1,2);
%list datapoints by channel
t=50;
IndexAlpha(1,3)={0};
for j= 4:26
	IndexAlpha(1,j) = {t};
    t=t+50;	
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%list power by channel and datapoint
channel_locs=1:222;
for index_power=1:222
    time=476;
    [spectra,freqs] = spectopo(EEG.data(channel_locs(1,index_power),:,:), 0, EEG.times(1,463));
    Power(index_power,1)= mean(10.^(spectra(alphaIdx)/10));  
for q = 2:24
    [spectra,freqs] = spectopo(EEG.data(channel_locs(1,index_power),:,:), 0, EEG.times(1,time));
    Power(index_power,q)= mean(10.^(spectra(alphaIdx)/10));
    time=time+25;
end
end
%list power by channel and datapoint
for power_to_cell=1:222
for o=3:26
IndexAlpha(power_to_cell+1,o) = num2cell(Power(power_to_cell,o-2));
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


IndexAlpha table is created from the above program should be saved in a excel sheet (.xlsx) format for the contour plot program. So copy the data in IndexAlpha matrix, paste it in excel and save it using the appropriate filename.



Step 2:
Create a contour plot
This MATLab code creates 2D visualization plot of alpha power using IndexAlpha data created in the above code. Input arguments for this code is the ‘filename.xlsx’. In order to plot the locations of the sensors, optional file named ‘Coordinates.mat’ should be loaded and scatter function should be enabled. IndexAlpha data will be read into a matrix table D and is projected on to a polar data (Z) using jet colormap of the contour plot. The limits of color map are predefined to obtain the even contours across all plots. The images created are saved in the present working directory for the creation of the video in the next step.
MATLAB source code:
%load('Coordinates.mat');
D=readtable('filename.xlsx');
figure('Name','filename','NumberTitle','off');
for i=3:26
data = table2array(D(1:222,i));
%data = cell2mat(data);
% Create polar data
[t,r] = meshgrid((0:1:360)*pi/180,[0 50 100]);
% Convert to Cartesian
[X,Y] = pol2cart(t,r);
F = scatteredInterpolant(XCoord',YCoord',data);
Z = F(X,Y);
% Plot a graph.
%figure;
subplot(6,4,i-2);
contourf(X,Y,Z,100,'LineColor', 'none');
daspect([1 1 2])
% colormap
c = jet;
a = c(1:64,:);
colormap jet;
%set the limits of the colormap
set(gca, 'clim', [0,4.54]);
% scatter overlay
hold on
sz = 30;
%scatter(XCoord,YCoord,sz,'fill','k');
m=(i-3)*50;
title(['t=', num2str(m),'ms']);
 %to save files in PNG 
 %temp=['fig','.png']; 
 %saveas(gca,temp); 
end
colorbar('Position',[0.9,0.11,0.02,0.813])
%to save files in PNG 
 temp=['subplot study','.png']; 
 saveas(gca,temp); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=3:26
data = table2array(D(1:222,i));
% Create polar data
[t,r] = meshgrid((0:1:360)*pi/180,[0 50 100]);
% Convert to Cartesian
[X,Y] = pol2cart(t,r);
F = scatteredInterpolant(XCoord',YCoord',data);
Z = F(X,Y);
% Plot a graph.
h=figure('Name','filename','NumberTitle','off');
contourf(X,Y,Z,100,'LineColor', 'none');
daspect([1 1 2])
% colormap
c = jet;
a = c(1:64,:);
colormap jet;
set(gca, 'clim', [0,4.54]);
colorbar('eastoutside');
% scatter overlay
hold on
sz = 30;
%scatter(XCoord,YCoord,sz,'fill','k');
m=(i-3)*50;
title(['t=', num2str(m),'ms']);
 %to save files in PNG 
 temp=['filename',num2str(i-2),'.png']; 
 saveas(gca,temp);
 close(h);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Step 3:
Creating a time lapse video
This MATLAB code will helps you create a time lapse using matlab itself. The code prompts you with three options: to select the images, file location to save the output file in .avi format, number of frames to be set.  
MATLAB source code:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATLAB Time-Lapse Creator, by Ale152 (Alessandro Masullo)
% Run this script and follow the steps to create your video time lapse from
% your images. Images can be a wide range of format but must be all the
% same size, or you will get an error. The video format is JPEG AVI, you 
% can set frame rate, quality and scale factor without change the code.
%
% More info (in italian) at: http://www.wirgilio.it/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear; close all;
% Default var
profile = 'Motion JPEG AVI'; % Use 'doc VideoWriter' for more profile info
% Use the menu to change these parameters
vid_length = 0; % Initial video length
vid_FPS = 30;   % Default FPS
vid_qual = 75;  % Default video quality
vid_scf = 1;    % Default scale factor
Nfile = 0;      % Initial number of file

actual_sel = 'No file selected';
actual_file = 'No file selected';

set(0, 'DefaultUIControlFontSize', 12); % Change menu font size

run = 1;
while run
    choice = menu('Welcome to the Time-Lapse MATLAB Editor! Plese select a choice', ...
                  sprintf('1 - Select images [%s]', actual_sel), ...
                  sprintf('2 - Select video file location [%s]', actual_file), ...
                  sprintf('3 - Select video parameters [Video duration: %d sec]', round(vid_length)), ...
                  '4 - BUILD VIDEO!', ...
                  'Close script');
              
    switch choice
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Select images
        case 1
            try
                [file_name, file_path] = uigetfile( ...
                    {'*.jpeg;*.jpg;*.bmp;*.tif;*.tiff;*.png;*.gif', ...
                     'Image Files (JPEG, BMP, TIFF, PNG and GIF)'}, ...
                     'Select Images', 'multiselect', 'on');
                 Nfile = length(file_name);
                 actual_sel = sprintf('%d file selected from: %s', ...
                                      Nfile, file_path);
                 vid_length = Nfile / vid_FPS;
            catch merr
                errordlg(sprintf( ...
                    'Please follow previous steps in proper order!\n%s', ...
                    merr.message), merr.identifier)
            end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Select video file location
        case 2
            try
                [avi_name, avi_path] = uiputfile('*.avi', 'Save video file');
                aviobj = VideoWriter(strcat(avi_path, avi_name) , ...
                                     profile);
                actual_file = strcat(avi_path, avi_name);
            catch merr
                errordlg(sprintf( ...
                    'Please follow previous steps in proper order!\n%s', ...
                    merr.message), merr.identifier)
            end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Select video parameter
        case 3
            try
                prompt = {'Video frame rate (fps):', ...
                          'JPEG Quality (1-100):', ...
                          'Scale factor (bigger > 1, smaller < 1):'};
                default = {num2str(vid_FPS), num2str(vid_qual), num2str(vid_scf)};
                answer = inputdlg(prompt, 'Select video parameters', ...
                                  1, default);
                aviobj.FrameRate = str2num(answer{1});
                aviobj.Quality = str2num(answer{2});
                vid_length = Nfile / str2num(answer{1});
                vid_FPS = str2num(answer{1});
                vid_qual = str2num(answer{2});
                vid_scf = str2num(answer{3});
            catch merr
                errordlg(sprintf( ...
                    'Please follow previous steps in proper order!\n%s', ...
                    merr.message), merr.identifier)
            end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % BUILD VIDEO
        case 4
            if Nfile == 0
                    errordlg('No images selected')
            else
                try 
                    open(aviobj)
                    wb = waitbar(0, 'Please wait...');
                    for i = 1:Nfile
                        img = imread(strcat(file_path, file_name{i}));
                        if vid_scf ~= 1
                            img = imresize(img, vid_scf);
                        end
                        writeVideo(aviobj, img);
                        % Preview image
                        if mod(i, round(Nfile/10)) == 1
                            imshow(img)
                            title(sprintf('Preview image %d/%d', i, Nfile))
                            uistack(wb, 'top')
                        end
                        waitbar(i/Nfile, wb);
                    end
                    delete(wb)
                    close(aviobj);
                catch merr
                    errordlg(sprintf( ...
                        'Please follow previous steps in proper order!\n%s', ...
                        merr.message), merr.identifier)
                end
            end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Close script
        case 5
            run = 0;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



------------------------End of documentation--------------------------
