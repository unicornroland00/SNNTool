%   Train and Predict LSM(Least Square Method)

% For algorithm comparison with SNNs, the Least Square Method (LSM)  
% algorithm is exemplified and the related program is placed in the LSM.m.

close all;
clc;
%% Plant & Data
load '..\DataSet\DataBF.mat';
Mdata=TN;    %Mdata is the number of training data set
Pdata=PM;    %Mdata is the number of predict data set
ObjFun=6;   %Object function order number
eval(['Traindata=',['train',num2str(ObjFun)] ,';']);%Trainning data array
eval(['Predata=',['prect',num2str(ObjFun)] ,';']);  %Prective data array

%% Training process
tic;
La=polyfit(Traindata(:,1),Traindata(:,3),25);
T_epoch=toc;
        
%% Training error analysis
T_ts=tic;
for i=1:1:Mdata
    Traindata(i,4)=polyval(La,Traindata(i,1));%  
end
T_t=toc(T_ts);
Traindata(:,5)=Traindata(:,3)-Traindata(:,4);   %current error
TeM=mean(Traindata(:,5));                       %Mean:mean of the errors
TeRsm=sqrt(mean(Traindata(:,5).^2));            %RSM:root mean square of the errors
TeDev=std(Traindata(:,5), 0);                   %Dev:standard deviations of the errors.

 %% Predictive error analysis
T_ps=tic;
for i=1:1:Pdata
    Predata(i,4)=polyval(La,Predata(i,1));      %current output                
end         %the end of "i=1:1:Pdata"
T_p=toc(T_ps);
Predata(:,5)=Predata(:,3)-Predata(:,4);         %current error
PeM=mean(Predata(:,5));                         %Mean:mean of the errors
PeRsm=sqrt(mean(Predata(:,5).^2));              %RSM:root mean square of the errors
PeDev=std(Predata(:,5), 0);                     %Dev:standard deviations of the errors.
    
%% 
epochHist=[TeM TeRsm TeDev PeM PeRsm PeDev  T_epoch T_t  T_p];

%% Draw & Picture
figure(1);    
    Po=plot(Predata(:,1),Predata(:,3),'k');         %Object function curve 
    hold on;
    Pc=plot(Predata(:,1),Predata(:,4),'r');         %Current actual output curve
    hold on;
    Pe=plot(Predata(:,1),Predata(:,5),'b');         %Current error
    set(gca,'FontName','TimesNewRoman','FontWeight','bold','LineWidth',0.5,'color','white','fontsize',12);
                                                    %Legend
    L1=legend([Po,Pc,Pe],'Object','Actual','Error','Location','North');  
    set(L1,'Box','off','fontsize',12);
    
%% The end
