function [W] = SNN_W_init_Fun(W_init_value,N)
%SNNs_W_init_Fun:Weights initialization function

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


%Output W: the weights array; 1*(N+1)
%N is the number of weights.    
%W_init_value:Weights initialization value
    %W_init_value=0:0 Initialization;     
    %W_init_value=Constant:Constant initialization;     
    %W_init_value='R':random initialization.
    
if  W_init_value=='R'
    W=rand(1,N);
elseif  W_init_value==0
    W=zeros(1,N);
else
    W=ones(1,N)*W_init_value;    
    
end

