#!/bin/bash --login
# This is the README file is an executable script.
# To run type: ./README.gnu
#
# Example OBjECTIVE: to demostrate hybrid_hello.c example
# on Magnus with GNU Environment. This is a mixed-mode job 
# which includes both MPI and OpenMP jobs.
# hybrid_hello.c code is taken from
# http://www.slac.stanford.edu/comp/unix/farm/mpi_and_openmp.html
# To run this code, we need to swap from the default environment
# to GNU to be able to compile it with GNU 
# and specify the total number of MPI tasks,
# the number of MPI tasks per node,
# the number of MPI tasks per socket, and
# the number of threads for each MPI task. 
# This information is located under hello_hybrid_gnu.slurm
# You can edit the SLURM as: emacs hello_hybrid_gnu.slurm &

# SLURM directives
# 
# Here we specify to SLURM we want 2 nodes (--nodes=2)
# To compile the code with GNU environment, we swap from Cray to GNU:
# module swap PrgEnv-gnu
# Then, we set the total number of threads to 6:
# export OMP_NUM_THREADS=6
# To launch a job, we specify to aprun 8 MPI tasks (-n 8)
# with 4 MPI tasks per node (-N 4),
# with 2 MPI tasks per socket or NUMA region (-S 2)
# and each MPI tasks have 6 threads. (-d 6)
# Therefore, the aprun command looks like:
# aprun -n 8 -N 4 -S 2 -d 6 ./$EXECUTABLE >> ${OUTPUT}

# To compile the hybrid_hello.c code on GNU Environment
cc -O2 -fopenmp hybrid_hello.c -o hello_hybrid_gnu

# To submit the job to Magnus
sbatch hello_hybrid_gnu.slurm

echo "The sbatch command returns what jobid is for this job."
echo "To check the status of your job, use the slurm command:"
echo "squeue -u $USER"
echo "Your job is deleted from the scratch."
echo "It is now moved to your group."
echo "Your results are now located in ${MYGROUP}/hello_hybrid_c_results/"
echo "To change to your jobID directory, type:"
echo "cd ${MYGROUP}/hello_hybrid_c_results/jobID/"
echo "To view the results, use the cat command and type:"
echo "cat hello_hybrid_gnu.log"
