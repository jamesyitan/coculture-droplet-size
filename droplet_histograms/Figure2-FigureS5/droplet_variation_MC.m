%This script generates the histograms in Figure 2 and Figure S5
%This is the main script that calls the sub-scripts to run the individual
%sections for each droplet size (55, 100, 150 um)

%run separate droplet sections to collect droplet data
dropletvariation_55um_MC_lambda5
dropletvariation_55um_MC_lambda20
dropletvariation_100um_MC_lambda5
dropletvariation_100um_MC_lambda20
dropletvariation_150um_MC_lambda5
dropletvariation_150um_MC_lambda20

%Generate histogram
bin_width = 0.25;
binedges = (0:bin_width:6);

subsample = min([length(intensity_tracker_55um_lambda5) length(intensity_tracker_55um_lambda20) length(intensity_tracker_100um_lambda5) length(intensity_tracker_100um_lambda20) length(intensity_tracker_150um_lambda5) length(intensity_tracker_150um_lambda20)]);
subsample_55_lambda5 = datasample(intensity_tracker_55um_lambda5,subsample,'Replace',false);
subsample_55_lambda20 = datasample(intensity_tracker_55um_lambda20,subsample,'Replace',false);
subsample_100_lambda5 = datasample(intensity_tracker_100um_lambda5,subsample,'Replace',false);
subsample_100_lambda20 = datasample(intensity_tracker_100um_lambda20,subsample,'Replace',false);
subsample_150_lambda5 = datasample(intensity_tracker_150um_lambda5,subsample,'Replace',false);
subsample_150_lambda20 = datasample(intensity_tracker_150um_lambda20,subsample,'Replace',false);

subplot(3,2,1);
histogram(subsample_55_lambda5,binedges,'FaceColor',[0 0.4470 0.7410])
hold on
ylim([0,50]);
subplot(3,2,3);
histogram(subsample_100_lambda5,binedges,'FaceColor',[0.6350 0.0780 0.1840])
hold on
ylim([0,50]);
subplot(3,2,5);
histogram(subsample_150_lambda5,binedges,'FaceColor',[0.9290 0.6940 0.1250])
hold on
ylim([0,50]);
subplot(3,2,2);
histogram(subsample_55_lambda20,binedges,'FaceColor',[0 0.4470 0.7410])
hold on
ylim([0,50]);
subplot(3,2,4);
histogram(subsample_100_lambda20,binedges,'FaceColor',[0.6350 0.0780 0.1840])
hold on
ylim([0,50]);
subplot(3,2,6);
histogram(subsample_150_lambda20,binedges,'FaceColor',[0.9290 0.6940 0.1250])
hold on
ylim([0,50]);
xlabel('Fluorescence normalized by droplet area')
ax = gca;
hold off

%Generate statistics
mean_55_lambda5 = mean(subsample_55_lambda5);
std_55_lambda5 = std(subsample_55_lambda5);
mean_100_lambda5 = mean(subsample_100_lambda5);
std_100_lambda5 = std(subsample_100_lambda5);
mean_150_lambda5 = mean(subsample_150_lambda5);
std_150_lambda5 = std(subsample_150_lambda5);

mean_55_lambda20 = mean(subsample_55_lambda20);
std_55_lambda20 = std(subsample_55_lambda20);
mean_100_lambda20 = mean(subsample_100_lambda20);
std_100_lambda20 = std(subsample_100_lambda20);
mean_150_lambda20 = mean(subsample_150_lambda20);
std_150_lambda20 = std(subsample_150_lambda20);