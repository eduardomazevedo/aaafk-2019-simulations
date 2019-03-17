addpath('analysis/robustness/normal-weights/scale/output/');
run plot_scale.m
rmpath('analysis/robustness/normal-weights/scale/output/');

addpath('analysis/robustness/normal-weights/scale_small/output/');
run plot_scale.m
rmpath('analysis/robustness/normal-weights/scale_small/output/');

addpath('analysis/robustness/normal-weights/matching-probability/output/');
run matchingProbability.m
rmpath('analysis/robustness/normal-weights/matching-probability/output/');

addpath('analysis/robustness/normal-weights/gradient/output/');
run gradient.m
rmpath('analysis/robustness/normal-weights/gradient/output/');

