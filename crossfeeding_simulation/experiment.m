%%This is the main script to run the crossfeeding simulation. It calls on
%%calc_dynamics to run the ODE and then logistic_fit_combined to fit the
%%generated curves to the logistic curve

%%set initial community abundances n(1:2)
%%set initial concentrations of cross-fed molecules n(3:4)
n = zeros(4,1);
n(1) = 0.1;
n(2) = 0.1;
n(3) = 0;
n(4) = 0;

%%define growth (mu) and death rates for simplest case (in future when
%%expanding for more than 3 species, we would write a more systematic way of defining these)
K = zeros(2,1);
K(1) = 1;
K(2) = 1;

%%set max growth rate
mu_max = zeros(2,1);
mu_max(1) = 0.4;
mu_max(2) = 0.4;

%%set half saturation rate of growth
%%for the same E.coli base strain on amino acids, would imagine it to be similar
half_sat = zeros(2,1);
half_sat(1) = 4;
half_sat(2) = 4;

%%set auxotroph export rate of metabolites
%%S1(index 1) as a lysine-exporter (sensor) and S2 as a isoleucine-exporter
%%(secretor) (index2)
%%isoleucine is more biosynthetically expensive
alpha = zeros(2,1);
alpha(1) = 50;
alpha(2) = 50;

%%set cellular requirement of essential metabolites (unit: mass/OD
beta = zeros(2,1);
beta(1) = 100;
beta(2) = 100;

%%set number of timesteps for first iteration
timesteps = 50;

color = [0 0.4470 0.7410];

[final_density, growth_profile] = calc_dynamics(n,K,mu_max,half_sat,alpha,beta,color,timesteps);
time = growth_profile(:,1);
S1 = growth_profile(:,2);
S2 = growth_profile(:,3);

%%set cellular requirement of essential metabolites (unit: mass/OD)
beta2 = zeros(2,1);
beta2(1) = 300;
beta2(2) = 300;
alpha2 = zeros(2,1);
alpha2(1) = 50;
alpha2(2) = 50;

color = [0.6350 0.0780 0.1840];

[final_density, growth_profile] = calc_dynamics(n,K,mu_max,half_sat,alpha2,beta2,color,timesteps);
time2 = growth_profile(:,1);
S1_2 = growth_profile(:,2);
S2_2 = growth_profile(:,3);

%%set cellular requirement of essential metabolites (unit: mass/OD
beta3 = zeros(2,1);
beta3(1) = 500;
beta3(2) = 500;
alpha3 = zeros(2,1);
alpha3(1) = 50;
alpha3(2) = 50;

color = [0.9290 0.6940 0.1250];

[final_density, growth_profile] = calc_dynamics(n,K,mu_max,half_sat,alpha3,beta3,color,timesteps);
time3 = growth_profile(:,1);
S1_3 = growth_profile(:,2);
S2_3 = growth_profile(:,3);

[fitresult1, gof1, fitresult2, gof2, fitresult3, gof3] = logistic_fit_combined(time, S1, S1_2, S1_3);

ylim([0 1])
ylabel('OD')
% legend({'\beta=100 - Secretor','\beta=100 - Sensor','\beta=300 - Secretor','\beta=300 - Sensor','\beta=500 - Secretor','\beta=500 - Sensor'})
% legend({'\alpha X 1 - Secretor','\alpha X 1 - Sensor','\alpha X 0.5 - Secretor','\alpha X 0.5 - Sensor','\alpha X 0.2 - Secretor','\alpha X 0.2 - Sensor'})