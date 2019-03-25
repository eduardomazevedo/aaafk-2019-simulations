%% Submission Data file creation with regression tree groups. 

clear all

% Get data

submissionsData = readtable('./data/submissions-data.csv');
entries = (strcmp(submissionsData.category, 'a') & submissionsData.d_arr_date_min >= 19084) + ...
    ((strcmp(submissionsData.category, 'p') |strcmp(submissionsData.category, 'c'))...
    & submissionsData.r_arr_date_min >= 19084);

gradient = readtable( './analysis/gradient/output/gradient.csv');
gradientHigh = readtable( './analysis/robustness/higher-waittime/gradient/output/gradient.csv');
gradientLow = readtable( './analysis/robustness/lower-waittime/gradient/output/gradient.csv');

matchProb = readtable( './analysis/matching-probability/output/matching-probability.csv');
matchProbHigh = readtable( './analysis/robustness/higher-waittime/matching-probability/output/matching-probability.csv');
matchProbLow = readtable( './analysis/robustness/lower-waittime/matching-probability/output/matching-probability.csv');

%% Demand Types

overdemanded = ...
((strcmp(submissionsData.r_abo, 'AB')& strcmp(submissionsData.d_abo, 'B'))|...
(strcmp(submissionsData.r_abo, 'AB')& strcmp(submissionsData.d_abo, 'A'))|...
(strcmp(submissionsData.r_abo, 'AB')& strcmp(submissionsData.d_abo, 'O'))|...
(strcmp(submissionsData.r_abo, 'A')& strcmp(submissionsData.d_abo, 'O'))|...
(strcmp(submissionsData.r_abo, 'B')& strcmp(submissionsData.d_abo, 'O')));
underdemanded = ...
((strcmp(submissionsData.r_abo, 'O')& strcmp(submissionsData.d_abo, 'AB'))|...
(strcmp(submissionsData.r_abo, 'O')& strcmp(submissionsData.d_abo, 'B'))|...
(strcmp(submissionsData.r_abo, 'O')& strcmp(submissionsData.d_abo, 'A'))|...
(strcmp(submissionsData.r_abo, 'A')& strcmp(submissionsData.d_abo, 'AB'))|...
(strcmp(submissionsData.r_abo, 'B')& strcmp(submissionsData.d_abo, 'AB')));
normaldemanded = ...
((strcmp(submissionsData.r_abo, 'AB')& strcmp(submissionsData.d_abo, 'AB'))|...
(strcmp(submissionsData.r_abo, 'B')& strcmp(submissionsData.d_abo, 'B'))|...
(strcmp(submissionsData.r_abo, 'A')& strcmp(submissionsData.d_abo, 'A'))|...
(strcmp(submissionsData.r_abo, 'O')& strcmp(submissionsData.d_abo, 'O'))|...
(strcmp(submissionsData.r_abo, 'A')& strcmp(submissionsData.d_abo, 'B'))|...
(strcmp(submissionsData.r_abo, 'B')& strcmp(submissionsData.d_abo, 'A')));

demand_type = cell(size(submissionsData, 1), 1);
demand_type(underdemanded) = {'under'};
demand_type(normaldemanded) = {'normal'};
demand_type(overdemanded) = {'over'};

submissionsData.demand_type = demand_type;
%% Groups
groupTree = zeros(size(submissionsData, 1), 1);
% group 1: non O altruists

flag = ...
    strcmp(submissionsData.category, 'a') & ...
    (~strcmp(submissionsData.d_abo, 'O')) & ...
    entries;
groupTree(flag) = 1;

% group 2: O altruists
flag = ...
    strcmp(submissionsData.category, 'a') & ...
    strcmp(submissionsData.d_abo, 'O') & ...
    entries;
groupTree(flag) = 2;

% group 3: R=O, D~=O
flag = ...
    strcmp(submissionsData.category, 'p') & ...
    ((strcmp(submissionsData.r_abo, 'O'))&...
    ~(strcmp(submissionsData.d_abo, 'O'))) & ...
    entries;
groupTree(flag) = 3;

% group 4: R=O, D=O r_cpra>89
flag = ...
    strcmp(submissionsData.category, 'p') & ...
    ((strcmp(submissionsData.r_abo, 'O'))&...
    (strcmp(submissionsData.d_abo, 'O'))) & ...
    submissionsData.r_cpra >= 89 & ...
    entries;
groupTree(flag) = 4;


% group 5: R=O, D=O r_cpra<89
flag = ...
    strcmp(submissionsData.category, 'p') & ...
    ((strcmp(submissionsData.r_abo, 'O'))&...
    (strcmp(submissionsData.d_abo, 'O'))) & ...
    submissionsData.r_cpra < 89 & ...
    entries;
groupTree(flag) = 5;


% group 6: R~=O, r_cpra>95
flag = ...
    strcmp(submissionsData.category, 'p') & ...
    ~(strcmp(submissionsData.r_abo, 'O'))&...
    submissionsData.r_cpra >= 95 & ...
    entries;
groupTree(flag) = 6;


% group 7: R~=O, D~=O r_cpra<95
flag = ...
    strcmp(submissionsData.category, 'p') & ...
    (~(strcmp(submissionsData.r_abo, 'O'))&...
    ~strcmp(submissionsData.d_abo, 'O'))&...
    submissionsData.r_cpra < 95 & ...
    entries;
groupTree(flag) = 7;

% group 8: R~=O, D=O r_cpra<95
flag = ...
    strcmp(submissionsData.category, 'p') & ...
    (~(strcmp(submissionsData.r_abo, 'O'))&...
    strcmp(submissionsData.d_abo, 'O'))&...
    submissionsData.r_cpra < 95 & ...
    entries;
groupTree(flag) = 8;
submissionsData.groupTree  = groupTree;

% group 9:  unpaired

flag = ...
    strcmp(submissionsData.category, 'c') & ...
    entries;
groupTree(flag) = 9;
submissionsData.groupTree  = groupTree;

submissionsData = submissionsData(gradient.index,:);

submissionsData.matchProb = matchProb.matching_probability;
submissionsData.matchProbHigh = matchProbHigh.matching_probability;
submissionsData.matchProbLow = matchProbLow.matching_probability;

submissionsData.df = gradient.df;
submissionsData.dfHigh = gradientHigh.df;
submissionsData.dfLow = gradientLow.df;





summaryTable = ...
    grpstats(submissionsData,{'groupTree'},'mean','DataVars',...
    {'matchProb','matchProbHigh','matchProbLow',...
    'df','dfHigh','dfLow'});

writetable(summaryTable, './output/regresstable-robust.csv');
