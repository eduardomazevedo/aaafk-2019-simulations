S = readtable('./analysis/scale/output/scalesummary.csv');
SHighFric = readtable('./analysis/robustness/higher-waittime/scale/output/scalesummary.csv');
SLowFric = readtable('./analysis/robustness/lower-waittime/scale/output/scalesummary.csv');
SNormalWeight = readtable('./analysis/robustness/normal-weights/scale/output/scalesummary.csv');


coloursforPaper
submissionsData = readtable('./data/submissions-data.csv');

entries = (strcmp(submissionsData.category,'a') & submissionsData.d_arr_date_min>=19084) + ...
((strcmp(submissionsData.category,'p') |strcmp(submissionsData.category,'c'))...
& submissionsData.r_arr_date_min>=19084);

data = submissionsData(entries>0,:);

f = figure();    
    f.Position = [0, 0, 162*3, 100*3];
    hold on;    
    plot([0, S.scaleGrid'], ...
        [0, S.f_mean']' ./ [1, S.scaleGrid']',...
        'color',navyblue,...
        'LineWidth', 2);
    hold on
    
    plot([0, S.scaleGrid'], ...
        [0, SHighFric.f_mean']' ./ [1, S.scaleGrid']',...
        'color',lightblue,...
        'LineWidth', 2);
    hold on
    
    plot([0, S.scaleGrid'], ...
        [0, SLowFric.f_mean']' ./ [1, S.scaleGrid']', ...
        'color',darkgray,...
        'LineWidth', 2);
    
    hold on    
    
    plot([0, S.scaleGrid'], ...
        [0, SNormalWeight.f_mean']' ./ [1, S.scaleGrid']', ...
        'color',darkergray,...
        'LineWidth', 2);    
    xlim([0 1000]);
    ylim([0 0.7]);
    ...title('Average Product');
    xlabel('Number of Donors Submitted Per Year','FontSize', 12);
    ylabel('Average Number of Transplantation Per Donor','FontSize', 12);
    lgd = ...
        legend('Baseline', 'Lower Waiting Time, Higher Friction','Higher Waiting Time, Lower Friction' ...
        ,'Equal Weights'...
        ,'location','east');
    lgd.FontSize = 10;
    % Save
print('./output-for-manuscript/figures/robust-product-func.eps', '-depsc2');
print('./output/figures/robust-product-func.eps', '-depsc2');