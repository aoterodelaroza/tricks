#! /bin/bash

init_(){
    cat >&3 <<EOM
eval "\$(/home/alberto/miniconda3/bin/conda shell.bash hook)"
conda activate psi4
export PSI_SCRATCH=\${SLURM_TMPDIR}

EOM
}
