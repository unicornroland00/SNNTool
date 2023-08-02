function [out] = SNN_Forward(x,W,Para)  
%SNN_FORWARD The output function of the forward-calculated network

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


%x:input of SNNs;
%y:output of SNNs;
%W:SNNs weights;
%Ci_fun:Calculated function of Ci;

%Para:The Parameters Array, Para=[SNN_type N  Mc Lr epsilon Ntrai];
% SNN_type =Para(1);    
                %SNN_type =0:SNN;     
                %SNN_type =1:CSNN;     
                %SNN_type =2:RSNN
N=Para(2);      %N is the number of weights
% Mc=Para(3);     %Mc is the number of periodic extension for each side
% Lr=Para(4);     %Lr is the learning rate
% epsilon=Para(5);% The object of training error for each data
% Ntrai=Para(6);  % The limit of trail for each training data
    
    Ci=Ci_fun(x,Para);
    out=0;
    for n = 1:1:N
        out=out + Ci(n)*W(n);     
    end

end

