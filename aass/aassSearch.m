%AASS Advanced asynchronous simulation system (c).
%   Should be called by run_aass.m and aass.sh, not by the user. Reads
%   simulation options from spec.m in target folder, performs the required
%   simulations, and saves .mat files.
%
%   See also aassReduce, simulation.

%% Input parsing and validation
% Path
dirPath = getenv('TODOPATH');
sizeofHospital = eval(getenv('HOSPITSIZE'));
numberOfInitials = eval(getenv('NUMINITIAL'));
rewardsType = eval(getenv('REWTYPE'));

% Get environment variables
display('get environment variables');
iWorker = getenv('SGE_TASK_ID');
nWorkers = getenv('SGE_TASK_LAST');


iWorker  = str2num(iWorker);
nWorkers = str2num(nWorkers);


%% Assign task vectors todo.
display(iWorker);
display('assign jobs');
display(numberOfInitials);
display(nWorkers);

if iWorker > numberOfInitials
    display('Worker not needed. Exiting.');
    quit;
end;

if numberOfInitials <= nWorkers
    display('Less tasks than workers.');
    todo = iWorker;
    display('todo set');
    display(todo);
else
    iterationsPerWorker = floor(numberOfInitials/nWorkers);
    remainingIterations = numberOfInitials - nWorkers * iterationsPerWorker;
    todo = ...
        (1 + iterationsPerWorker*(iWorker-1)) : ...
        (iterationsPerWorker*(iWorker));
    if iWorker <= remainingIterations
        todo = [todo, nWorkers * iterationsPerWorker + iWorker];
    end
end

display(todo);

%% Run jobs
% Make sure output is random
rng('shuffle');

% Verbose
echo on;

display('Starting simulation.');


%% Search for hospital submission
addpath('aass', 'classes', 'functions');

if rewardsType ==1
    
    rewards = [0.84;...
        1.86;...
        0.08;...
        0.13;...
        0.72;...
        0.09;...
        0.69;...
        1.44];

elseif rewardsType==2

    rewards = [0.86 ; ...
        0.94 ; ...
        0.28 ; ...
        0.30 ; ...
        0.81 ; ...
        0.28 ; ...
        0.85 ; ...
        0.84];

    
end

internalizePar = 1 ;
numberOfIteration = 500 ;
initialSubs = zeros(8, numberOfInitials);

for i = 1 :  numberOfInitials
    
   if  i > 1 && i < 10 
       
       initial = zeros(8,1);
       
       initial(i - 1) = 1 ;
       
       initialSubs(:, i) = initial;
       
   elseif i == 1 
       
       initialSubs(:,i) = zeros(8,1);
       
   else
       
       initialSubs(:,i) = rand(8,1);
       
   end


end



submissionsData = readtable( './output/dwlRegressionTreeCategories_2.csv');

numberofGroups = length(unique([submissionsData.groupTree])) - 1;

entries = (strcmp(submissionsData.category,'a') & submissionsData.d_arr_date_min>=19084) + ...
    ((strcmp(submissionsData.category,'p') |strcmp(submissionsData.category,'c')) ...
    & submissionsData.r_arr_date_min>=19084);

entries = entries & ...
(submissionsData.center_nkr_share>=prctile(submissionsData.center_nkr_share(entries>0),75));

%Groups
groupEntries = zeros(length(entries),numberofGroups);

for i = 1 : numberofGroups
    
   groupEntries(:,i) = entries & submissionsData.groupTree == i; 
   
end

groupEntries = groupEntries / sum( sum ( groupEntries ));
%% Simulation
      
%fun = @(x)100*(x(2) - x(1)^2)^2 + (1 - x(1))^2;

fun = @(submission2NKR)hospitalSub(submission2NKR,rewards, ...
    internalizePar,groupEntries,sizeofHospital,numberOfIteration);

LB = zeros(8,1);
UB = ones(8,1);

options = optimset('Display','iter','MaxIter',2000,'MaxFunEvals',20000);




while length(todo) > 0
    
    for task = todo(randperm(length(todo)))
        
        display(task);
        
        fileName = ['data-', num2str(sizeofHospital) ,'_' num2str(task),'_' ...
            num2str(rewardsType) '.mat'];
        
        fileName = fullfile(dirPath, fileName);

        [X,FVAL,EXITFLAG,OUTPUT] = fminsearchbnd(fun,initialSubs(:,task),LB,UB,options);
        
        save(fileName, 'X','FVAL','EXITFLAG','OUTPUT'); 
        
        todo(todo == task) = [];
    end
end