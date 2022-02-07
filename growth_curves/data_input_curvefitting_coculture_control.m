%%For Figure S9

%%This script utilizes normalized fluorescence data. Raw fluorescence data
%%and excel operations to normalize is available in the respective 
%%spreadsheet. To normalize data, the background is removed 
%%from S1 fluorescence due to excitation wavelengths slightly overlapping 
%%with emission wavelengths. Background is also different depending on the 
%%droplet size in the well. Background fluorescence for S1 is 140, 156, 
%%164 for 55, 100, and 150 micron diameter droplets, respectively. These
%%background values differ from other background values in different
%%experiments because this experiment was done for a series of revision
%%experiments that used a different plate reader of the same model as the
%%others (BioTek Synergy H1).

%%import normalized fluorescence points (fluorescence@t/fluorescence@t=0)
%%without normalization, the curves don't fit so well for the curve fitting
%%algorith, also provides a way to provide comparisons in carry capacities

%%used normal logistic curve without lag consideration since lag times were
%%intially calculated to be negligible
%%S1 is the same as "sensor" and S2 is the same as "secretor". It is old
%%terminology from the Saleski et al. Metabolic Engineering (2019). paper.
[sensor,T_sensor,sensor_raw]=xlsread('coculture_control.xlsx','S1_norm');

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
droplet_150_4=sensor(:,13);

%%Curvefitting code
[fit_55um_1,gof_55um_1] = logistic_fit(time_green, droplet_55_1);
[fit_55um_2,gof_55um_2] = logistic_fit(time_green, droplet_55_2);
[fit_55um_3,gof_55um_3] = logistic_fit(time_green, droplet_55_3);
[fit_55um_4,gof_55um_4] = logistic_fit(time_green, droplet_55_4);

[fit_100um_1,gof_100um_1] = logistic_fit(time_green, droplet_100_1);
[fit_100um_2,gof_100um_2] = logistic_fit(time_green, droplet_100_2);
[fit_100um_3,gof_100um_3] = logistic_fit(time_green, droplet_100_3);
[fit_100um_4,gof_100um_4] = logistic_fit(time_green, droplet_100_4);

[fit_150um_1,gof_150um_1] = logistic_fit(time_green, droplet_150_1);
[fit_150um_2,gof_150um_2] = logistic_fit(time_green, droplet_150_2);
[fit_150um_3,gof_150um_3] = logistic_fit(time_green, droplet_150_3);
[fit_150um_4,gof_150um_4] = logistic_fit(time_green, droplet_150_4);

%compile data into summary matrix (first row is growth capacity, second is
%apparent maximum specific growth rate, third is lag time. Columns are
%different replicates/droplet conditions)
fit_summary = zeros(2,12);
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
fit_summary(:,12)=coeffvalues(fit_150um_4);

%make figures with average growth curves (Figure S)
avg_plot_55 = plot(time_green/60,mean([droplet_55_1.';droplet_55_2.';droplet_55_3.';droplet_55_4.']));
hold on
avg_plot_100 = plot(time_green/60,mean([droplet_100_1.';droplet_100_2.';droplet_100_3.';droplet_100_4.']));
avg_plot_150 = plot(time_green/60,mean([droplet_150_1.';droplet_150_2.';droplet_150_3.';droplet_150_4.']));
ylabel('Fluoresence_{t}/Fluorescence_{t=0}')
xlabel('Time (h)')
set(gca,'fontsize', 12);
legend('55 um S1','100 um S1','150 um S1')
hold off
