function [final_densities,timeseries] = calc_dynamics(n,K,mu_max,half_sat,alpha,beta,color,num_time_steps)
%calc_dynamics
%   Author: James Tan    Last Modified: May 18, 2020
%
%   Outputs: 
%   final_densities is a Sx1 vector with the final density of each arget
%       species at the end of the simulation.
%   timeseries is a matrix where each column of the first row is the 
%       timestep of the simulation and subsequent rows are the abundance of the
%       target species at each timestep. 

    % The function to numerically solve the set of coupled ordinary
    % differential equations defining the dynamics
    
    function [dndt] = dynamics(~,n) 
        dndt = zeros(4,1);
        mu = zeros(2,1);
        
        mu(1) = (mu_max(1) * n(3))/(half_sat(1)+n(3));
        mu(2) = (mu_max(2) * n(4))/(half_sat(2)+n(4));
        
            dndt(1) = mu(1)*n(1)*(1-(n(1)/K(1)));
            dndt(2) = mu(2)*n(2)*(1-(n(2)/K(2)));       
        
        dndt(3) = (alpha(2)*n(2))-(beta(1)*dndt(1));
        dndt(4) = (alpha(1)*n(1))-(beta(2)*dndt(2));
    end

%solve numerically
solution = ode45(@dynamics,[0 num_time_steps],n);

% filter the solution so there's just one density for each species per 
% timestep
y = [n deval(solution,1:num_time_steps)];
timeseries = [(0:num_time_steps)' y'];

final_densities = y(1:2,end);

% plot the simulated population densities
secretor = plot(0:num_time_steps, y(1,:),'LineStyle','--','LineWidth',2,'Color',color); % DisplayName
hold on
sensor = plot(0:num_time_steps, y(2,:),'LineStyle','-','LineWidth',2,'Color',color); % DisplayName

% set plot labels
xlabel('Time')
% ylabel('X_1,X_2,X_3')
%legend(species_names)

% % specify display
% set(h,{'color'},num2cell(colors,2));
% set(gca,'yscale','log');
% xlim([0 num_time_steps])

end