%   Train and Predict SNNs
%   SNNs - Sampling Neural Networks
%
%   SNNTool V1.2
% 
%    Copyright 2023 Gang Cai and Lingyan Wu
% 
%    Licensed under the Apache License, Version 2.0 (the "License");
%    you may not use this file except in compliance with the License.
%    You may obtain a copy of the License at
% 
%        http://www.apache.org/licenses/LICENSE-2.0
%    
%    Unless required by applicable law or agreed to in writing, software
%    distributed under the License is distributed on an "AS IS" BASIS,
%    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%    See the License for the specific language governing permissions and
%    limitations under the License.
% 
%   Link:https://github.com/unicornroland00/SNNTool
%
%   This code was implemented based on the following paper:
% [1] G. Cai, L.Y. Wu, Sampling Neural Network: A Novel Neural Network Based on Sampling Theorem, 2021 6th International Symposium on Computer and Information Processing Technology (ISCIPT), (2021) 717-720. http://dx.doi.org/10.1109/ISCIPT53667.2021.00151.
% [2] G. Cai, L.Y. Wu, Cycle sampling neural network algorithms and applications, The Journal of Supercomputing, (2023). http://dx.doi.org/10.1007/s11227-022-05019-9.

close all;
clc;
addpath('.\scr');
%% Plant & Data
load '.\tutorials\DataBF.mat';
Mdata=TN;    %Mdata is the number of training data set
Pdata=PM;    %Pdata is the number of predict data set
ObjFun=6;    %Object function order number
             %ObjFun=6: alpinen1;
             %ObjFun=30:rastrigin;
             %ObjFun=36:shubert;
eval(['Traindata=',['train',num2str(ObjFun)] ,';']);%Trainning data array
eval(['Predata=',['prect',num2str(ObjFun)] ,';']);  %Prective data array

%% Initialization

Mepoch=10;      %Mepoch is the limit of epoch
N=25;           %N is the number of weights
Lr=0.001;       %Lr is the learning rate
SNN_type =2;    %SNN_type =0:SNN;     
                %SNN_type =1:CSNN;     
                %SNN_type =2:RSNN
Mc=2;           %Mc is the number of periodic extension for each side
if SNN_type ==0 
    Mc=0; end
                %Weights initialization value
W_init_value=0;
                %W_init_value=0:0 Initialization;     
                %W_init_value=Constant:Constant initialization;     
                %W_init_value='R':random initialization
                
                %W_init_Fun:Weights initialization function
W=SNN_W_init_Fun(W_init_value,N);

epsilon=0.001;  % The object of training error for each data
Ntrai=100;      % The limit of trail for each training data

                %The Parameters Array
Para=[SNN_type N Mc Lr epsilon Ntrai];


%% Training process
epoch=1;        %epoch initialization
T_epoch=[];     %Record of the training time results
epochHist=[];   %Record of the data analysis results

                %Scaled input from [0,1] to [1,N]
Traindata(:,1)=1+Traindata(:,1)*(N-1);
Predata(:,1)=1+Predata(:,1)*(N-1);

while epoch<=Mepoch
    disp(['epoch=' int2str(epoch) '次训练......']); 
    tic;        %Timer start
    for i=1:1:Mdata
                % traning data     
        x=Traindata(i,1);   %Normalized input in [1,N]
        y=Traindata(i,3);   %Normalized output in [0,1]   

                %Calculated function of Ci
        Ci=Ci_fun(x,Para);
                %training weights of SNNs
        W=SNN_Train(x,y, W, Ci ,Para );  
    end         %the end of "i=1:1:Mdata"
    T_ep=toc;               % toc:the end of Timer;
    T_epoch=[T_epoch;T_ep ];% Record 
    
    %% Training error analysis
    T_ts=tic;
    for i=1:1:Mdata
                % traning data     
        x=Traindata(i,1);   %Normalized input to [0,1]
%         y=Traindata(i,3);   %Normalized output        
%         x=1+x*(N-1);      %Scaled input to [1,N]
        
                %Calculated function of Ci
        Ci=Ci_fun(x,Para);
        Traindata(i,4)=W*Ci';                       %current output                
    end         %the end of "i=1:1:Mdata"
    T_t=toc(T_ts);
    Traindata(:,5)=Traindata(:,3)-Traindata(:,4);   %current error
    TeM=mean(Traindata(:,5));                       %Mean:mean of the errors
    TeRsm=sqrt(mean(Traindata(:,5).^2));            %RSM:root mean square of the errors
    TeDev=std(Traindata(:,5), 0);                   %Dev:standard deviations of the errors.
    
    %% Predictive error analysis
    T_ps=tic;
    for i=1:1:Pdata
                % traning data     
        x=Predata(i,1);   %Normalized input to [0,1]
%         y=Traindata(i,3);   %Normalized output        
%         x=1+x*(N-1);      %Scaled input to [1,N]
        
                %Calculated function of Ci
        Ci=Ci_fun(x,Para);
        Predata(i,4)=W*Ci';                         %current output                
    end         %the end of "i=1:1:Pdata"
    T_p=toc(T_ps);
    Predata(:,5)=Predata(:,3)-Predata(:,4);         %current error
    PeM=mean(Predata(:,5));                         %Mean:mean of the errors
    PeRsm=sqrt(mean(Predata(:,5).^2));              %RSM:root mean square of the errors
    PeDev=std(Predata(:,5), 0);                     %Dev:standard deviations of the errors.
    
    %% 
    
    epochHist=[epochHist; [epoch TeM TeRsm TeDev PeM PeRsm PeDev  T_ep T_t  T_p]];
    epoch=epoch+1;
end             %the end of "while epoch<=Mepoch"
T_ep=sum(T_epoch);
% T_epoch=[];
epochHist=[epochHist; [0 TeM TeRsm TeDev PeM PeRsm PeDev  T_ep T_t  T_p]];
%% Draw & Picture

Traindata(:,1)=(Traindata(:,1)-1)/(N-1);            %Scaled input from [1,N] to [0,1]
Predata(:,1)=(Predata(:,1)-1)/(N-1);
X_axis=0:1/(N-1):1;                                 %X-axis vector
figure(1);    
    Po=plot(Predata(:,1),Predata(:,3),'k');         %Object function curve 
    hold on;
    Pw=plot(X_axis,W,'k*');                         %The weights
    hold on;
    Pc=plot(Predata(:,1),Predata(:,4),'r');         %Current actual output curve
    hold on;
    Pe=plot(Predata(:,1),Predata(:,5),'b');         %Current error
    set(gca,'FontName','TimesNewRoman','FontWeight','bold','LineWidth',0.5,'color','white','fontsize',12);
                                                    %Legend
    L1=legend([Po,Pc,Pe,Pw],'Object','Actual','Error','Weights','Location','North');  
    set(L1,'Box','off','fontsize',12);
    
%% The end