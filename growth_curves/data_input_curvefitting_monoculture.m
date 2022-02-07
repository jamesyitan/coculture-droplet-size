%%For growth curves in Figure 1c
%%and curvefitting code to get growth parameters in Figure 1d

%%This script utilizes normalized fluorescence data. Raw fluorescence data
%%and excel operations to normalize is available in the respective 
%%"<>_raw.xlsx" spreadsheet. To normalize data, the background is removed 
%%from S1 fluorescence due to excitation wavelengths slightly overlapping 
%%with emission wavelengths. Background is also different depending on the 
%%droplet size in the well. Background fluorescence for S1 is 129, 141, 
%%157, 168, and 180 for 55, 75, 100, 125, and 150 micron diameter droplets,
%%respectively.

%%import normalized fluorescence data (fluorescence@t/fluorescence@t=0)
%%Without normalization, the curves don't fit so well for the curve fitting
%%algorithm, and also provides a way to provide comparisons for curves with different carry capacities
%%S1 is the same as "sensor" and S2 is the same as "secretor". It is old
%%terminology from the Saleski et al. Metabolic Engineering (2019). paper.
[sensor,T_sensor,sensor_raw]=xlsread('monoculture_lambda5.xlsx');

time_green=sensor(:,1);
droplet_55_1=sensor(:,2);
droplet_55_2=sensor(:,3);
droplet_55_3=sensor(:,4);
droplet_55_4=sensor(:,5);
droplet_100_1=sensor(:,6);
droplet_100_2=sensor(:,7);
droplet_100_3=sensor(:,8);
droplet_100_4=sensor(:,9);
droplet_150_1=sensor(:,10);
droplet_150_2=sensor(:,11);
droplet_150_3=sensor(:,12);

%make figure with average growth curves (Fig 1c)
avg_plot_55 = plot(time_green/60,mean([droplet_55_1.';droplet_55_2.';droplet_55_3.';droplet_55_4.']));
hold on
avg_plot_100 = plot(time_green/60,mean([droplet_100_1.';droplet_100_2.';droplet_100_3.';droplet_100_4.']));
avg_plot_150 = plot(time_green/60,mean([droplet_150_1.';droplet_150_2.';droplet_150_3.']));

ylabel('Fluoresence_{t}/Fluorescence_{t=0}')
xlabel('Time (h)')
set(gca,'fontsize', 12);

%%Curvefitting
[fit_55um_1,gof_55um_1] = logistic_fit_with_lag(time_green, droplet_55_1);
[fit_55um_2,gof_55um_2] = logistic_fit_with_lag(time_green, droplet_55_2);
[fit_55um_3,gof_55um_3] = logistic_fit_with_lag(time_green, droplet_55_3);
[fit_55um_4,gof_55um_4] = logistic_fit_with_lag(time_green, droplet_55_4);

[fit_100um_1,gof_100um_1] = logistic_fit_with_lag(time_green, droplet_100_1);
[fit_100um_2,gof_100um_2] = logistic_fit_with_lag(time_green, droplet_100_2);
[fit_100um_3,gof_100um_3] = logistic_fit_with_lag(time_green, droplet_100_3);
[fit_100um_4,gof_100um_4] = logistic_fit_with_lag(time_green, droplet_100_4);

[fit_150um_1,gof_150um_1] = logistic_fit_with_lag(time_green, droplet_150_1);
[fit_150um_2,gof_150um_2] = logistic_fit_with_lag(time_green, droplet_150_2);
[fit_150um_3,gof_150um_3] = logistic_fit_with_lag(time_green, droplet_150_3);

%%compile data into summary matrix (first row is growth capacity, second is
%apparent maximum specific growth rate, third is lag time. Columns are
%different replicates/droplet conditions)
fit_summary = zeros(3,11);
fit_summary(:,1)=coeffvalues(fit_55um_1);
fit_summary(:,2)=coeffvalues(fit_55um_2);
fit_summary(:,3)=coeffvalues(fit_55um_3);
fit_summary(:,4)=coeffvalues(fit_55um_4);
fit_summary(:,5)=coeffvalues(fit_100um_1);
fit_summary(:,6)=coeffvalues(fit_100um_2);
fit_summary(:,7)=coeffvalues(fit_100um_3);
fit_summary(:,8)=coeffvalues(fit_100um_4);
fit_summary(:,9)=coeffvalues(fit_150um_1);
fit_summary(:,10)=coeffvalues(fit_150um_2);
fit_summary(:,11)=coeffvalues(fit_150um_3);

