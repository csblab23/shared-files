#!/bin/bash
#SBATCH --partition=compute
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 20
#SBATCH --mem 100GB
#SBATCH --job-name test
#SBATCH --output slurm-%J.out 
#SBATCH -e slurm-%J.out
#SBATCH --mail-type END
#SBATCH --mail-user radulr.dev@igib.res.in


# get tunneling info
XDG_RUNTIME_DIR=""
port=$(shuf -i8000-9999 -n1)
node=$(hostname -s)
user=$(whoami)
login_node=tejas.igib.res.in

# print tunneling instructions jupyter-log
echo -e "
MacOS or linux terminal command to create your ssh tunnel:
ssh -L ${port}:${node}:${port} ${user}@${login_node} 

Here is the MobaXterm info:

Forwarded port:same as remote port
Remote server: ${node}
Remote port: ${port}
SSH server: ${login_node}
SSH login: $user
SSH port: 22
Use a Browser on your local machine to go to:
http://localhost:${port}  (prefix w/ https:// if using password)
Use the token string from the URL printed in slurm-<jobId>.out file and paste it to the local sysytem's browser


# load modules or conda environments here
# e.g. farnam:
# module load Python/2.7.13-foss-2016b 
# module load python/gpu/3.6.5
# DON'T USE ADDRESS BELOW. 
# DO USE TOKEN BELOW

# load your anaconda3 or miniconda
module load anaconda3

# activate your conda environment
source activate /lustre/radulr.dev/Envs/scrna
sleep 1

# starting notebook
jupyter-notebook --no-browser --port=${port} --ip=${node} --notebook-dir=$(pwd)

