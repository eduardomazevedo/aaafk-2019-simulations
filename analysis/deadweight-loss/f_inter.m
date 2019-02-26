function [averageProdApp,grid] = f_inter(options)

% Given options = 'base' or '75th', load data from scale exercise. Then by
% 'pchip' interpolation it give f, where f(1,:) gives number of yearly 
% entries f(2,:) gives number of transplantation given number of yearly
% entries. f_NKR is number of transplantation by NKR size market. 
        
        submissionsData = readtable('./data/submissions-data.csv');
               
        if strcmp(options,'base')
            
        addpath ./analysis/scale/
        
        run spec
        
        rmpath ./analysis/scale/
        
        clear jj nPoints options optionsArray
        
        nonChipRatioNKR = (1 - sum(strcmp(submissionsData.category(entries>0),'c'))/sum(entries)); 
        
        % Load the data from base scale exercise to find f_NKR        
        
        S = readtable('./analysis/scale/output/scalesummary.csv');
        
        scaleGrid_NKR = scaleGrid * nonChipRatioNKR;        

        averageProdApp = ...
            interp1(scaleGrid_NKR,S.f_mean,3:0.1:max(scaleGrid_NKR),'spline');               
%%        
        elseif strcmp(options,'base_high')
            
        addpath ./analysis/robustness/higher-waittime/scale/
        
        run spec
        
        rmpath ./analysis/robustness/higher-waittime/scale/
        
        clear jj nPoints options optionsArray
        
        nonChipRatioNKR = (1 - sum(strcmp(submissionsData.category(entries>0),'c'))/sum(entries)); 
        
        % Load the data from base scale exercise to find f_NKR        
        
        S = readtable('./analysis/robustness/higher-waittime/scale/output/scalesummary.csv');
        
        scaleGrid_NKR = scaleGrid * nonChipRatioNKR;        

        averageProdApp = ...
            interp1(scaleGrid_NKR,S.f_mean,3:0.1:max(scaleGrid_NKR),'spline');      
        
%%      
        elseif strcmp(options,'base_normal')
            
        addpath ./analysis/normal-weights/scale/
        
        run spec
        
        rmpath ./analysis/normal-weights/scale/
        
        clear jj nPoints options optionsArray
        
        nonChipRatioNKR = (1 - sum(strcmp(submissionsData.category(entries>0),'c'))/sum(entries)); 
        
        % Load the data from base scale exercise to find f_NKR        
        
        S = readtable('./analysis/normal-weights/scale/output/scalesummary.csv');
        
        scaleGrid_NKR = scaleGrid * nonChipRatioNKR;        

        averageProdApp = ...
            interp1(scaleGrid_NKR,S.f_mean,3:0.1:max(scaleGrid_NKR),'spline');  
        
%%
        elseif strcmp(options,'base_low')
            
        addpath ./analysis/robustness/lower-waittime/scale/
        
        run spec
        
        rmpath ./analysis/robustness/lower-waittime/scale/
        
        clear jj nPoints options optionsArray
        
        nonChipRatioNKR = (1 - sum(strcmp(submissionsData.category(entries>0),'c'))/sum(entries)); 
        
        % Load the data from base scale exercise to find f_NKR        
        
        S = readtable('./analysis/robustness/lower-waittime/scale/output/scalesummary.csv');
        
        scaleGrid_NKR = scaleGrid * nonChipRatioNKR;        

        averageProdApp = ...
            interp1(scaleGrid_NKR,S.f_mean,3:0.1:max(scaleGrid_NKR),'spline');               
        


        elseif strcmp(options,'75th')
        %% If 75th scale exercise is used
        
        addpath ./analysis/different-compositions/75th-participation/scale/
        
        run spec
        
        rmpath ./analysis/different-compositions/75th-participation/scale/
        
        clear jj nPoints options optionsArray
        
        nonChipRatioNKR = (1 - sum(strcmp(submissionsData.category(entries>0),'c'))/sum(entries)); 
        
        % Load the data from base scale exercise to find f_NKR        
        
        S = readtable('./analysis/different-compositions/75th-participation/scale/output/scalesummary.csv');
        
        scaleGrid_NKR = scaleGrid * nonChipRatioNKR;
        
      
        averageProdApp = ...
            interp1(scaleGrid_NKR,S.f_mean,3:0.1:max(scaleGrid_NKR),'spline');         
         
        
        elseif strcmp(options,'75thsmall')
        %% If small-75th scale exercise is used
        
        addpath ./analysis/scale-small-75th/
        
        run spec
        
        rmpath ./analysis/scale-small-75th/
        
        clear jj nPoints options optionsArray
        
        nonChipRatioNKR = (1 - sum(strcmp(submissionsData.category(entries>0),'c'))/sum(entries)); 
        
        % Load the data from base scale exercise to find f_NKR        
        
        S = readtable('./analysis/scale-small-75th/output/scalesummary.csv');
        
        scaleGrid_NKR = scaleGrid * nonChipRatioNKR;
        
      
        averageProdApp = ...
            interp1(scaleGrid_NKR,S.f_mean,3:0.1:max(scaleGrid_NKR),'spline');         
         
        

        elseif strcmp(options,'25th')
        %% If 25th scale exercise is used
        addpath ./analysis/different-compositions/nkr-size/25th-participation/scale/
        
        run spec
        
        rmpath ./analysis/different-compositions/nkr-size/25th-participation/scale/
        
        clear jj nPoints options optionsArray
        
        nonChipRatioNKR = (1 - sum(strcmp(submissionsData.category(entries>0),'c'))/sum(entries)); 
        
        % Load the data from base scale exercise to find f_NKR        
        S = readtable('./analysis/different-compositions/nkr-size/25th-participation/scale/output/scalesummary.csv');
        
        scaleGrid_NKR = scaleGrid * nonChipRatioNKR;        


        averageProdApp = ...
            interp1(scaleGrid_NKR,S.f_mean,3:0.1:max(scaleGrid_NKR),'spline');         
         
        elseif strcmp(options,'25thsmall')
        %% If small-25th scale exercise is used
        
        addpath ./analysis/scale-small-25th/
        
        run spec
        
        rmpath ./analysis/scale-small-25th/
        
        clear jj nPoints options optionsArray
        
        nonChipRatioNKR = (1 - sum(strcmp(submissionsData.category(entries>0),'c'))/sum(entries)); 
        
        % Load the data from base scale exercise to find f_NKR        
        
        S = readtable('./analysis/scale-small-25th/output/scalesummary.csv');
        
        scaleGrid_NKR = scaleGrid * nonChipRatioNKR;
        
      
        averageProdApp = ...
            interp1(scaleGrid_NKR,S.f_mean,3:0.1:max(scaleGrid_NKR),'spline');         
         
        
                    
        end
        
        grid = 3:0.1:max(scaleGrid_NKR);

end
