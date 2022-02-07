%%For growth curves in Figure 4c
%%and curvefitting code to get growth parameters in Figure 4d

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
[sensor_valleu,T_sensor_valleu,sensor_valleu_raw]=xlsread('valine+leucine_norm_new.xlsx','S1');
[secretor_valleu,T_secretor_valleu,secretor_valleu_raw]=xlsread('valine+leucine_norm_new.xlsx','S2');

time_green=sensor_valleu(:,1);
droplet_55_1=sensor_valleu(:,2);
droplet_55_2=sensor_valleu(:,3);
droplet_55_3=sensor_valleu(:,4);
droplet_55_4=sensor_valleu(:,5);
droplet_75_1=sensor_valleu(:,6);
droplet_75_2=sensor_valleu(:,7);
droplet_75_3=sensor_valleu(:,8);
droplet_75_4=sensor_valleu(:,9);
droplet_100_1=sensor_valleu(:,10);
droplet_100_2=sensor_valleu(:,11);
droplet_100_3=sensor_valleu(:,12);
droplet_100_4=sensor_valleu(:,13);
droplet_125_1=sensor_valleu(:,14);
droplet_125_2=sensor_valleu(:,15);
droplet_125_3=sensor_valleu(:,16);
droplet_125_4=sensor_valleu(:,17);
droplet_150_1=sensor_valleu(:,18);
droplet_150_2=sensor_valleu(:,19);
droplet_150_3=sensor_valleu(:,20);
droplet_150_4=sensor_valleu(:,21);

time_red=secretor_valleu(:,1);
red_droplet_55_1=secretor_valleu(:,2);
red_droplet_55_2=secretor_valleu(:,3);
red_droplet_55_3=secretor_valleu(:,4);
red_droplet_55_4=secretor_valleu(:,5);
red_droplet_75_1=secretor_valleu(:,6);
red_droplet_75_2=secretor_valleu(:,7);
red_droplet_75_3=secretor_valleu(:,8);
red_droplet_75_4=secretor_valleu(:,9);
red_droplet_100_1=secretor_valleu(:,10);
red_droplet_100_2=secretor_valleu(:,11);
red_droplet_100_3=secretor_valleu(:,12);
red_droplet_100_4=secretor_valleu(:,13);
red_droplet_125_1=secretor_valleu(:,14);
red_droplet_125_2=secretor_valleu(:,15);
red_droplet_125_3=secretor_valleu(:,16);
red_droplet_125_4=secretor_valleu(:,17);
red_droplet_150_1=secretor_valleu(:,18);
red_droplet_150_2=secretor_valleu(:,19);
red_droplet_150_3=secretor_valleu(:,20);
red_droplet_150_4=secretor_valleu(:,21);

%make figures with average growth curves (Figure 4c)
%for S1
avg_plot_55 = plot(time_green/60,mean([droplet_55_1.';droplet_55_2.';droplet_55_3.';droplet_55_4.']));
hold on
avg_plot_100 = plot(time_green/60,mean([droplet_100_1.';droplet_100_2.';droplet_100_3.';droplet_100_4.']));
avg_plot_150 = plot(time_green/60,mean([droplet_150_1.';droplet_150_2.';droplet_150_3.']));
set(avg_plot_55, 'Color',[0 0.4470 0.7410]);
set(avg_plot_100, 'Color',[0.6350 0.0780 0.1840]);
set(avg_plot_150, 'Color',[0.9290 0.6940 0.1250]);
%for S2
plot_55_red = plot(time_red/60,mean([red_droplet_55_1.';red_droplet_55_2.';red_droplet_55_3.';red_droplet_55_4.']),':');
plot_100_red = plot(time_red/60,mean([red_droplet_100_1.';red_droplet_100_2.';red_droplet_100_3.';red_droplet_100_4.']),':');
plot_150_red = plot(time_red/60,mean([red_droplet_150_1.';red_droplet_150_2.';red_droplet_150_4.']),':');
set(plot_55_red, 'Color',[0 0.4470 0.7410]);
set(plot_100_red, 'Color',[0.6350 0.0780 0.1840]);
set(plot_150_red, 'Color',[0.9290 0.6940 0.1250]);
ylabel('Fluoresence_{t}/Fluorescence_{t=0}')
xlabel('Time (h)')
set(gca,'fontsize', 12);
legend('55 um S1','100 um S1','150 um S1','55 um S2','100 um S2','150 um S2')
set(plot_55_red, 'Color',[0 0.4470 0.7410]);
set(plot_100_red, 'Color',[0.6350 0.0780 0.1840]);
set(plot_150_red, 'Color',[0.9290 0.6940 0.1250]);
hold off

%%Curvefitting code: this is specifically for S1, but switch variables to
%%red for S2
%%Maybe need to change parameters (specifically, initial values - line 25
%%in "logistic_fit_with_lag.m" to get all curves to satisfy a good looking
%%curve fit. Confirm with graphs to ensure curves fit well.
[fit_55um_1,gof_55um_1] = logistic_fit_with_lag(time_green, droplet_55_1);
[fit_55um_2,gof_55um_2] = logistic_fit_with_lag(time_green, droplet_55_2);
[fit_55um_3,gof_55um_3] = logistic_fit_with_lag(time_green, droplet_55_3);
[fit_55um_4,gof_55um_4] = logistic_fit_with_lag(time_green, droplet_55_4);

[fit_75um_1,gof_75um_1] = logistic_fit_with_lag(time_green, droplet_75_1);
[fit_75um_2,gof_75um_2] = logistic_fit_with_lag(time_green, droplet_75_2);
[fit_75um_3,gof_75um_3] = logistic_fit_with_lag(time_green, droplet_75_3);
[fit_75um_4,gof_75um_4] = logistic_fit_with_lag(time_green, droplet_75_4);

[fit_100um_1,gof_100um_1] = logistic_fit_with_lag(time_green, droplet_100_1);
[fit_100um_2,gof_100um_2] = logistic_fit_with_lag(time_green, droplet_100_2);
[fit_100um_3,gof_100um_3] = logistic_fit_with_lag(time_green, droplet_100_3);
[fit_100um_4,gof_100um_4] = logistic_fit_with_lag(time_green, droplet_100_4);

[fit_125um_1,gof_125um_1] = logistic_fit_with_lag(time_green, droplet_125_1);
[fit_125um_2,gof_125um_2] = logistic_fit_with_lag(time_green, droplet_125_2);
[fit_125um_3,gof_125um_3] = logistic_fit_with_lag(time_green, droplet_125_3);
[fit_125um_4,gof_125um_4] = logistic_fit_with_lag(time_green, droplet_125_4);

[fit_150um_1,gof_150um_1] = logistic_fit_with_lag(time_green, droplet_150_1);
[fit_150um_2,gof_150um_2] = logistic_fit_with_lag(time_green, droplet_150_2);
[fit_150um_3,gof_150um_3] = logistic_fit_with_lag(time_green, droplet_150_3);
[fit_150um_4,gof_150um_4] = logistic_fit_with_lag(time_green, droplet_150_4);

%compile data into summary matrix (first row is growth capacity, second is
%apparent maximum specific growth rate, third is lag time. Columns are
%different replicates/droplet conditions)
fit_summary = zeros(3,20);
fit_summary(:,1)=coeffvalues(fit_55um_1);
fit_summary(:,2)=coeffvalues(fit_55um_2);
fit_summary(:,3)=coeffvalues(fit_55um_3);
fit_summary(:,4)=coeffvalues(fit_55um_4);
fit_summary(:,5)=coeffvalues(fit_75um_1);
fit_summary(:,6)=coeffvalues(fit_75um_2);
fit_summary(:,7)=coeffvalues(fit_75um_3);
fit_summary(:,8)=coeffvalues(fit_75um_4);
fit_summary(:,9)=coeffvalues(fit_100um_1);
fit_summary(:,10)=coeffvalues(fit_100um_2);
fit_summary(:,11)=coeffvalues(fit_100um_3);
fit_summary(:,12)=coeffvalues(fit_100um_4);
fit_summary(:,13)=coeffvalues(fit_125um_1);
fit_summary(:,14)=coeffvalues(fit_125um_2);
fit_summary(:,15)=coeffvalues(fit_125um_3);
fit_summary(:,16)=coeffvalues(fit_125um_4);
fit_summary(:,17)=coeffvalues(fit_150um_1);
fit_summary(:,18)=coeffvalues(fit_150um_2);
fit_summary(:,19)=coeffvalues(fit_150um_3);
fit_summary(:,20)=coeffvalues(fit_150um_4);