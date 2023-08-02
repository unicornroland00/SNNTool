% Generate the training dataset and predictive dataset for benchmarks function

%_________________________________________________________________________________
% # BenchmarkFcns
% Benchmarkfcns is an effort to provide a public and free repository of sources 
% and documents for well-known benchmark optimization functions. 
% Copyright (c) 2016 mazhar-ansari-ardeh
% With The MIT License (MIT)
% Please also check the project website at: 
% [benchmarkfcns.xyz](http://benchmarkfcns.xyz) 
% or (https://github.com/mazhar-ansari-ardeh/Benchmarks)
% which contains comprehensive documents for each function. 
% 
% # How to install
% To install and use this library, it is just required to add the project 
% folders to MATLAB's path. 
% For example, to use the functions in the 'benchmarks' folder, just navigate 
% to this folder with MATLAB's directory explorer or use the command `addpath` 
% with path to the folder on your PC (e.g. `addpath /path/to/benchmarks`).
%_________________________________________________________________________________

clear all;
clc;
                        %add path of benchmarks functions
addpath('..\..\BenchmarkFcns\benchmarks');

TN=1000;                %The number of training data set
PM=1000;                %The number of predictive data set
data=zeros(TN,3);       %The temp data set
%% Generate the training dataset
% OB=30:1:30;
OB=1:1:44;
for ObjFun=OB
    for i=1:1:TN    
                        % input
        x1=rand();
        x=[x1 0.5];
                        % choose benchmarks function
        switch(ObjFun)
            case 1
               x=x*10-5;scores = ackleyfcn(x);
            case 2
               x=x*10-5;scores = ackleyn2fcn(x);
            case 3
               x=x*10-5;scores = ackleyn3fcn(x);
            case 4
               x=x*10-5;scores = ackleyn4fcn(x);
            case 5
               x=x*10-5;scores = adjimanfcn(x);
            case 6
               x=x*10-5;scores = alpinen1fcn(x);
            case 7
               x=x*10-5;scores = bartelsconnfcn(x);
            case 8
               x=x*10-5;scores = birdfcn(x);
            case 9
               x=x*10-5;scores = bohachevskyn1fcn(x);
            case 10
               x=x*10-5;scores = bohachevskyn2fcn(x);
            case 11
               x=x*10-5;scores = boothfcn(x);
            case 12
               x=x*10-5;scores = brentfcn(x);
            case 13
               x=x*10-5;scores = bukinn6fcn(x);
            case 14
               x=x*10-5;scores = eggcratefcn(x);
            case 15
               x=x*10-5;scores = eggholderfcn(x);
            case 16
               x=x*10-5;scores = exponentialfcn(x);
            case 17
               x=x*10-5;scores = griewankfcn(x);
            case 18
               x=x*10-5;scores = happycatfcn(x);
            case 19
               x=x*10-5;scores = himmelblaufcn(x);
            case 20
               x=x*10-5;scores = holdertablefcn(x);
            case 21
               x=x*10-5;scores = keanefcn(x);
            case 22
               x=x*10-5;scores = levin13fcn(x);
            case 23
               x=x*10-5;scores = matyasfcn(x);
            case 24
               x=x*10-5;scores = mccormickfcn(x);
            case 25
               x=x*10-5;scores = periodicfcn(x);
            case 26
               x=x*10-5;scores = pichenyfcn(x);
            case 27
               x=x*10-5;scores = powellsumfcn(x);
            case 28
               x=x*10-5;scores = qingfcn(x);
            case 29
               x=x*10-5;scores = quarticfcn(x);
            case 30
               x=x*10-5;scores = rastriginfcn(x);
            case 31
               x=x*10-5;scores = ridgefcn(x);
            case 32
               x=x*10-5;scores = salomonfcn(x);
            case 33
               x=x*10-5;scores = schwefelfcn(x);
            case 34
               x=x*10-5;scores = shubert3fcn(x);
            case 35
               x=x*10-5;scores = shubert4fcn(x);
            case 36
               x=x*10-5;scores = shubertfcn(x);
            case 37
               x=x*10-5;scores = spherefcn(x);
            case 38
               x=x*10-5;scores = styblinskitankfcn(x);
            case 39
               x=x*10-5;scores = sumsquaresfcn(x);
            case 40
               x=x*10-5;scores = threehumpcamelfcn(x);
            case 41
               x=x*10-5;scores = xinsheyangn1fcn(x);
            case 42
               x=x*10-5;scores = xinsheyangn3fcn(x);
            case 43
               x=x*10-5;scores = xinsheyangn4fcn(x);
            case 44
               x=x*10-5;scores = happycatfcn(x, 0.5);
            otherwise
                fprintf('Invalid grade\n' );
        end
        data(i,:)=[x1,scores,0];      
    end
                    %Normalized output to [0,1] 
    T_Mi=min(data(:,2));   
    T_Ma=max(abs(data(:,2)-T_Mi));
    data(:,3)=(data(:,2)-T_Mi)/T_Ma;
                    %Save the training data set
    eval([['train',num2str(ObjFun)] ,'= data;']);
end     

%% Generate the predictive dataset
data=zeros(PM,3);   %The temp data set
for ObjFun=OB
    for i=1:1:PM
                    % input
        x1=i/PM;
        x=[x1 0.5];
                    % choose benchmarks function
        switch(ObjFun)
            case 1
               x=x*10-5;scores = ackleyfcn(x);
            case 2
               x=x*10-5;scores = ackleyn2fcn(x);
            case 3
               x=x*10-5;scores = ackleyn3fcn(x);
            case 4
               x=x*10-5;scores = ackleyn4fcn(x);
            case 5
               x=x*10-5;scores = adjimanfcn(x);
            case 6
               x=x*10-5;scores = alpinen1fcn(x);
            case 7
               x=x*10-5;scores = bartelsconnfcn(x);
            case 8
               x=x*10-5;scores = birdfcn(x);
            case 9
               x=x*10-5;scores = bohachevskyn1fcn(x);
            case 10
               x=x*10-5;scores = bohachevskyn2fcn(x);
            case 11
               x=x*10-5;scores = boothfcn(x);
            case 12
               x=x*10-5;scores = brentfcn(x);
            case 13
               x=x*10-5;scores = bukinn6fcn(x);
            case 14
               x=x*10-5;scores = eggcratefcn(x);
            case 15
               x=x*10-5;scores = eggholderfcn(x);
            case 16
               x=x*10-5;scores = exponentialfcn(x);
            case 17
               x=x*10-5;scores = griewankfcn(x);
            case 18
               x=x*10-5;scores = happycatfcn(x);
            case 19
               x=x*10-5;scores = himmelblaufcn(x);
            case 20
               x=x*10-5;scores = holdertablefcn(x);
            case 21
               x=x*10-5;scores = keanefcn(x);
            case 22
               x=x*10-5;scores = levin13fcn(x);
            case 23
               x=x*10-5;scores = matyasfcn(x);
            case 24
               x=x*10-5;scores = mccormickfcn(x);
            case 25
               x=x*10-5;scores = periodicfcn(x);
            case 26
               x=x*10-5;scores = pichenyfcn(x);
            case 27
               x=x*10-5;scores = powellsumfcn(x);
            case 28
               x=x*10-5;scores = qingfcn(x);
            case 29
               x=x*10-5;scores = quarticfcn(x);
            case 30
               x=x*10-5;scores = rastriginfcn(x);
            case 31
               x=x*10-5;scores = ridgefcn(x);
            case 32
               x=x*10-5;scores = salomonfcn(x);
            case 33
               x=x*10-5;scores = schwefelfcn(x);
            case 34
               x=x*10-5;scores = shubert3fcn(x);
            case 35
               x=x*10-5;scores = shubert4fcn(x);
            case 36
               x=x*10-5;scores = shubertfcn(x);
            case 37
               x=x*10-5;scores = spherefcn(x);
            case 38
               x=x*10-5;scores = styblinskitankfcn(x);
            case 39
               x=x*10-5;scores = sumsquaresfcn(x);
            case 40
               x=x*10-5;scores = threehumpcamelfcn(x);
            case 41
               x=x*10-5;scores = xinsheyangn1fcn(x);
            case 42
               x=x*10-5;scores = xinsheyangn3fcn(x);
            case 43
               x=x*10-5;scores = xinsheyangn4fcn(x);
            case 44
               x=x*10-5;scores = happycatfcn(x, 0.5);
            otherwise
                fprintf('Invalid grade\n' );
        end

        data(i,:)=[x1,scores,0];     
    end
                        %Normalized output to [0,1] 
    T_Mi=min(data(:,2));   
    T_Ma=max(abs(data(:,2)-T_Mi));
    data(:,3)=(data(:,2)-T_Mi)/T_Ma;
                        %Save the predictive data set
    eval([['prect',num2str(ObjFun)] ,'= data;']);
    
%     P=['.\tutorials\DataBF',num2str(ObjFun),'.mat'];
%     save (P); 
end    
                        %Save the whole data in '.mat'  
    save ('..\tutorials\DataBF.mat');