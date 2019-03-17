addpath('analysis/robustness/lower-waittime/scale/output/');
run plot_scale.m
rmpath('analysis/robustness/lower-waittime/scale/output/');

addpath('analysis/robustness/lower-waittime/scale_small/output/');
run plot_scale.m
rmpath('analysis/robustness/lower-waittime/scale_small/output/');

addpath('analysis/robustness/lower-waittime/matching-probability/output/');
run matchingProbability.m
rmpath('analysis/robustness/lower-waittime/matching-probability/output/');

addpath('analysis/robustness/lower-waittime/gradient/output/');
run gradient.m
rmpath('analysis/robustness/lower-waittime/gradient/output/');

