#!/bin/bash
#SBATCH --job-name=vasp
#SBATCH --output=vasp.o%j
#SBATCH --error=vasp.e%j
#SBATCH --nodes=1
#SBATCH --time=00:30:00
#SBATCH --constraint=gpu
#SBATCH --qos=debug
#SBATCH --account=m2769
#SBATCH --exclusive

ulimit -s unlimited

module load vasp/6.4.1-gpu
module load python
conda activate flare-vasp

VASP_PP_PATH=/global/homes/w/wnw36/Programs/vasp/potpaw/potpaw_PBE
export NCCL_IGNORE_CPU_AFFINITY=1
export OMP_NUM_THREADS=128
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/global/homes/w/wnw36/.conda/envs/flare-vasp/lib/
#srun -n 4 -c 32 --cpu-bind=cores --gpu-bind=none -G 4  vasp_std 

flare-otf flare-vasp-lammps-pbed3.yaml
