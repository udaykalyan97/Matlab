% This Matlab code computes the alpha power spectrum of grand averaged data at specific latencies.

% Set the following frequency bands:
[spectra,freqs] = spectopo(EEG.data(1,:,:), 0, EEG.times(1,464));

alphaIdx = find(freqs>6 & freqs<13);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%build Index
%A1 = [{"C3"};{"C4"};{"Cz"};{"F3"};{"F4"};{"F7"};{"F8"};{"Fp1"};{"Fp2"};{"Fz"};{"O1"};{"O2"};{"Oz"};{"P3"};{"P4"};{"P7"};{"P8"};{"Pz"};{"T7"};{"T8"}];
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
%1026
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%list power by channel and datapoint
%channel_locs=[59 180 80 36 218 47 2 37 18 21 113 147 123 85 150 93 167 98 69 199];
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%figure;
%plot(EEG.times(461:5:856),Power);

