clearvars;
addpath('C:\Users\uday9\Desktop\eeglab2019_1');
mkdir('newFolder');
cd('newFolder');


%%%%Intialization%%%%%%%%%%%%%%%%
posi_good_sub_epochs = [50,49,50,50,50,45,50,48,50,50,50,48,50,50,50,48,49,50,41,50,50,50,50,41,47,50,49,50,50,50,45,49,50,50,50,50,50,46,48,48,50,48,49,50,50];

nue_good_sub_epochs = [49,50,50,50,50,48,50,49,50,50,50,44,50,50,50,48,50,50,40,50,50,50,50,43,47,50,50,49,50,50,45,50,50,48,50,49,50,46,47,50,50,48,46,50,50];

nega_good_sub_epochs = [48,49,48,50,50,47,50,47,50,50,50,44,50,50,50,50,49,50,42,49,49,50,50,45,41,50,50,49,49,50,48,49,50,46,48,50,50,47,49,49,49,47,47,50,43];

subjects = {'S3 TFP nega.set','S4 TFP nega.set','S9 TFP nega.set','S11 TFP nega.set','S12 TFP nega.set','S13 TFP nega.set','S14 TFP nega.set','S17 TFP nega.set','S18 TFP nega.set','S19 TFP nega.set','S20 TFP nega.set','S21 TFP nega.set','S22 TFP nega.set','S26 TFP nega.set','S28 TFP nega.set','S29 TFP nega.set','S30 TFP nega.set','S31 TFP nega.set','S33 TFP nega.set','S35 TFP nega.set','S39 TFP nega.set','S40 TFP nega.set','S41 TFP nega.set','S43 TFP nega.set','S46 TFP nega.set','S47 TFP nega.set','S48 TFP nega.set','S58 TFP nega.set','S59 TFP nega.set','S60 TFP nega.set','S62 TFP nega.set','S64 TFP nega.set','S65 TFP nega.set','S66 TFP nega.set','S67 TFP nega.set','S69 TFP nega.set','S71 TFP nega.set','S72 TFP nega.set','S73 TFP nega.set','S75 TFP nega.set','S76 TFP nega.set','S77 TFP nega.set','S78 TFP nega.set','S80 TFP nega.set','S81 TFP nega.set'};

left_sensors = [ 28, 29, 33, 34, 35, 36, 38, 39, 40, 41, 47, 48, 49, 55];
right_sensors = [2, 3, 4, 5, 11, 12, 13, 19, 210, 211, 215, 216, 217, 218];

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',{'S3 TFP nega.set','S4 TFP nega.set','S9 TFP nega.set','S11 TFP nega.set','S12 TFP nega.set','S13 TFP nega.set','S14 TFP nega.set','S17 TFP nega.set','S18 TFP nega.set','S19 TFP nega.set','S20 TFP nega.set','S21 TFP nega.set','S22 TFP nega.set','S26 TFP nega.set','S28 TFP nega.set','S29 TFP nega.set','S30 TFP nega.set','S31 TFP nega.set','S33 TFP nega.set','S35 TFP nega.set','S39 TFP nega.set','S40 TFP nega.set','S41 TFP nega.set','S43 TFP nega.set','S46 TFP nega.set','S47 TFP nega.set','S48 TFP nega.set','S58 TFP nega.set','S59 TFP nega.set','S60 TFP nega.set','S62 TFP nega.set','S64 TFP nega.set','S65 TFP nega.set','S66 TFP nega.set','S67 TFP nega.set','S69 TFP nega.set','S71 TFP nega.set','S72 TFP nega.set','S73 TFP nega.set','S75 TFP nega.set','S76 TFP nega.set','S77 TFP nega.set','S78 TFP nega.set','S80 TFP nega.set','S81 TFP nega.set'},'filepath','D:\\matlab documents\\Krishna-Uday\\Data Files\\Negative\\');
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

for i = 1: length(left_sensors)
for epochs=1:nega_good_sub_epochs(sub)
clearvars spectraPR freqsPR; 

pre_stmlus = EEG.data(left_sensors(i),201:351,epochs);                             %EEG data for time 100 to 500ms 
[spectraPR, freqsPR] = pwelch(pre_stmlus, WINDOW, NOVERLAP, NFFT,Fs);     %extract power using pwelch function
alphaIdxPR = find(freqsPR>7 & freqsPR<13);                                 %find power in alpha range of frequencies
alphaPowerPR(epochs,i) = mean(spectraPR(alphaIdxPR));                      %mean power for within one epoch

%alphaPower_allEpochsPO(i,1)=mean(alphaPowerPO);                       %mean power for all epochs
end

alphaPowerPR(52,i) = mean(alphaPowerPR(1:epochs,i));
end
alphaPowerPR(52,length(left_sensors)+2) = mean(alphaPowerPR(52,1:length(left_sensors)));
mean_left_sensors = alphaPowerPR(52,length(left_sensors)+2);
for j=1:length(left_sensors)
    alphaPowerPR(53,j) = mean_left_sensors-alphaPowerPR(52,j);
    alphaPowerPR(55,j) = left_sensors(j);
end

xlswrite('Pre_stimulus_Front_Left_Power_all_epochs.xls',alphaPowerPR);
movefile('Pre_stimulus_Front_Left_Power_all_epochs.xls',string(subjects(sub)));
clearvars mean_left_sensors

for i = 1: length(left_sensors)
for epochs = 1:nega_good_sub_epochs(sub)
stnd_deviation(epochs,i) = mean(alphaPowerPR(1:epochs,i)) - alphaPowerPR(epochs,i);
end
end
xlswrite('Standard_deviation_pre_stimulus_Front_Left_.xls',stnd_deviation);
movefile('Standard_deviation_pre_stimulus_Front_Left_.xls',string(subjects(sub)));

clearvars alphaIdxPR alphaPowerPR stnd_deviation

for i = 1: length(right_sensors)
for epochs=1:nega_good_sub_epochs(sub)
clearvars spectraPR freqsPR

pre_stmlus = EEG.data(right_sensors(i),201:351,epochs);                             %EEG data for time 100 to 500ms 
[spectraPR, freqsPR] = pwelch(pre_stmlus, WINDOW, NOVERLAP, NFFT,Fs);     %extract power using pwelch function
alphaIdxPR = find(freqsPR>7 & freqsPR<13);                                 %find power in alpha range of frequencies
alphaPowerPR(epochs,i) = mean(spectraPR(alphaIdxPR));                      %mean power for within one epoch

%alphaPower_allEpochsPO(i,1)=mean(alphaPowerPO);                           %mean power for all epochs
end
alphaPowerPR(52,i) = mean(alphaPowerPR(1:epochs,i));
end
alphaPowerPR(52,length(right_sensors)+2) = mean(alphaPowerPR(52,1:length(right_sensors)));
mean_right_sensors = alphaPowerPR(52,length(right_sensors)+2);
for j=1:length(right_sensors)
    alphaPowerPR(53,j) = mean_right_sensors-alphaPowerPR(52,j);
    alphaPowerPR(55,j) = right_sensors(j);
end
xlswrite('Pre_stimulus_Front_Right_Power_all_epochs.xls',alphaPowerPR);
movefile('Pre_stimulus_Front_Right_Power_all_epochs.xls',string(subjects(sub)));
clearvars mean_right_sensors

for i = 1: length(right_sensors)
for epochs = 1:nega_good_sub_epochs(sub)
stnd_deviation(epochs,i) = mean(alphaPowerPR(:,i)) - alphaPowerPR(epochs,i);
end
end
xlswrite('Standard_deviation_pre_stimulus_Front_Right_.xls',stnd_deviation);
movefile('Standard_deviation_pre_stimulus_Front_Right_.xls',string(subjects(sub)));



%%%%Post stimulus power%%%%%%%%%%%%%
for i = 1: length(left_sensors)
for epochs=1:nega_good_sub_epochs(sub)
clearvars spectraPO freqsPO; 

post_stmlus = EEG.data(left_sensors(i),501:701,epochs);                             %EEG data for time 100 to 500ms 
[spectraPO, freqsPO] = pwelch(post_stmlus, WINDOW, NOVERLAP, NFFT,Fs);     %extract power using pwelch function
alphaIdxPO = find(freqsPO>7 & freqsPO<13);                                 %find power in alpha range of frequencies
alphaPowerPO(epochs,i) = mean(spectraPO(alphaIdxPO));                      %mean power for within one epoch

%alphaPower_allEpochsPO(i,1)=mean(alphaPowerPO);                       %mean power for all epochs
end

alphaPowerPO(52,i) = mean(alphaPowerPO(1:epochs,i));
end
alphaPowerPO(52,length(left_sensors)+2) = mean(alphaPowerPO(52,1:length(left_sensors)));
mean_left_sensors = alphaPowerPO(52,length(left_sensors)+2);
for j=1:length(left_sensors)
    alphaPowerPO(53,j) = mean_left_sensors-alphaPowerPO(52,j);
    alphaPowerPO(55,j) = left_sensors(j);
end
xlswrite('Post_stimulus_Front_Left_Power_all_epochs.xls',alphaPowerPO);
movefile('Post_stimulus_Front_Left_Power_all_epochs.xls',string(subjects(sub)));
clearvars mean_left_sensors

for i = 1: length(left_sensors)
for epochs = 1:nega_good_sub_epochs(sub)
stnd_deviation(epochs,i) = mean(alphaPowerPO(1:epochs,i)) - alphaPowerPO(epochs,i);
end
end
xlswrite('Standard_deviation_post_stimulus_Front_Left_.xls',stnd_deviation);
movefile('Standard_deviation_post_stimulus_Front_Left_.xls',string(subjects(sub)));

clearvars alphaIdxPO alphaPowerPO stnd_deviation

for i = 1: length(right_sensors)
for epochs=1:nega_good_sub_epochs(sub)
clearvars spectraPO freqsPO

post_stmlus = EEG.data(right_sensors(i),501:701,epochs);                             %EEG data for time 100 to 500ms 
[spectraPO, freqsPO] = pwelch(post_stmlus, WINDOW, NOVERLAP, NFFT,Fs);     %extract power using pwelch function
alphaIdxPO = find(freqsPO>7 & freqsPO<13);                                 %find power in alpha range of frequencies
alphaPowerPO(epochs,i) = mean(spectraPO(alphaIdxPO));                      %mean power for within one epoch

%alphaPower_allEpochsPO(i,1)=mean(alphaPowerPO);                           %mean power for all epochs
end
alphaPowerPO(52,i) = mean(alphaPowerPO(1:epochs,i));
end
alphaPowerPO(52,length(right_sensors)+2) = mean(alphaPowerPO(52,1:length(right_sensors)));
mean_right_sensors = alphaPowerPO(52,length(right_sensors)+2);
for j=1:length(right_sensors)
    alphaPowerPO(53,j) = mean_right_sensors-alphaPowerPO(52,j);
    alphaPowerPO(55,j) = right_sensors(j);
end

xlswrite('Post_stimulus_Front_Right_Power_all_epochs.xls',alphaPowerPO);
movefile('Post_stimulus_Front_Right_Power_all_epochs.xls',string(subjects(sub)));
clearvars mean_right_sensors

for i = 1: length(right_sensors)
for epochs = 1:nega_good_sub_epochs(sub)
stnd_deviation(epochs,i) = mean(alphaPowerPO(:,i)) - alphaPowerPO(epochs,i);
end
end
xlswrite('Standard_deviation_post_stimulus_Front_Right_.xls',stnd_deviation);
movefile('Standard_deviation_post_stimulus_Front_Right_.xls',string(subjects(sub)));

disp(subjects(sub));
end




