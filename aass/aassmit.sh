export TODOPATH="$1"
export MAXT="$4"
export NITER="$3"
export SGE_TASK_LAST="$2"
qsub -t 1-$2 -V ./aass/aassmit.job
