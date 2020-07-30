%% Script to plot color map and visualize components in RGB,HSV and Lab

%% User Inputs & Load files
n=[1 1.4 1]; % Refractive index triplet
numColors=5000; %Colors Resolved every 5000/numColors nm
optics=csvread('data/optics306_filter.csv',4,0); % Sample optics data [*** GENERATE THE RELAVENT OPTICS BEFORE ACTUAL USE ***]
numPlots=4;
%% Generate 
ColorMap=generateColorMap(optics,n,numColors,2.03,1.5,1);
ColorMap= permute(repmat(uint8(ColorMap.*255),1,1,700),[3 1 2]);
%% Plot ColorMap
hs1=subplot(numPlots,1,1);
imshow(ColorMap,'InitialMagnification','fit')
axis on
box off
set(gca,'Xticklabel',[],'Yticklabel',[],'Position',[0.2453 0.7673 0.5443 0.1856],'XColor','none','YColor','none');
%% Plot RGB
hs2=subplot(numPlots,1,2);
plot(0:5000/numColors:5000,ColorMap(1,:,1),'r','LineWidth',1.2);
hold on
plot(0:5000/numColors:5000,ColorMap(1,:,2),'g','LineWidth',1.2);
plot(0:5000/numColors:5000,ColorMap(1,:,3),'b','LineWidth',1.2);
set(gca,'Xticklabel',[],'Position',[0.2453 0.5438 0.5443 0.1856],'LineWidth',1.1,'FontSize',12);
title(hs2,'RGB');
legend('R','G','B','Orientation','horizontal')
%% Plot HSV
HSVColorMap=rgb2hsv(ColorMap);
hs3=subplot(numPlots,1,3);
plot(0:5000/numColors:5000,HSVColorMap(1,:,1),'r','LineWidth',1.2);
hold on
plot(0:5000/numColors:5000,HSVColorMap(1,:,2),'g','LineWidth',1.2);
plot(0:5000/numColors:5000,HSVColorMap(1,:,3),'b','LineWidth',1.2);
set(hs3,'Xticklabel',[],'Position',[0.2453 0.3230  0.5443 0.1856],'LineWidth',1.1,'FontSize',12);
title(hs3,'HSV');
legend('H','S','V','Orientation','horizontal')

%% Plot Lab
hs4=subplot(numPlots,1,4);
LabColorMap=rgb2lab(ColorMap);
plot(0:5000/numColors:5000,LabColorMap(1,:,1),'r','LineWidth',1.2);
hold on
plot(0:5000/numColors:5000,LabColorMap(1,:,2),'g','LineWidth',1.2);
plot(0:5000/numColors:5000,LabColorMap(1,:,3),'b','LineWidth',1.2);
set(gca,'Position',[0.2453 0.1 0.5443 0.1856],'LineWidth',1.1,'FontSize',12);
title(hs4,'L*a*b');
lhs4=legend('L*','a*','b*','Orientation','horizontal');
set(lhs4,'Position',[0.6638    0.1193    0.1191    0.0274]);
xlhandle = xlabel('Film Thickness (nm)','Position',[2.5000e+03 -146.8208 -1],'FontSize',14);