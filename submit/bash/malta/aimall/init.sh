#! /bin/bash

init(){
    cat >&3 <<EOM
(
LD_LIBRARY_PATH=/opt/uovi/alberto/aimall/lib/:\${LD_LIBRARY_PATH} /opt/uovi/alberto/aimall/bin/aimqb.exe -nogui -feynman=false -wsp=false ${i}.wfx 2>&1 > /dev/null 
atoms=""
atoms="\${atoms} \$(grep -e '^ *L *=' ${i}_atomicfiles/*.int | awk '{print \$1, (\$NF>0)?\$NF:-\$NF}' | cut -f 2 -d / | sed 's/\.int://' | sed 's/^[a-zA-Z]*//' | awk '\$2>1e-3{printf "%s,",\$1}END{printf "\n"}')"
atoms="\${atoms} \$(grep 'Data' ${i}.sum | awk 'NF==4{print \$1}' | sort | uniq | sed 's/^[a-zA-Z]//' | awk '{printf "%s,",\$1}END{printf "\n"}')"
echo "recalculating: \${atoms}"
LD_LIBRARY_PATH=/opt/uovi/alberto/aimall/lib/:\${LD_LIBRARY_PATH} /opt/uovi/alberto/aimall/bin/aimqb.exe -nogui -feynman=false -wsp=false -bim=promega -atoms="\${atoms}" ${i}.wfx 2>&1 > /dev/null 
) ${AMP}

EOM
}
