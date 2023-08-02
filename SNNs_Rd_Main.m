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
%% Plant & Data
Mdata=1000;    %Mdata is the number of training data
Pdata=100;      %Pdata is the number of predict data set
TT=10;         %Test interval
%% Initialization
N=25;           %N is the number of weights
Lr=0.1;         %Lr is the learning rate
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

T_epoch=[];     %Record of the training time results
epochHist=[];   %Record of the data analysis results

for m=0:1:Mdata
    %% ________________________________________
                %traning data     
    x=rand();                               %random input in [0,1]
    y=sinc(5*x);                            %Plant and output
                %add noise
%     x=(1+0.1*(rand()-0.5))*x;
%     y=(1+0.1*(rand()-0.5))*y;

    x=1+(N-1)*x;                            %Normalized input to [1,N]
    
    %% ________________________________________
                
    tic;        %Timer start
                %Calculated function of Ci
    Ci=Ci_fun(x,Para);
                %training weights of SNNs
    W=SNN_Train(x,y, W, Ci ,Para );              
                    
    T_epoch=[T_epoch;toc];                  %toc:the end of Timer; Record 
    
    %% Predictive error analysis
    if mod(m,TT)==0
        disp(['m=' int2str(m) ' data is trained.']); 
        Predata=zeros(Pdata,5);                         %the array for record
        T_ps=tic;
        for i=1:1:Pdata
    %% ________________________________________            
                    % test data
            x=i/Pdata;                                  %current input
            Predata(i,1)=x;                             
            y=sinc(5*x);                                %expected output
            Predata(i,3)=y;                             
            x=1+(N-1)*x;                                %Normalized input to [1,N]
            
    %         Predata(i,2)=x;
    %% ________________________________________
                    %Calculated function of Ci
            Ci=Ci_fun(x,Para);       

            Predata(i,4)=W*Ci';                         %current output                
        end         %the end of "i=1:1:Pdata"
        T_p=toc(T_ps);
        Predata(:,5)=Predata(:,3)-Predata(:,4);         %current error
        PeM=abs(mean(Predata(:,5)));                    %Ave:mean of the errors
        PeRsm=sqrt(mean(Predata(:,5).^2));              %Rsm:root mean square of the errors
        PeDev=std(Predata(:,5), 0);                     %Dev:standard deviations of the errors.

%         T_ep=mean(T_epoch);
%         T_epoch=[];
        epochHist=[epochHist; [m  PeM PeRsm PeDev ]];
        
    end             %the end of " if mod(m,TT)==0"
end                 %the end of "for m=1:1:Mdata"

%% Draw & Picture

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
figure(2);
    PA=semilogy(epochHist(:,1),epochHist(:,2),'g'); %Ave 
    hold on;
    PR=semilogy(epochHist(:,1),epochHist(:,3),'r'); %Rsm 
    hold on;
    PD=semilogy(epochHist(:,1),epochHist(:,4),'b'); %Dev 
    
    xlabel('Training data');                        %Axes
    axis([0 Mdata,-inf,inf]);
    
    yyaxis right;
    PT=semilogy(T_epoch);                           %Time
    ylabel('Time(s)');   
    set(gca,'FontName','TimesNewRoman','FontWeight','bold','LineWidth',0.5,'color','white','fontsize',12);
                                                    %Legend
    L1=legend([PA,PR,PD,PT],'Ave','Rsm','Dev','Time','Location','NorthEast','Orientation','horizon');  
    set(L1,'Box','off','fontsize',12);
%% The end