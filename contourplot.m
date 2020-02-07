load('Coordinates.mat');
for i=4:83
data = IndexAlpha(2:21,i);
data = cell2mat(data);
% Create polar data
[t,r] = meshgrid((0:1:360)*pi/180,[0 50 100]);

% Convert to Cartesian
[X,Y] = pol2cart(t,r);
F = scatteredInterpolant(XCoord',YCoord',data);
Z = F(X,Y);

% Plot a graph.
figure
contourf(X,Y,Z,100,'LineColor', 'none');
daspect([1 1 2])

% colormap
c = hsv;
c = c(1:64,:);
colormap jet;

colorbar('southoutside');

% scatter overlay
hold on

sz = 30;

scatter(XCoord,YCoord,sz,'fill','k');

title('S14 - NEGATIVE, alpha')
end