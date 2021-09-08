% VES1dplot
% Plot Schlumberger and dipole-dipole sounding data
%
% Matthias Buecker, May 2019

close all; clear variables; clc;

% Load sounding data
dat = dlmread('8ohmm.txt');
s = dat(:,1);       % Array size s (m)
roa = dat(:,2);     % Apparent resistivity (Ohm.m)

% Visualization
% Sounding data
loglog(s,roa,'b.','MarkerSize',10)
xlim([min(s),max(s)]);
ylim([0.9*min(roa),1.1*max(roa)])
xlabel('Array size s (m)')
ylabel('Apparent Resistivity \rho_a (\Omegam)')