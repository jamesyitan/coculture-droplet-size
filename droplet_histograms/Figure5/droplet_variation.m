%This script generates the histograms in Figure 5c
%This is the main script that calls the sub-scripts to run the individual
%sections for each droplet size (55, 100, 150 um)

%run separate droplet sections to collect droplet data
dropletvariation_55um
dropletvariation_100um
dropletvariation_150um

%Generate histogram
binedges = [0:5:140];

subsample = min([length(intensity_tracker_55um) length(intensity_tracker_100um) length(intensity_tracker_150um)]);
subsample_55 = datasample(intensity_tracker_55um,subsample,'Replace',false);
subsample_100 = datasample(intensity_tracker_100um,subsample,'Replace',false);
subsample_150 = datasample(intensity_tracker_150um,subsample,'Replace',false);

subplot(3,1,1);
histogram(subsample_55,binedges,'FaceColor',[0 0.4470 0.7410])
hold on
ylim([0,80]);
subplot(3,1,2);
histogram(subsample_100,binedges,'FaceColor',[0.6350 0.0780 0.1840])
hold on
ylim([0,80]);
subplot(3,1,3);
histogram(subsample_150,binedges,'FaceColor',[0.9290 0.6940 0.1250])
hold on
ylim([0,80]);
xlabel('Fluorescence normalized by droplet area')
ax = gca;
hold off

%Generate statistics
mean_55 = mean(subsample_55);
std_55 = std(subsample_55);
mean_100 = mean(subsample_100);
std_100 = std(subsample_100);
mean_150 = mean(subsample_150);
std_150 = std(subsample_150);