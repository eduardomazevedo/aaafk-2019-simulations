addpath('analysis/robustness/higher-waittime/scale/output/');
run plot_scale.m
rmpath('analysis/robustness/higher-waittime/scale/output/');

addpath('analysis/robustness/higher-waittime/scale_small/output/');
run plot_scale.m
rmpath('analysis/robustness/higher-waittime/scale_small/output/');

addpath('analysis/robustness/higher-waittime/matching-probability/output/');
run matchingProbability.m
rmpath('analysis/robustness/higher-waittime/matching-probability/output/');

addpath('analysis/robustness/higher-waittime/gradient/output/');
run gradient.m
rmpath('analysis/robustness/higher-waittime/gradient/output/');

