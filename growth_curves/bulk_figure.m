%%MATLAB script generating figure for Supplementary Figure 6 with
%%accompanying data "bulk.xlsx"

[OD,T_OD,OD_raw]=xlsread('bulk.xlsx');

time=OD(:,1);
iso_1=OD(:,5);
iso_2=OD(:,6);
iso_3=OD(:,7);
valleu_1=OD(:,8);
valleu_2=OD(:,9);
valleu_3=OD(:,10);
none_1=OD(:,2);
none_2=OD(:,3);
none_3=OD(:,4);

%%make figure with both growth curves
figure()
plot_iso1 = plot(time/60,iso_1);
hold on
plot_iso2 = plot(time/60,iso_2);
plot_iso3 = plot(time/60,iso_3);
plot_valleu1 = plot(time/60,valleu_1);
plot_valleu2 = plot(time/60,valleu_2);
plot_valleu3 = plot(time/60,valleu_3);
plot_none1 = plot(time/60,none_1);
plot_none2 = plot(time/60,none_2);
plot_none3 = plot(time/60,none_3);

set(plot_iso1, 'Color',[0 0.4470 0.7410]);
set(plot_iso2, 'Color',[0 0.4470 0.7410]);
set(plot_iso3, 'Color',[0 0.4470 0.7410]);
set(plot_valleu1, 'Color',[0.6350 0.0780 0.1840]);
set(plot_valleu2, 'Color',[0.6350 0.0780 0.1840]);
set(plot_valleu3, 'Color',[0.6350 0.0780 0.1840]);
set(plot_none1, 'Color',[0.9290 0.6940 0.1250]);
set(plot_none2, 'Color',[0.9290 0.6940 0.1250]);
set(plot_none3, 'Color',[0.9290 0.6940 0.1250]);

ylabel('OD_{600}')
xlabel('Time (h)')
set(gca,'fontsize', 12);
legend('+ isoleucine','+ isoleucine','+ isoleucine','+ valine + lysine','+ valine + lysine','+ valine + lysine','+ none','+ none','+ none')