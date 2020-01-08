[x,y,z] =sphere;   % create the sphere and store its coordinates.
[xs,ys,zs] = sphere;  % create sphere for the bottom and upper part of the satellite
[x1,y1,z1] = cylinder(1); % create a cylinder as the body of the satellite.

Earth_texture = imread('earth1.jpg');
Sat_texture = imread('spaceX.jpg');                % image for satellite body texture.
solarpan = imread('panel.jpg');         % image for solar panel texture.
topsat = imread('sky.jpg');                 % image for the bottom sphere of satellite.
botsat = imread('sky2.jpg');                 % image for the upper sphere of satellite.
r = 6;   % scaling factor for the sphere of the earth
hgt = hgtransform;  
hgth = hgtransform('Parent',gca);                  % to move the earth
% Earth
h = surf(x*r,y*r,z*r,'FaceColor', 'texturemap', 'CData', Earth_texture, 'FaceAlpha',1,'EdgeColor', 'none', 'Parent', hgth);

h3 = surf(x1,y1,z1*3-1.5,'FaceColor', 'texturemap', 'CData', Sat_texture, 'FaceAlpha', 1, 'EdgeColor', 'none','Parent',hgt);

h4 = surf(xs,ys,zs+1.5,'FaceColor', 'texturemap', 'CData', topsat, 'FaceAlpha', 1, 'EdgeColor', 'none','Parent',hgt);


h5 = surf(xs,ys,zs-1.5,'FaceColor', 'texturemap', 'CData', botsat, 'FaceAlpha', 1, 'EdgeColor', 'none','Parent',hgt);

solpan1 = surf([0.5, 4;0.5, 4],[0, 0; 0, 0],[1, 1; -1, -1],'FaceColor', 'texturemap', 'CData', solarpan, 'FaceAlpha', 1, 'EdgeColor', 'none','Parent',hgt);

solpan2 = surf([-4, -0.5; -4, -0.5],[0, 0; 0, 0],[1, 1; -1, -1],'FaceColor', 'texturemap', 'CData', solarpan, 'FaceAlpha', 1, 'EdgeColor', 'none','Parent',hgt);


t = 0:0.1:20*pi;
X = 42*cos(t/1.6);
Y = 42*sin(t/1.6);

beta = pi/15;
axis([-45 ,45, -45, 45, -10, 10])
set(gca, 'color' , 'black')

load handel.mat
filename = 'handel.wav';
audiowrite(filename,y,Fs)
clear y Fs

[y, Fs] = audioread('handel.wav');

sound(y,Fs);

for i=1:length(X)
% Earth
RxTx = [cos(i*beta), -sin(i*beta), 0, 0; sin(i*beta), cos(i*beta), 0, 0; 0, 0, 1, 0; 0, 0, 0,1];  % rotation matrix along x-axis
set(hgth,'Matrix',RxTx);
drawnow;
% Translation for satellite. Trans represent the translation.
Trans = [1, 0, 0, 0.7*X(i);
0, 1, 0, 0.7*Y(i);
0, 0, 1, 0.0000
0, 0, 0, 1.0000 ];
set(hgt,'Matrix',Trans);
drawnow;
end
