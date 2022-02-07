%%This is the main script to run the crossfeeding simulation used to generate Fig S10. It calls on
%%calc_dynamics_concentration to run the ODE and then logistic_fit_combined to fit the
%%generated curves to the logistic curve

%%set lambda
num_cells = 5;

%%for 55 um diameter (volume dilution of 1)
%%set initial community abundances n(1:2)
%%set initial concentrations of cross-fed molecules n(3:4)
n = zeros(4,1);
n(1) = num_cells/1;
n(2) = num_cells/1;
n(3) = 0;
n(4) = 0;

%%define growth (mu) and death rates for simplest case (in future when
%%expanding for more than 3 species, we would write a more systematic way of defining these)
K = zeros(2,1);
K(1) = 100;
K(2) = 100;

%%set max growth rate
mu_max = zeros(2,1);
mu_max(1) = 1;
mu_max(2) = 1;

%%set half saturation rate of growth
%%for the same E.coli base strain on amino acids, would imagine it to be similar
half_sat = zeros(2,1);
half_sat(1) = 0.1;
half_sat(2) = 0.1;

%%set auxotroph export rate of metabolites
%%S1(index 1) as a lysine-exporter (sensor) and S2 as a isoleucine-exporter
%%(secretor) (index2)
%%two extremes to test: 0.1 (> half-sat) or 0.001 (=half-sat) or 0.00001 (< half-sat)
alpha = zeros(2,1);
alpha(1) = 0.01;
alpha(2) = 0.01;

%%set cellular requirement of essential metabolites (unit: mass/OD). Set to
%%be X0.1 of alpha. Simulation is not too sensitive to the magnitude of
%%beta
beta = zeros(2,1);
beta(1) = 0.001;
beta(2) = 0.001;

%%set number of timesteps for first iteration
timesteps = 350;

color = [0 0.4470 0.7410];

[final_density, growth_profile] = calc_dynamics_concentration(n,K,mu_max,half_sat,alpha,beta,color,timesteps);
time = growth_profile(:,1);
S1 = growth_profile(:,2);
S2 = growth_profile(:,3);

%%for 100 um diameter (volume dilution of 1)
%%set initial community abundances n(1:2)
n = zeros(4,1);
n(1) = num_cells/6;
n(2) = num_cells/6;

color = [0.6350 0.0780 0.1840];

[final_density_dilution, growth_profile_dilution] = calc_dynamics_concentration(n,K,mu_max,half_sat,alpha,beta,color,timesteps);
time = growth_profile_dilution(:,1);
S1_dilution = growth_profile_dilution(:,2);
S2_dilution = growth_profile_dilution(:,3);

%%for 100 um diameter (volume dilution of 1)
%%set initial community abundances n(1:2)
n = zeros(4,1);
n(1) = num_cells/20;
n(2) = num_cells/20;

color = [0.9290 0.6940 0.1250];

[final_density_dilution2, growth_profile_dilution2] = calc_dynamics_concentration(n,K,mu_max,half_sat,alpha,beta,color,timesteps);
time = growth_profile_dilution2(:,1);
S1_dilution2 = growth_profile_dilution2(:,2);
S2_dilution2 = growth_profile_dilution2(:,3);

% plot S1 curves
S1_norm = S1/5;
S1_dilution_norm = S1_dilution/(5/6);
S1_dilution2_norm = S1_dilution2/(5/20);

plot(0:timesteps, S1_norm,'LineStyle','-','LineWidth',2,'Color',[0 0.4470 0.7410])
hold on
plot(0:timesteps, S1_dilution_norm,'LineStyle','-','LineWidth',2,'Color',[0.6350 0.0780 0.1840])
plot(0:timesteps, S1_dilution2_norm,'LineStyle','-','LineWidth',2,'Color',[0.9290 0.6940 0.1250])

% [fitresult1, gof1, fitresult2, gof2, fitresult3, gof3] = logistic_fit_combined(time, S1_norm, S1_dilution_norm, S1_dilution2_norm);
xlabel('time')
ylabel('normalized growth')
hold off

% plot S2 curves

S2_norm = S2/5;
S2_dilution_norm = S2_dilution/(5/6);
S2_dilution2_norm = S2_dilution2/(5/20);

% figure()
% plot(0:timesteps, S2_norm,'LineStyle','-','LineWidth',2,'Color',[0 0.4470 0.7410])
% hold on
% plot(0:timesteps, S2_dilution_norm,'LineStyle','-','LineWidth',2,'Color',[0.6350 0.0780 0.1840])
% plot(0:timesteps, S2_dilution2_norm,'LineStyle','-','LineWidth',2,'Color',[0.9290 0.6940 0.1250])

% [fitresult4, gof4, fitresult5, gof5, fitresult6, gof6] = logistic_fit_combined(time, S2_norm, S2_dilution_norm, S2_dilution2_norm);
% xlabel('time')
% ylabel('normalized growth')