addpath('analysis/scale/output/');
run plot_scale.m
rmpath('analysis/scale/output/');

addpath('analysis/scale_small/output/');
run plot_scale.m
rmpath('analysis/scale_small/output/');


addpath('analysis/matching-probability/output/');
run matchingProbability.m
rmpath('analysis/matching-probability/output/');


addpath('analysis/gradient/output/');
run gradient.m
rmpath('analysis/gradient/output/');

