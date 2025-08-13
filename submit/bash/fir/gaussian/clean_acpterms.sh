#! /bin/bash

clean_acpterms(){
	cat >&3 <<EOM
sed -i -n '/Done/p;\$p' ${i}.log
rm -f ${i}.chk
EOM
}
