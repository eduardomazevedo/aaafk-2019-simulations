exercise = 'first';
directory = ['./analysis/calibration/' exercise '-exercise/output/'];



load([directory 'chain_lengths.mat'])
load([directory 'poolSizeMoments.mat'])
load([directory 'typeTables.mat'])
load('./analysis/calibration/moment-conditions/realMoments.mat')

numPar = size(overallTypeTables,2);
numSim = size(overallTypeTables,1);
numSample = size(real.matchTypeVar,2);
%% Pool Moments


%poolSize = [mean(mean(simAltPoolSize(1:330))) ; mean(mean(simAltPoolSize(331:660))) ; mean(mean(simAltPoolSize(661:end))) ;...
%    mean(mean(simChipPoolSize(1:330))) ; mean(mean(simChipPoolSize(331:660))) ; mean(mean(simChipPoolSize(661:end))) ;...
%    mean(mean(simPairPoolSize(1:330))) ; mean(mean(simPairPoolSize(331:660))) ; mean(mean(simPairPoolSize(661:end))) ;...
%    mean(mean(simAltruisticTrans(1:330))) ; mean(mean(simAltruisticTrans(331:660))) ; mean(mean(simAltruisticTrans(661:end))) ;...
%    mean(mean(simChipTrans(1:330))) ; mean(mean(simChipTrans(331:660))) ; mean(mean(simChipTrans(661:end))); ...
%    mean(mean(simPairTrans(1:330))) ; mean(mean(simPairTrans(331:660))) ; mean(mean(simPairTrans(661:end))); ...
%    mean(mean(simAltruisticPerish(1:330))) ; mean(mean(simAltruisticPerish(331:660))) ; mean(mean(simAltruisticPerish(661:end))); ...
%    mean(mean(simChipPerish(1:330))) ; mean(mean(simChipPerish(331:660))) ; mean(mean(simChipPerish(661:end))) ;...
%    mean(mean(simPairPerish(1:330))) ; mean(mean(simPairPerish(331:660))) ; mean(mean(simPairPerish(661:end)))];

poolSizeMoms = [1 : 9];

%% Table Moments

statTableMoms = [1 7 9 15 19 21];


%% Match Type Moments
% [twocycleRatio  threecycleRatio chainRatio sum(chainObs)/sum(chainObs./chainLenuUnq') ];

matchTypeMoms = [1 2 4];


for j = 1 : numPar
    
    for i = 1 : numSim
    
       
    statTable1 = table2array(overallTypeTables{i,j})';
    statTable1 = statTable1(:);
    statTable1 = statTable1(statTableMoms);
    statTableMoments(i,1 : length(statTableMoms))= statTable1;  
   
    end
    
    poolSize1  = overallpoolSize{j}';
    poolSize1  = poolSize1(:,poolSizeMoms);
    poolSizeMoments(: , 1 :  length(poolSizeMoms)) = poolSize1;
    
    matchType1 = overallTransPer{j};
    matchType1 = matchType1(:,matchTypeMoms);
    matchTypeMoments(: , 1 :  length(matchTypeMoms)) = matchType1;
    
    Moments{j} = [statTableMoments poolSizeMoments matchTypeMoments];

end

clear statTableMoments poolSizeMoments matchTypeMoments

for i = 1 : numSample
    
    statTable1 = table2array(real.statTableVar{i})';
    statTable1 = statTable1(:);
    statTable1 = statTable1(statTableMoms);
    statTableMoments(i,1 : length(statTableMoms))= statTable1;  
    
    poolSize1  = real.poolSizeVar{i}';
    poolSize1  = poolSize1(:,poolSizeMoms);
    poolSizeMoments(i , 1 :  length(poolSizeMoms)) = poolSize1;
    
end

matchType1 = real.matchTypeVar';
matchType1 = matchType1(:,matchTypeMoms);
matchTypeMoments(: , 1 :  length(matchTypeMoms)) = matchType1;

SampleMoments = [statTableMoments poolSizeMoments matchTypeMoments];

clear statTableMoments poolSizeMoments matchTypeMoments

    statTable1 = table2array(real.statTable)';
    statTable1 = statTable1(:);
    statTable1 = statTable1(statTableMoms);
    statTableMoments = statTable1';  
    
    
    poolSize1  = real.poolSize';
    poolSize1  = poolSize1(:,poolSizeMoms);
    poolSizeMoments = poolSize1;
   
    matchType1 = real.matchType;
    matchType1 = matchType1(:,matchTypeMoms);
    matchTypeMoments = matchType1;
    
    RealMoments = [statTableMoments poolSizeMoments matchTypeMoments];
    
for i = 1 : numPar
loss(i) = mean(Moments{i} - RealMoments) * inv(cov(SampleMoments)) * mean(Moments{i} - RealMoments)';
end

for i = 1 : numPar
loss2(i) = mean(Moments{i} - RealMoments) * inv(cov(Moments{i} - RealMoments)) * mean(Moments{i} - RealMoments)';
end

for i = 1 : numPar
loss3(i) = mean(Moments{i} - RealMoments) * inv(eye(18).*(diag(cov(SampleMoments)))) * mean(Moments{i} - RealMoments)';
end

for j = 1 : 7
for i = 1 : 7
lossGeneral(j,i) = mean(Moments{i} - RealMoments)*inv(cov(Moments{j} - RealMoments))*mean(Moments{i} - RealMoments)';
end
end
