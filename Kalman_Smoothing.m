%% Kalman Smoothning
% Shail Jadav
% 28 July 2021
clear
close all
clc

%%  Data Read 
D=xlsread('data.csv');
s=D(:,5);
sf=kalSmooth(s');

%% Plot
f2=figure(1)
plot(s,'k')
hold on
plot(sf(75:end,1),'r','linewidth',2)
grid minor
legend('raw','filtered','fontsize',24,'interpreter','latex')
xlabel('Samples','fontsize',24,'interpreter','latex')
ylabel('Acceleration $\frac{m}{s^2}$ ','fontsize',24,'interpreter','latex')
orient(f2,'landscape')
print(f2,'-painters','-dpdf','-fillpage','Result')


%% Function
function [Data]= kalSmooth(s)
est=s(1); %Intial estimate
Eest=0.1; % Estimate variance
Emea=0.5; % Measurement variance
q=0.005;  % weighting term
for i=1:1:length(s)
    mea=s(1,i); % current measurement
    oest=est;   %previous estimate
    Kf= Eest/(Eest+Emea); % Kalman gain
    est=est + Kf*(mea-est); % update in estimate
    Eest=(1-Kf)*(Eest) + abs(oest-est)*q;  % update in estimate variance
    Data(i,:)=est;
end
end


