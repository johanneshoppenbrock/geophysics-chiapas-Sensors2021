
clc; clear all; close all;
%% Input data file with UTM coordinates
Daten = dlmread('Nah2-utm.txt', '\t');

%% path to save sorted and averaged data
pfad1 ='1D_inversion\Nah2-utm-1D.txt';
pfad2 ='Res2Dinv\Nah2-utm-2D.dat';

%% set boundary conditions for data
% set first and last used data point 
Startindex=1;
Endindex=275;
% select segment on profile
Messgrenzeunten=100;
Messgrenzeoben=200;
% filter for small or high resistivities 
RGrenzeUnten=0;
RGrenzeOben=5000;

%% initialize lists
Widerstand = [];
a = 0;
b = 0;
c = 0;
d = 0;
e = 0;
f = 0;
g = 0;
h = 0;
j = 0;
l = 0;
a1=[];
b1=[];
c1=[];
d1=[];
e1=[];
f1=[];
g1=[];
h1=[];
j1=[];
l1=[];
Wasserwiderstand=[];
Widerstand1= [];
nValue=[];
v=0;
Messpunkt=[];
ElectrodeSpacing=[];
Abstand= [];
% number of values
AnzahlWerte = Endindex-Startindex;

%% loop to calculate averaged resistivities and positions of measuring points 
for i = Startindex:Endindex
    % calculate apparent resistivity from measured resistivity with geometric factor
    B = Daten (i,2);
    M = Daten (i,3);
    n = (M-B)/5;
    k = pi*n*(n+1)*(n+2)*5;
    R= k*(abs(Daten(i,5)));
    % sort out resistivities that are too small or high
    if R >RGrenzeUnten&& R <RGrenzeOben
        % calculate position of apparent resistivity 
        Messpunkt(end+1)=((Daten(i,1)+Daten(i,2))/2+(Daten(i,3)+Daten(i,4))/2)/2;
        v=v+1; % counter for position
        ElectrodeSpacing(end+1)=5;
        nValue(end+1)=n;
        Widerstand(end+1) = k*(abs(Daten(i,5)));
        
        % calculate distance between adjacent boat coordinates 
        if i ~= 1
         if Daten(i,1) ~= Daten(i-1,1)
              Abstand(end+1) = sqrt((Daten(i-1,6)-Daten(i,6))^2+(Daten(i-1,7)-Daten(i,7))^2);
         end
        end
        
        % calculate distance between first measuring point and
        % measuring point i
            if i>Startindex-1 && i<Startindex+10 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)
            end
            if i>Startindex+9 && i<Startindex+20 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-5;
            end
            if i>Startindex+19 && i<Startindex+30 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-10;
            end
            if i>Startindex+29 && i<Startindex+40 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-15;
            end
            if i>Startindex+39 && i<Startindex+50 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-20;
            end
            if i>Startindex+49 && i<Startindex+60 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-25;
            end
            
            if i>Startindex+59 && i<Startindex+70 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-30;
            end
            if i>Startindex+69 && i<Startindex+80 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-35;
            end
            if i>Startindex+79 && i<Startindex+90 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-40;
            end    
            if i>Startindex+89 && i<Startindex+100 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-45;
            end  
            if i>Startindex+99 && i<Startindex+110 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-50;
            end
            if i>Startindex+109 && i<Startindex+120 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-55;
            end
            if i>Startindex+119 && i<Startindex+130 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-60;
            end
            if i>Startindex+129 && i<Startindex+140 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-65;
            end
            if i>Startindex+139 && i<Startindex+150 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-70;
            end
            if i>Startindex+149 && i<Startindex+160 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-75;
            end
            if i>Startindex+159 && i<Startindex+170 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-80;
            end
            if i>Startindex+169 && i<Startindex+180 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-85;
            end
            if i>Startindex+179 && i<Startindex+190 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-90;
            end
            if i>Startindex+189 && i<Startindex+200 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-95;
            end
            if i>Startindex+199 && i<Startindex+210 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-100;
            end
            if i>Startindex+209 && i<Startindex+220 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-105;
            end            
            if i>Startindex+219 && i<Startindex+230 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-110;
            end
            if i>Startindex+229 && i<Startindex+240 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-115;
            end
            if i>Startindex+239 && i<Startindex+250 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-120;
            end            
            if i>Startindex+249 && i<Startindex+260 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-125;
            end            
            if i>Startindex+259 && i<Startindex+270 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-130;
            end            
            if i>Startindex+269 && i<Startindex+280 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-135;
            end
            if i>Startindex+279 && i<Startindex+290 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-140;
            end            
            if i>Startindex+289 && i<Startindex+300 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-145;
            end            
            if i>Startindex+299 && i<Startindex+310 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-150;
            end
            if i>Startindex+309 && i<Startindex+320 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-155;
            end            
            if i>Startindex+319 && i<Startindex+330 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-160;
            end            
            if i>Startindex+329 && i<Startindex+340 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-165;
            end
            if i>Startindex+339 && i<Startindex+350 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-170;
            end
            if i>Startindex+349 && i<Startindex+360
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-175;
            end
            if i>Startindex+359 && i<Startindex+370 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-180;
            end
            if i>Startindex+369 && i<Startindex+380 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-185;
            end
            if i>Startindex+379 && i<Startindex+390 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-190;
            end
            if i>Startindex+389 && i<Startindex+400 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-195;
            end
            if i>Startindex+399 && i<Startindex+410 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-200;
            end
            if i>Startindex+409 && i<Startindex+420 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-205;
            end
            if i>Startindex+419 && i<Startindex+430 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-210;
            end
            if i>Startindex+429 && i<Startindex+440 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-215;
            end
            if i>Startindex+439 && i<Startindex+450 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-220;
            end
            if i>Startindex+449 && i<Startindex+460 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-225;
            end
            if i>Startindex+459 && i<Startindex+470 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-230;
            end
            if i>Startindex+469 && i<Startindex+480 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-235;
            end
            if i>Startindex+479 && i<Startindex+490 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-240;
            end
            if i>Startindex+489 && i<Startindex+500 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-245;
            end
            if i>Startindex+499 && i<Startindex+510 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-250;
            end            
            if i>Startindex+509 && i<Startindex+520 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-255;
            end
            if i>Startindex+519 && i<Startindex+530 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-260;
            end
            if i>Startindex+529 && i<Startindex+540 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-265;
            end
            if i>Startindex+539 && i<Startindex+550 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-270;
            end
            if i>Startindex+549 && i<Startindex+560 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-275;
            end
            if i>Startindex+559 && i<Startindex+570 
                Messpunkt(v)=Messpunkt(v)+sum(Abstand)-280;
            end

        if Daten(i,5) == 0
            n = 0;
        end
        
        % averaging of all apparent resistivities with the same pseudodepth in the segment  
        if n == 1
            Messpunkt(v)= Messpunkt(v) ;
            if Messpunkt(v) <Messgrenzeoben && Messpunkt(v)>Messgrenzeunten
                a1(end+1)=k*(abs(Daten(i,5)));
                a = mean(a1); % mean of apparent resistivities 
                as = std(a1); % standard deviation
                Wasserwiderstand(end+1)=k*(abs(Daten(i,5)));
            end
        end

        if n == 2
            Messpunkt(v)= Messpunkt(v) ;
            if Messpunkt(v) <Messgrenzeoben && Messpunkt(v)>Messgrenzeunten
                b1(end+1)=k*(abs(Daten(i,5)));
                b = mean(b1);
                bs = std(b1);
            end
        end
        if n == 3
            Messpunkt(v)= Messpunkt(v) ;
            if Messpunkt(v) <Messgrenzeoben && Messpunkt(v)>Messgrenzeunten
                c1(end+1)=k*(abs(Daten(i,5)));
                c = mean(c1);
                cs = std(c1);
            end
        end
        if n == 4
            Messpunkt(v)= Messpunkt(v) ;
            if Messpunkt(v) <Messgrenzeoben && Messpunkt(v)>Messgrenzeunten
                d1(end+1)=k*(abs(Daten(i,5)));
                d = mean(d1);
                ds = std(d1);
            end
        end
        if n == 5
            Messpunkt(v)= Messpunkt(v) ;
            if Messpunkt(v) <Messgrenzeoben && Messpunkt(v)>Messgrenzeunten
                e1(end+1)=k*(abs(Daten(i,5)));
                e = mean(e1);
                es = std(e1);
            end
        end
        if n == 6
            Messpunkt(v)= Messpunkt(v) ;
            if Messpunkt(v) <Messgrenzeoben && Messpunkt(v)>Messgrenzeunten
                f1(end+1)=k*(abs(Daten(i,5)));
                f = mean(f1);
                fs = std(f1);
            end
        end
        if n == 7
            Messpunkt(v)= Messpunkt(v) ;
            if Messpunkt(v) <Messgrenzeoben && Messpunkt(v)>Messgrenzeunten
                g1(end+1)=k*(abs(Daten(i,5)));
                g = mean(g1);
                gs = std(g1);
            end
        end
        if n == 8
            Messpunkt(v)= Messpunkt(v) ;
            if Messpunkt(v) <Messgrenzeoben && Messpunkt(v)>Messgrenzeunten
                h1(end+1)=k*(abs(Daten(i,5)));
                h = mean(h1);
                hs = std(h1);
            end
        end
        if n == 9
            Messpunkt(v)= Messpunkt(v);
            if Messpunkt(v) <Messgrenzeoben && Messpunkt(v)>Messgrenzeunten
                j1(end+1)=k*(abs(Daten(i,5)));
                j = mean(j1);
                js = std(j1);
            end
        end
        if n == 10
            if Messpunkt(v) <Messgrenzeoben && Messpunkt(v)>Messgrenzeunten
                l1(end+1)=k*(abs(Daten(i,5)));
                l = mean(l1);
                ls = std(l1);
            end
        end 
    end
end

%% put averaged apparent resistivities and standard deviations in lists 
Mittelwerte = [];
Mittelwerte(end+1) = a;
Mittelwerte(end+1) = b;
Mittelwerte(end+1) = c;
Mittelwerte(end+1) = d;
Mittelwerte(end+1) = e;
Mittelwerte(end+1) = f;
Mittelwerte(end+1) = g;
Mittelwerte(end+1) = h;
Mittelwerte(end+1) = j;
Mittelwerte(end+1) = l;

STD=[];
STD(end+1)=as;
STD(end+1)=bs;
STD(end+1)=cs;
STD(end+1)=ds;
STD(end+1)=es;
STD(end+1)=fs;
STD(end+1)=gs;
STD(end+1)=hs;
STD(end+1)=js;
STD(end+1)=ls;

% list for dipole lengths
Laenge = [10];
for j=2:10
    Laenge(j)= Laenge(j-1)+5; 
end 

Mittelwerte2 = transpose(Mittelwerte)
STD2= transpose(STD);
%% Save averaged apparent resistivites in VES1DINV format

fid2 = fopen(pfad1,'wt+');  
for k=1:length(Mittelwerte) 
  fprintf(fid2, '%f\t %f\t %f\n',Laenge(k), Mittelwerte(k),STD2(k));   
end 
fclose(fid2); 

%% Save apparent resistivities in Res2Dinv format 
Messpunkt1=[];
ElectrodeSpacing1=[];
nValue1=[];
Widerstand1= [];
for as= 1:length(Messpunkt)
    if Messgrenzeunten < Messpunkt(as) && Messgrenzeoben > Messpunkt(as)
        Messpunkt1(end+1)= Messpunkt(as);
        ElectrodeSpacing1(end+1)= ElectrodeSpacing(as);
        nValue1(end+1)=nValue(as);
        Widerstand1(end+1)=Widerstand(as);
    end
end
count= 0;
for ad=1:length(Messpunkt)
    if Messpunkt(ad) <Messgrenzeoben && Messpunkt(ad)>Messgrenzeunten
        count=Messpunkt(ad);
    end
end

%for x=1:length(count)
    %if Messpunkt(x) <Messgrenzeoben && Messpunkt(x)>Messgrenzeunten       
        mat = zeros(length(Messpunkt1),4); 
        mat(:,1) = Messpunkt1; 
        mat(:,2) = ElectrodeSpacing1; 
        mat(:,3)= nValue1;
        mat(:,4)=Widerstand1;
    %end
%end

B = sortrows(mat, 3);

% mat2 = zeros(22,4);
% c=0;
% for x=1:length(Messpunkt)
%     if Messpunkt(x) <Messgrenzeoben && Messpunkt(x)>Messgrenzeunten
%         c=c+1;
%         mat2(c,1) = Messpunkt(x); 
%         mat2(c,2) = ElectrodeSpacing(x); 
%         mat2(c,3)= nValue(x);
%         mat2(c,4)= Widerstand(x);
%     end
% end

        

fid3 = fopen(pfad2,'wt+'); 
    fprintf(fid3, '%s\n', 'Irgendein Text');
    fprintf(fid3, '%.2f\n',5);
    fprintf(fid3, '%u\n',3);
    fprintf(fid3, '%u\n', length(Messpunkt1));
    fprintf(fid3, '%u\n', 1);
    fprintf(fid3, '%g\t\n', 0);
for k=1:length(Messpunkt1)

    fprintf(fid3, '%f, %f,  %u,  %f\n', B(k,1),B(k,2), B(k,3), B(k,4));   
end 
fprintf(fid3, '%g\t\n', 0);
fprintf(fid3, '%g\t\n', 0);
fprintf(fid3, '%g\t\n', 0);
fprintf(fid3, '%g\t\n', 0);
fprintf(fid3, '%g\t\n', 0);
fprintf(fid3, '%g\t\n', 0);
fprintf(fid3, '%g\t\n', 0);
fclose(fid3); 
Messgrenzeunten
Messgrenzeoben
WasserWiderstand=mean(Wasserwiderstand)
