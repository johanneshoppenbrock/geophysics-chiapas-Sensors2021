% VES1dforward
% 1D forward modelling of Schlumberger and dipole-dipole sounding sata
% based on the VES1dmod foward model by Ekinci and Demirci (2008)
%
% Matthias Buecker, May 2019
%
% Extensions to original code include:
% - Incorporation of dipole-dipole forward modelling

close all; clear variables; clc;

% Define length s of array (m)
% s = AB/2 for Schlumberger and s = (n+1)*a for dipole-dipole sounding
ary = 'dd';         % Array type 'sch' or 'dd'
smin = 10;           % Smallest s spacing
smax =55;          % Largest s spacing
sN = 10;            % Total number of s spacings
s = linspace(smin,smax,sN)';
%s = logspace(log10(smin),log10(smax),sN)';
% Layered earth model
r = [26 10 200];	% Layer resistivities (Ohm.m)
t = [21 2.21];    	% Layer thicknesses (m)
% Note that length of r must be length of t + 1!

%% Compute apparent resistivity (Ohm.m)
% Loop over s spacings
for i = 1:length(s)
    roa(i,:) = VES1dmod(r,t,s(i),ary);
    % Add noise
    X = 3;         % Noise in percent
    roa(i) = roa(i)+random('Normal',0,X/100*roa(i));
end

%% Visualization
% Resistivity model for visualization
rr = [0,r];
tt = [0,cumsum(t),max(t)*10];

% 1. Resistivity model
subplot(1,2,1)
stairs(rr,tt,'r-')
set(gca,'Ydir','reverse')
set(gca,'Xscale','log')
%set(gca,'Xscale')
xlim([0.5*min(r),max(r)*2]);
ylim([0 max(tt)])
xlabel('Resistivity \rho (\Omegam)')
ylabel('Depth z (m)')
title('Resistivity model')
    
% 2. Sounding data
subplot(1,2,2),
loglog(s,roa,'b.','MarkerSize',10)
xlim([min(s),max(s)]);
ylim([0.9*min(roa),1.1*max(roa)])
xlabel('Array size s (m)')
ylabel('Apparent resistivity  \rho_a (\Omegam)')
title('Sounding curve')

% Write text file
dlmwrite('21mWiderstandKlein.txt',[s,roa])