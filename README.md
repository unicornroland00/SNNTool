# SNNTool
SNNtool is an efficient utility designed for researchers and developers, providing methods for building, training, and using various Sampling Neural Networks (SNNs).SNN is a new neural network algorithm with high accuracy, fast convergence, low computational burden, and reliability. The tool not only provides a simple and user-friendly programming interface, but also has sophisticated functions to flexibly control the structure and parameters of neural networks. 

# How to install
This toolkit runs on MATLAB R2020a or newer in Microsoft Windows.
To install and use this tool, it is just required to add the project folders to MATLAB's works folder. 

# How to use SNNtool
The SNNTool source code is written entirely in Matlab. And the main code can be divided into five element: Plamt & Data, initialization, training process, error analysis, and draw & picture. In addition subsidiary data generation, weights initialization, Ci calculation, forward calculation and iterative training program files and some standard dataset folders. 

there are two entry main files：
(1)SNNs_Main.m needs to prepare the training dataset and test dataset in advance.
(2)SNNs_Rd _Main.m don't needed prepare training dataset, the Sinc library function used in the  file as example, if you need to change the fitting object, you can according to the corresponding application to rewrite the study object or data interface in the program.

# Notes 
(1) The prepare the training dataset for SNNs_Main.m is DataBF.mat. User can use own dataset by changing the default file and options.
The Benchmarks folder gives a description of the functions associated with the standard dataset "Benchmarkfcns" (.docx) and the associated training dataset generation method (.m). It can be modified to obtain different study objects. The results are saved in DataBF.mat.

(2)The network forward calculation, based on Eq. 9, can directly call Ci_fun(xi, Para) to calculate Ci and then calculate the output. The function SNN_Forward(x, W, Para) can also be called to calculate Ci. The Ci_fun function can output different Ci vectors according to the SNN_type value, corresponding to setting different SNN types.

(3)Input and output data preprocessing requires normalization and normalization of the data. Among them, the output data are normalized, but it must be stated here that for the SNNS algorithm, there is no restriction on the output, so it does not necessarily need to be normalized, and the normalization is only used here to better maintain the unity of the overall program. For the input data, according to the characteristics of SNNs, it is necessary to normalize and map all the data to [1,N], the reason why it is necessary to start from 1 is because Matlab's array index starts from 1, in order to better match and facilitate the program, so all the inputs are set to be greater than 1. The range of the data is set to N, in order to correspond better with the weights, and at this time, the weights are located in the sampling point is exactly an integer point The data range is set to N to better correspond to the weights, which are sampled at integer points.

# Support 
Website: https://github.com/unicornroland00/SNNTool (Recommended options).
Or send an email to GangCai@gnnu.edu.cn (Gang Cai) to report issues and bugs. 
Any bug reports, code contributions, suggestions, feedback and insights are immensely appreciated and will support this project.

# Copyright 
Copyright 2023 Gang Cai and Lingyan Wu
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

   Link:https://github.com/unicornroland00/SNNTool


   This code was implemented based on the following paper:

[1] G. Cai, L.Y. Wu, Sampling Neural Network: A Novel Neural Network Based on Sampling %Theorem, 2021 6th International Symposium on Computer and Information Processing %Technology (ISCIPT), (2021) 717-720. http://dx.doi.org/10.1109/ISCIPT53667.2021.00151.

[2] G. Cai, L.Y. Wu, Cycle sampling neural network algorithms and applications, The Journal %of Supercomputing, (2023). http://dx.doi.org/10.1007/s11227-022-05019-9.

   Please cite paper [2] by those who have referenced the code. Thanks！
