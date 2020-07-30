function colormap = generateColorMap(optics,n,numColors,r,g,b)
%input:  optics - csv file of sensor and camera spectral information
%        n - refractive indices eg. n(air),n(water),n(oil)
%        numColors - Colors are resolved every 5000/numColors 
%        r,g,b - RGB channel gains in the colormap     
%output: colormap - colormap for thicknesses of 0-5 micrometers

%% Initializes the colormap matrix, the 3 in the columns is used for RGB
colormap = zeros(numColors+1,3);

%% Calculates the necessary values of reflectance plot (Frensel Equations)
r1 = ((n(1)-n(2))/(n(1)+n(2)))^2;
r2 = ((n(2)-n(3))/(n(2)+n(3)))^2;

%% Compute the reflected intensity at different lambda for different thickness.
d=(0:numColors)*(5000/numColors);
D = 4*n(2)*pi./optics(:,1)*d + pi*((n(2)>n(1)) + (n(3)>n(2)));
R = r1 + r2*(1-r1)^2 + 2*sqrt(r1*r2*(1-r1)^2)*cos(D);
I0= optics(:,2).*optics(:,3);  % Initial intensity product of I(lambda)* Filter(lambda)
I = I0.*R;

%% Calculate the RGB signal intensity at the camera
colormap(:,1) =r*trapz(optics(:,4).*I); % Red Channel 
colormap(:,2) =g*trapz(optics(:,5).*I); % Green Channel 
colormap(:,3) =b*trapz(optics(:,6).*I); % Blue Channel 

%% Normalize for display
colormap=colormap./max(max(colormap));
end