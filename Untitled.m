clearvars;
addpath('C:\Users\uday9\Desktop\eeglab2019_1');            %EEGLAB LOCATION 
mkdir('Negative_AvgPower');                                        %Creates output in newFolder in Present working Directory
cd('Negative_AvgPower');


%%%%Intialization%%%%%%%%%%%%%%%%
%Positive good epochs
%good_epochs = [50,49,50,50,50,45,50,48,50,50,50,48,50,50,50,48,49,50,41,50,50,50,50,41,47,50,49,50,50,50,45,49,50,50,50,50,50,46,48,48,50,48,49,50,50];

%Nuetral good epochs
%good_epochs = [49,50,50,50,50,48,50,49,50,50,50,44,50,50,50,48,50,50,40,50,50,50,50,43,47,50,50,49,50,50,45,50,50,48,50,49,50,46,47,50,50,48,46,50,50];

%Negative good epochs
good_epochs = [48,49,48,50,50,47,50,47,50,50,50,44,50,50,50,50,49,50,42,49,49,50,50,45,41,50,50,49,49,50,48,49,50,46,48,50,50,47,49,49,49,47,47,50,43];

subjects = {'S3 TFP nega.set','S4 TFP nega.set','S9 TFP nega.set','S11 TFP nega.set','S12 TFP nega.set','S13 TFP nega.set','S14 TFP nega.set','S17 TFP nega.set','S18 TFP nega.set','S19 TFP nega.set','S20 TFP nega.set','S21 TFP nega.set','S22 TFP nega.set','S26 TFP nega.set','S28 TFP nega.set','S29 TFP nega.set','S30 TFP nega.set','S31 TFP nega.set','S33 TFP nega.set','S35 TFP nega.set','S39 TFP nega.set','S40 TFP nega.set','S41 TFP nega.set','S43 TFP nega.set','S46 TFP nega.set','S47 TFP nega.set','S48 TFP nega.set','S58 TFP nega.set','S59 TFP nega.set','S60 TFP nega.set','S62 TFP nega.set','S64 TFP nega.set','S65 TFP nega.set','S66 TFP nega.set','S67 TFP nega.set','S69 TFP nega.set','S71 TFP nega.set','S72 TFP nega.set','S73 TFP nega.set','S75 TFP nega.set','S76 TFP nega.set','S77 TFP nega.set','S78 TFP nega.set','S80 TFP nega.set','S81 TFP nega.set'};

left_sensors = [ 28, 29, 33, 34, 35, 36, 38, 39, 40, 41, 47, 48, 49, 55];
right_sensors = [2, 3, 4, 5, 11, 12, 13, 19, 210, 211, 215, 216, 217, 218];


%{

%%%Positive good epochs
good_epochs = [50,49,50,50,50,45,50,48,50,50,50,48,50,50,50,48,49,50,41,50,50,50,50,41,47,50,49,50,50,50,45,49,50,50,50,50,50,46,48,48,50,48,49,50,50];

%%%Neutral good epochs
%good_epochs = [49,50,50,50,50,48,50,49,50,50,50,44,50,50,50,48,50,50,40,50,50,50,50,43,47,50,50,49,50,50,45,50,50,48,50,49,50,46,47,50,50,48,46,50,50];

%%%Negative good epochs
%good_epochs = [48,49,48,50,50,47,50,47,50,50,50,44,50,50,50,50,49,50,42,49,49,50,50,45,41,50,50,49,49,50,48,49,50,46,48,50,50,47,49,49,49,47,47,50,43];

%%%Positive participants
subjects = {'S3 TFP posi.set','S4 TFP posi.set','S9 TFP posi.set','S11 TFP posi.set','S12 TFP posi.set','S13 TFP posi.set','S14 TFP posi.set','S17 TFP posi.set','S18 TFP posi.set','S19 TFP posi.set','S20 TFP posi.set','S21 TFP posi.set','S22 TFP posi.set','S26 TFP posi.set','S28 TFP posi.set','S29 TFP posi.set','S30 TFP posi.set','S31 TFP posi.set','S33 TFP posi.set','S35 TFP posi.set','S39 TFP posi.set','S40 TFP posi.set','S41 TFP posi.set','S43 TFP posi.set','S46 TFP posi.set','S47 TFP posi.set','S48 TFP posi.set','S58 TFP posi.set','S59 TFP posi.set','S60 TFP posi.set','S62 TFP posi.set','S64 TFP posi.set','S65 TFP posi.set','S66 TFP posi.set','S67 TFP posi.set','S69 TFP posi.set','S71 TFP posi.set','S72 TFP posi.set','S73 TFP posi.set','S75 TFP posi.set','S76 TFP posi.set','S77 TFP posi.set','S78 TFP posi.set','S80 TFP posi.set','S81 TFP posi.set'};

%%%Neutral participants
%subjects = {'S3 TFP neut.set','S4 TFP neut.set','S9 TFP neut.set','S11 TFP neut.set','S12 TFP neut.set','S13 TFP neut.set','S14 TFP neut.set','S17 TFP neut.set','S18 TFP neut.set','S19 TFP neut.set','S20 TFP neut.set','S21 TFP neut.set','S22 TFP neut.set','S26 TFP neut.set','S28 TFP neut.set','S29 TFP neut.set','S30 TFP neut.set','S31 TFP neut.set','S33 TFP neut.set','S35 TFP neut.set','S39 TFP neut.set','S40 TFP neut.set','S41 TFP neut.set','S43 TFP neut.set','S46 TFP neut.set','S47 TFP neut.set','S48 TFP neut.set','S58 TFP neut.set','S59 TFP neut.set','S60 TFP neut.set','S62 TFP neut.set','S64 TFP neut.set','S65 TFP neut.set','S66 TFP neut.set','S67 TFP neut.set','S69 TFP neut.set','S71 TFP neut.set','S72 TFP neut.set','S73 TFP neut.set','S75 TFP neut.set','S76 TFP neut.set','S77 TFP neut.set','S78 TFP neut.set','S80 TFP neut.set','S81 TFP neut.set'};

%%%Negative participants
%subjects = {'S3 TFP nega.set','S4 TFP nega.set','S9 TFP nega.set','S11 TFP nega.set','S12 TFP nega.set','S13 TFP nega.set','S14 TFP nega.set','S17 TFP nega.set','S18 TFP nega.set','S19 TFP nega.set','S20 TFP nega.set','S21 TFP nega.set','S22 TFP nega.set','S26 TFP nega.set','S28 TFP nega.set','S29 TFP nega.set','S30 TFP nega.set','S31 TFP nega.set','S33 TFP nega.set','S35 TFP nega.set','S39 TFP nega.set','S40 TFP nega.set','S41 TFP nega.set','S43 TFP nega.set','S46 TFP nega.set','S47 TFP nega.set','S48 TFP nega.set','S58 TFP nega.set','S59 TFP nega.set','S60 TFP nega.set','S62 TFP nega.set','S64 TFP nega.set','S65 TFP nega.set','S66 TFP nega.set','S67 TFP nega.set','S69 TFP nega.set','S71 TFP nega.set','S72 TFP nega.set','S73 TFP nega.set','S75 TFP nega.set','S76 TFP nega.set','S77 TFP nega.set','S78 TFP nega.set','S80 TFP nega.set','S81 TFP nega.set'};

%}


%%%%%File locations%%%%%%%%%%%%%%%%%%%%%%55
%folder = 'D:\\matlab documents\\Krishna-Uday\\Data Files\\Positive\\';
folder = 'D:\\matlab documents\\Krishna-Uday\\Data Files\\Negative\\';
%folder = 'D:\\matlab documents\\Krishna-Uday\\Data Files\\Neutral\\';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',subjects,'filepath',folder);    %FILE NAME AND LOCATION
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'study',0); 

%%%pwelch function parameters%%%
N = EEG.pnts;
Fs = EEG.srate;
NFFT = 2^nextpow2(N);
NOVERLAP = 0;
WINDOW = 100;                   %%Segment length=100


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for sub = 1: length(subjects)
EEG = eeg_retrieve(ALLEEG,sub);
%%%%%%%%Pre-stimulus%%%%%%%%%%%%
mkdir(string(subjects(sub)));
a=extractBefore(subjects(sub)," TFP");

for i = 1: length(left_sensors)
for epochs=1:good_epochs(sub)
clearvars spectraPR freqsPR; 

pre_stmlus = EEG.data(left_sensors(i),201:351,epochs);                     %EEG data for time 100 to 500ms 
[spectraPR, freqsPR] = pwelch(pre_stmlus, WINDOW, NOVERLAP, NFFT,Fs);      %extract power using pwelch function
alphaIdxPR = find(freqsPR>7 & freqsPR<13);                                 %find power in alpha range of frequencies
alphaPowerPR(epochs,i) = mean(spectraPR(alphaIdxPR));                      %mean power for within one epoch
end
alphaPowerPR(52,i) = mean(alphaPowerPR(1:epochs,i));
alphaPowerPR(53,i) = std(alphaPowerPR(1:epochs,i));
alphaPowerPR(55,i) = left_sensors(i);
end

b='negi_prestim_FL_allepochs.xls';
c=append(a,b);
xlswrite(c{1},alphaPowerPR);
movefile(c{1},string(subjects(sub)));

clearvars alphaIdxPR alphaPowerPR 

for i = 1: length(right_sensors)
for epochs=1:good_epochs(sub)
clearvars spectraPR freqsPR; 

pre_stmlus = EEG.data(right_sensors(i),201:351,epochs);                    %EEG data for time 100 to 500ms 
[spectraPR, freqsPR] = pwelch(pre_stmlus, WINDOW, NOVERLAP, NFFT,Fs);      %extract power using pwelch function
alphaIdxPR = find(freqsPR>7 & freqsPR<13);                                 %find power in alpha range of frequencies
alphaPowerPR(epochs,i) = mean(spectraPR(alphaIdxPR));                      %mean power for within one epoch
end
alphaPowerPR(52,i) = mean(alphaPowerPR(1:epochs,i));
alphaPowerPR(53,i) = std(alphaPowerPR(1:epochs,i));
alphaPowerPR(55,i) = left_sensors(i);
end

b='negi_prestim_FR_allepochs.xls';
c=append(a,b);
xlswrite(c{1},alphaPowerPR);
movefile(c{1},string(subjects(sub)));

clearvars alphaIdxPO alphaPowerPO

for i = 1: length(left_sensors)
for epochs=1:good_epochs(sub)
clearvars spectraPO freqsPO

post_stmlus = EEG.data(left_sensors(i),501:701,epochs);                    %EEG data for time 100 to 500ms 
[spectraPO, freqsPO] = pwelch(post_stmlus, WINDOW, NOVERLAP, NFFT,Fs);     %extract power using pwelch function
alphaIdxPO = find(freqsPO>7 & freqsPO<13);                                 %find power in alpha range of frequencies
alphaPowerPO(epochs,i) = mean(spectraPO(alphaIdxPO));                      %mean power for within one epoch
end 
alphaPowerPO(52,i) = mean(alphaPowerPO(1:epochs,i));
alphaPowerPO(53,i) = std(alphaPowerPO(1:epochs,i));
alphaPowerPO(55,i) = right_sensors(i);
end

b='negi_poststim_FL_allepochs.xls';
c=append(a,b);
xlswrite(c{1},alphaPowerPO);
movefile(c{1},string(subjects(sub)));

clearvars alphaIdxPO alphaPowerPO 

for i = 1: length(right_sensors)
for epochs=1:good_epochs(sub)
clearvars spectraPO freqsPO

post_stmlus = EEG.data(right_sensors(i),501:701,epochs);                   %EEG data for time 100 to 500ms 
[spectraPO, freqsPO] = pwelch(post_stmlus, WINDOW, NOVERLAP, NFFT,Fs);     %extract power using pwelch function
alphaIdxPO = find(freqsPO>7 & freqsPO<13);                                 %find power in alpha range of frequencies
alphaPowerPO(epochs,i) = mean(spectraPO(alphaIdxPO));                      %mean power for within one epoch
end
alphaPowerPO(52,i) = mean(alphaPowerPO(1:epochs,i));
alphaPowerPO(53,i) = std(alphaPowerPO(1:epochs,i));
alphaPowerPO(55,i) = right_sensors(i);
end


b='negi_poststim_FR_allepochs.xls';
c=append(a,b);
xlswrite(c{1},alphaPowerPO);
movefile(c{1},string(subjects(sub)));

disp(subjects(sub));
end
