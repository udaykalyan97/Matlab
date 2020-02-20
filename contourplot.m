load('Coordinates.mat');
D=readtable('S3_nue.xlsx');

figure('Name','S3_nuetral - Alpha','NumberTitle','off');
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
%set(gca, 'clim', [min(Ci(:)) max(Ci(:))]);

set(gca, 'clim', [0,4.54]);

% scatter overlay
hold on

sz = 30;

%scatter(XCoord,YCoord,sz,'fill','k');
m=(i-3)*50;

title(['t=', num2str(m),'ms']);
 %to save files in PNG 
 %temp=['fig',num2str(i),'.png']; 
 %saveas(gca,temp); 

end
%colorbar('eastoutside');
%colorbar('Position',[0.911328125,0.106481481481481,0.0177734375,0.814043209876543])
colorbar('Position',[0.9,0.11,0.02,0.813])

