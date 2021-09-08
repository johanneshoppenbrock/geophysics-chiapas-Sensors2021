% VES1dinv
% 1D Inversion of Schlumberger and dipole-dipole sounding data
% based on VES1dinv inversion by Ekinci and Demirci (2008)
%
% Adapted by Matthias Buecker, May 2019
%
% Extensions to original code include:
% - Incorporation of dipole-dipole forward modelling and inversion
% - Implementation of an inversion approach based on Matlab's fmincon
% - Implementation of constraints on model parameters

close all; clear variables; clc;

% Load sounding data
dat = dlmread('C:\Users\johan\PowerFolders\Bachelorarbeit\1D Inversion - Matlab\Real2\Nah9\Nah9L4kurz_paper.txt');
x = dat(:,1);       % AB/2 for Schlumberger, (n+1)*a for Dipole-dipole (m)
roa = dat(:,2);   	% Apparent resistivity (Ohm.m)
ary = 'dd';        % Array type 'sch' or 'dd'

% Guess initial model
r0 = [22.8 8 200];   	% Layer resistivities (Ohm.m)
t0 = [20 3];            % Layer thicknesses (m)
m0 = [r0 t0];           % Model parameter array

% Fix model parameters (based on model parameter array)
% An entry '1' in this array fixes the corresponding model parameter
mfix = [1,1,0,1,0];
%mfix = m0*0;

%% MATLAB OPTIMIZATION USING FMINCON
disp('This is FMINCON speaking:')
% Object function for optimization
objfun = @(y)objparameterfun(y,x,roa,ary);
% Physical constraint (layer resistivities and thicknesses must be >= 0)
A = -diag(ones(1,length(m0)));
b = zeros(length(m0),1);
% Constraints on model parameters (fix resistivity and/or thicknesses)
Aeq = diag(mfix);
beq = mfix.*m0;
% Optimization
mM = fmincon(objfun,m0,A,b,Aeq,beq);

% Extract layer resistivities and thicknesses
rM = mM(1:length(r0));
tM = mM((length(r0)+1):end);

% Solve forward problem for final model parameters
for i = 1:length(x)
    roaM(i,:) = VES1dmod (rM,tM,x(i),ary);
end
% RMS
rmsM = norm((roaM-roa)./roa) /sqrt(length(roa));

%% VES1DINV INVERSION
% Damped least-squares inversion using singular value decomposition
disp('This is VES1DINV speaking:')
% Stopping criteria
kr = 10e-10;            % Minimum error
maxiteration = 100;     % Maximum number of iterations

% Initialize model and control parameters
m = m0;                 % Start model
dfit = 1;               %         
iteration = 1;
out = 1;
% Loop for iterative inversion process
while iteration<maxiteration && out
    r = m(1:length(r0));
    t = m(1+length(r0):end);
    roa1 = VES1dmod(r,t,x,ary);
    e1 = log(roa)-log(roa1);
    dd = e1;
    misfit1 = e1'*e1;
    A = jacobian(x,r,t,roa,roa1,ary);
    
    % Fix model parameters
    Afix = diag(1-mfix);
    A = A*Afix;
    
    [U,S,V] = svd(A,0);
    ss = length(S);
    say = 1;
    k = 0;
    while say<ss
        diagS = diag(S);
        beta = S(say)*(dfit^(1/say));
        if beta<10e-5
            beta = 0.001*say;
        end
        for i4 = 1:ss
            SS(i4,i4) = S(i4,i4)/(S(i4,i4)^2+beta);
        end
        dmg = V*SS*U'*dd;
        mg = exp(log(m)+dmg');
        r = mg(1:length(r0));
        t = mg(1+length(r0):end);
        roa4 = VES1dmod (r,t,x,ary);
        e2 = log(roa)-log(roa4);
        misfit2 = e2'*e2;
        if misfit2>misfit1
            disp('Beta control')
            say = say+1;
            k = k+1;
            if k == ss-1
                out = 0;
                say = ss+1;
            end
        else
            say = ss+1;
            m = mg;
            dfit = (misfit1-misfit2)/misfit1;
            iteration = iteration+1;
            a = iteration;
            if dfit<kr
                out = 0;
                say = say+1;
            end
        end
    end
end
% RMS
rms = norm((roa4-roa)./roa)/sqrt(length(roa));

%% Visualisation
% Initial model 
rr0 = [0,r0];
tt0 = [0,cumsum(t0),max(t)*10];
% Inverted model VES1dinv
rr = [0,r];
tt = [0,cumsum(t),max(t)*10];
% Inverted model MATLAB
rrM = [0,rM];
ttM = [0,cumsum(tM),max(tM)*10];
    
% 1. Initial model and inverted model 
subplot(1,2,1)
stairs(rr0,tt0,'k--')
hold on
stairs(rr,tt,'r-')
stairs(rrM,ttM,'g:','LineWidth',2)
set(gca,'Ydir','reverse')
set(gca,'Xscale','log')
xlim([0.5*min([r,r0,rM]) max([rr,rr0,rrM])*2])
ylim([0 max(tt)])
xlabel('Resistivity \rho (\Omegam)')
ylabel('Depth z (m)')
title(['Iteration ' num2str(iteration) ' (VES1dinv)'])
legend('initial guess','VES1dinv','fmincon','Location','best');
    
% 2. Observed and calculated data
subplot(1,2,2),
loglog(x,roa,'b.','MarkerSize',10)
hold on
plot(x,roa4,'r')
plot(x,roaM,'g:','LineWidth',2)
hold off
xlim([min(x),max(x)]);
ylim([0.9*min(roa),1.1*max(roa)])
xlabel('Array size s (m)')
ylabel('Apparent Resistivity \rho_a (\Omegam)')
title(['RMS_{V} = ' num2str(round(rms*10000)/100) ' % | '...
    'RMS_{f} = ' num2str(round(rmsM*10000)/100) ' %'])
legend('observed','VES1dinv','fmincon','Location','best');

%% Write output to command window
disp(' ')
disp('FINAL INVERTED MODEL VES1DINV')
disp(['Iteration:                    ' num2str(iteration)])
disp(['RMS (-):                      ' num2str(rms)])
disp(['Layer thicknesses (m):        ' num2str(t)])
disp(['Layer resistivities (Ohm.m):  ' num2str(r)])
disp(' ')
disp('FINAL INVERTED MODEL FMINUNC')
disp(['RMS (-):                      ' num2str(rmsM)])
disp(['Layer thicknesses (m):        ' num2str(tM)])
disp(['Layer resistivities (Ohm.m):  ' num2str(rM)])


%Write text file 
Endung = 1;
dlmwrite(['../Nah9\Nah9_L4-dunn' num2str(Endung) '.txt'], [t,r,tM,rM])
dlmwrite(['../Nah9\1SondierungNah9_L4-dunn' num2str(Endung) '.txt'], [x, roa, roa4, roaM, dat(:,3)])
dlmwrite(['../Nah9\2SondierungNah9_L4-dunn' num2str(Endung) '.txt'], [rms, rmsM, iteration])

% dlmwrite('../Nah9\Nah9_L4-dick.txt', [t,r,tM,rM])
% dlmwrite('../Nah9\1SondierungNah9_L4-dick.txt', [x, roa, roa4, roaM])
% dlmwrite('../Nah9\2SondierungNah9_L4-dick.txt', [rms, rmsM])

x=roa4-roa;

Liste=[]
for q=1:9%length(roa)
    Liste(end+1) = (x(q)/dat(q,3))^2;
end
