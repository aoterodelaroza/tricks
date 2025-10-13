#! /bin/bash

run_(){
	cat >&3 <<EOM
python 0-write_structure_info.py >& 0-write_structure_info.out
# python 1-build_cluster_config.py >& 1-build_cluster_config.out
# python 2-generate_structures_rattle.py >& 2-generate_structures_rattle.out
# python 3-calculate_harmonic_fc2.py >& 3-calculate_harmonic_fc2.out
# python 3a-fit_debye_model-harmonic.py >& 3a-fit_debye_model-harmonic.out
# python 4-generate_structures.py >& 4-generate_structures.out
# python 5-train_fcn.py >& 5-train_fcn.out
# python 6-calculate_effective_frequencies.py >& 6-calculate_effective_frequencies.out
# python 7-fit_debye_model.py >& 7-fit_debye_model.out

EOM
}
