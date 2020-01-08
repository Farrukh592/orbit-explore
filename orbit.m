% erzeugen die Kugel und speichern ihre Koordinaten.
[xs,ys,zs] = sphere; 
% Kugel f�r den unteren und oberen Teil des Satelliten erzeugen
[x,y,z] =sphere;  
% erzeugen einen Zylinder als K�rper des Satelliten.
[x1,y1,z1] = cylinder(1); 
% Bild f�r Erdtextur.
Earth_texture = imread('earth1.jpg');
%-Bild f�r die Textur des Satellitenk�rpers.
Sat_texture = imread('spaceX.jpg');                
% Bild f�r die Textur des Solarpanels.
solarpan = imread('panel.jpg');         
%-Bild f�r die untere Kugel des Satelliten.
topsat = imread('sky.jpg');                 
%-Bild f�r die obere Sph�re des Satelliten.
botsat = imread('sky2.jpg');                 
% Skalierungsfaktor f�r die Erdkugel
r = 6;   
%f�r das Zeichnen der Satelitte und die Verbindung der Elemente untereinander.
hgt = hgtransform;  
% zur Bewegung der Erde
hgth = hgtransform('Parent',gca);                  
% Erde
h = surf(x*r,y*r,z*r,'FaceColor', 'texturemap', 'CData', Earth_texture, 'FaceAlpha',1,'EdgeColor', 'none', 'Parent', hgth);
% Zylinderk�rper des Satelliten
h3 = surf(x1,y1,z1*3-1.5,'FaceColor', 'texturemap', 'CData', Sat_texture, 'FaceAlpha', 1, 'EdgeColor', 'none','Parent',hgt);
% Ober- und Unterkugel des Satelliten.
h4 = surf(xs,ys,zs+1.5,'FaceColor', 'texturemap', 'CData', topsat, 'FaceAlpha', 1, 'EdgeColor', 'none','Parent',hgt);
h5 = surf(xs,ys,zs-1.5,'FaceColor', 'texturemap', 'CData', botsat, 'FaceAlpha', 1, 'EdgeColor', 'none','Parent',hgt);
% Sonnenkollektoren des Satelliten
solpan1 = surf([0.5, 4;0.5, 4],[0, 0; 0, 0],[1, 1; -1, -1],'FaceColor', 'texturemap', 'CData', solarpan, 'FaceAlpha', 1, 'EdgeColor', 'none','Parent',hgt);
solpan2 = surf([-4, -0.5; -4, -0.5],[0, 0; 0, 0],[1, 1; -1, -1],'FaceColor', 'texturemap', 'CData', solarpan, 'FaceAlpha', 1, 'EdgeColor', 'none','Parent',hgt);
% Trajektorie Generation f�r den Satelliten.
t = 0:0.1:20*pi;
X = 42*cos(t/1.6);
Y = 42*sin(t/1.6);
beta = pi/15;%f�r die Rotation der Erde.
%Wir stellen nun die Achsen- und Hintergrundfarbe der MATLAB-Figur ein
axis([-45 ,45, -45, 45, -10, 10])
set(gca, 'color' , 'black')
% f�r lied
load handel.mat
filename = 'hande.wav';
audiowrite(filename,y,Fs)
clear y Fs
[y, Fs] = audioread('handel.wav');
sound(y,Fs);

for i=1:length(X)
% Erde
RxTx = [cos(i*beta), -sin(i*beta), 0, 0; sin(i*beta), cos(i*beta), 0, 0; 0, 0, 1, 0; 0, 0, 0,1];  % rotation matrix along x-axis
set(hgth,'Matrix',RxTx);
drawnow;
% �bersetzung f�r Satellit. Trans stellen die �bersetzung dar.
Trans = [1, 0, 0, 0.7*X(i);
0, 1, 0, 0.7*Y(i);
0, 0, 1, 0.0000
0, 0, 0, 1.0000 ];
set(hgt,'Matrix',Trans);
drawnow;
end
