function rhoa = VES1dmod(rho,t,s,ary)
    % VES1dmod computes the apparent resistivity rhoa (Ohm.m) for the
    % resistivity model given by the layer resistivities rho (Ohm.mm), 
    % the layer thicknesses t (m), and the array length scale s (m).
    % Based on the VES1dmod foward model by Ekinci and Demirci (2008).
    %
    % Matthias Buecker, May 2019
    
    % Choose filter parameters depending on array type (currently
    % Schlumberger or dipole-dipole)
    switch ary
        case 'sch'                  % Schlumberger sounding
            psi = 4.438;           	% Sampling rate
            indmin = -2;           	% First filter index
            indmax = 10;           	% Last filter index
            % Digital filter coefficients
            f = [225, 336, 2525, 8183, 16448, -27841, 13396, -4390,...
                1605, -746, 416, -262, 105]/10000;
        case 'dd'                   % Dipole-dipole sounding
            psi = 3.934;           	% Sampling rate
            indmin = -1;           	% First filter index
            indmax = 10;           	% Last filter index
            % Digital filter coefficients
            f = [-1170, 1439, -4684, 47818, -50088, 22818, -8736, 3952,...
                -2157, 1341, -911, 378]/10000;
    end    
    ind = indmin:indmax;                % Wave number indeces
    
    % Loop over array lenghts s
    rhoa = s*0;                         % Initialize apparent resistivity
    for ss = 1:length(s)
        lambda = 1/s(ss)*exp(ind*log(10)/psi);  % Discrete wave numbers (1/m)

        % Compute resistivity transform using Pekeris recurrence relation
        % (e.g., Koefoed, 1979)
        T = f*0;                        % Initialize resistivity transform
        for jj = 1:length(ind)          % Loop over reciprocal lenths
            Ti = rho(end);              % Resistivity of last layer
            ii = length(rho);           % Start with last layer
            while ii>1                  % Loop over layers
                ii = ii-1;
                aa = tanh(t(ii)*lambda(jj));
                Ti = (Ti+rho(ii)*aa)/(1+Ti*aa/rho(ii));
            end
            T(jj) = Ti;                	% Resistivity transform
        end

        % Apply filter to compute apparent resistivities
        rhoa(ss) = f*T';
    end
    