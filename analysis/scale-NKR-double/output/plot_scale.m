clear;
addpath('aass', 'classes', 'functions');

% Get Data
scaleGrid = [2 3 4 5];

data = readtable('./data/submissions-data.csv');
submissionsData = data;
entries = (strcmp(submissionsData.category,'a') & submissionsData.d_arr_date_min>=19084) + ...
((strcmp(submissionsData.category,'p') |strcmp(submissionsData.category,'c'))...
& submissionsData.r_arr_date_min>=19084);

scaleGrid = scaleGrid * ...
    (1 - sum(strcmp(submissionsData.category(entries>0),'c'))/sum(entries));

SS = aassGet('./analysis/scale-NKR-double/');

for i = 1:length(SS)
    if ~isempty(SS{i})
        S(i) = SS{i};
        S(i).burn = 2000;
    end
end
I = ~cellfun(@isempty, SS);
S = S(I);
scaleGrid = scaleGrid(I);
clear SS;

f_mean = [S.f_mean]';
f_se = [S.f_se]';
scaleGrid = scaleGrid';
clear S

S = table(f_mean,f_se,scaleGrid);


writetable(S, './analysis/scale-NKR-double/output/scalesummary.csv');


