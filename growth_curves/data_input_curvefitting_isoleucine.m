%%For growth curves in Figure 3c
%%and curvefitting code to get growth parameters in Figure 3d

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
[sensor_ile,T_sensor_ile,sensor_ile_raw]=xlsread('isoleucine_norm.xlsx','sensor');
[secretor_ile,T_secretor_ile,secretor_ilv_raw]=xlsread('isoleucine_norm.xlsx','secretor');

time_green=sensor_ile(:,1);
droplet_55_1=sensor_ile(:,2);
droplet_55_2=sensor_ile(:,3);
droplet_55_3=sensor_ile(:,4);
droplet_55_4=sensor_ile(:,5);
droplet_75_1=sensor_ile(:,6);
droplet_75_2=sensor_ile(:,7);
droplet_75_3=sensor_ile(:,8);
droplet_75_4=sensor_ile(:,9);
droplet_100_1=sensor_ile(:,10);
droplet_100_2=sensor_ile(:,11);
droplet_100_3=sensor_ile(:,12);
droplet_100_4=sensor_ile(:,13);
droplet_125_1=sensor_ile(:,14);
droplet_125_2=sensor_ile(:,15);
droplet_125_3=sensor_ile(:,16);
droplet_125_4=sensor_ile(:,17);
droplet_150_1=sensor_ile(:,18);
droplet_150_2=sensor_ile(:,19);
droplet_150_3=sensor_ile(:,20);

time_red=secretor_ile(:,1);
red_droplet_55_1=secretor_ile(:,2);
red_droplet_55_2=secretor_ile(:,3);
red_droplet_55_3=secretor_ile(:,4);
red_droplet_55_4=secretor_ile(:,5);
red_droplet_75_1=secretor_ile(:,6);
red_droplet_75_2=secretor_ile(:,7);
red_droplet_75_3=secretor_ile(:,8);
red_droplet_75_4=secretor_ile(:,9);
red_droplet_100_1=secretor_ile(:,10);
red_droplet_100_2=secretor_ile(:,11);
red_droplet_100_3=secretor_ile(:,12);
red_droplet_100_4=secretor_ile(:,13);
red_droplet_125_1=secretor_ile(:,14);
red_droplet_125_2=secretor_ile(:,15);
red_droplet_125_3=secretor_ile(:,16);
red_droplet_125_4=secretor_ile(:,17);
red_droplet_150_1=secretor_ile(:,18);
red_droplet_150_2=secretor_ile(:,19);
red_droplet_150_3=secretor_ile(:,20);

%make figures with average growth curves (Figure 3c)
%for S1
avg_plot_55 = plot(time_green/60,mean([droplet_55_1.';droplet_55_2.';droplet_55_3.';droplet_55_4.']));
hold on
avg_plot_100 = plot(time_green/60,mean([droplet_100_1.';droplet_100_2.';droplet_100_3.';droplet_100_4.']));
avg_plot_150 = plot(time_green/60,mean([droplet_150_1.';droplet_150_2.';droplet_150_3.']));
ylabel('Fluoresence_{t}/Fluorescence_{t=0}')
xlabel('Time (h)')
set(gca,'fontsize', 12);
legend('55 um S1','100 um S1','150 um S1')
hold off
%for S2
figure()
plot_55_red = plot(time_red/60,mean([red_droplet_55_1.';red_droplet_55_2.';red_droplet_55_3.';red_droplet_55_4.']),':');
hold on
plot_100_red = plot(time_red/60,mean([red_droplet_100_1.';red_droplet_100_2.';red_droplet_100_3.';red_droplet_100_4.']),':');
plot_150_red = plot(time_red/60,mean([red_droplet_150_1.';red_droplet_150_2.';red_droplet_150_3.']),':');
set(plot_55_red, 'Color',[0 0.4470 0.7410]);
set(plot_100_red, 'Color',[0.6350 0.0780 0.1840]);
set(plot_150_red, 'Color',[0.9290 0.6940 0.1250]);
ylabel('Fluoresence_{t}/Fluorescence_{t=0}')
xlabel('Time (h)')
set(gca,'fontsize', 12);
legend('55 um S2','100 um S2','150 um S2')
hold off

%%Curvefitting code: this is specifically for S1, but switch variables to
%%red for S2
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