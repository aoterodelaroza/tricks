#! /usr/bin/awk -f 

## checkqe.awk bleh1.scf.out bleh2.scf.out ...

FNR == 1{
    if (nfile)
	printinfo()
    nfile++
    file = FILENAME
    nstep = 0; qever = 0; v = 0; isvcrelax = 0; nat = 0; nelec = 0;
    nks = 0; ecutwfc = 0; ecutrho = 0; noptstep = 0; isopt = 0;
    isfinished = 0;
    iswarnscf = 0;
}
/Program PWSCF/{
    qever = $3
    sub("v.","",qever)
}
/^ *unit-cell volume/{ v = $4 }
/^ *new unit-cell volume/{ 
    v = $5 
    isvcrelax = 1
}
/^ *number of atoms\/cell/{ nat = $5 }
/^ *number of electrons/{ nelec = $5 }
/^ *number of Kohn-Sham states/{ nks = $5 }
/^ *kinetic-energy cutoff/{ ecutwfc = $4 }
/^ *charge density cutoff/{ ecutrho = $5 }
/^ *nstep/{ noptstep = $3 }

/^ *BFGS Geometry Optimization/{ isopt = 1 }

/^ *estimated scf accuracy/{
    lastacc = $5
}
/^!/{
    nstep++
    e[nstep] = $5
    scfconv[nstep] = 1
    scfacc[nstep] = lastacc
}
/^ *convergence NOT achieved after/{
    nstep++
    e[nstep] = 0
    scfconv[nstep] = 0
    scfacc[nstep] = lastacc
}
/^ *JOB DONE/{
    isfinished = 1
}
/SCF correction compared to forces is large/{
    iswarnscf = 1
}

END{
    printinfo()
}

function printinfo(){
    printf("%d. %s (opt) : ",nfile, file)
    if (iswarnscf)
	printf("[WARN: low conv_thr] ")
    if (!scfconv[nstep]){
	if (nstep > 1)
	    last = e[nstep-1]
	else
	    last = 0
	printf("SCF did not converge (step=%d, last=%.8f, estacc=%.8f)",nstep,last,scfacc[nstep])
    } else if (isopt) {
	if (isfinished){
	    if (nstep >= noptstep){
		if (nstep > 1)
		    ediff = e[nstep] - e[nstep-1]
		else
		    ediff = 0
		printf("too many opt steps (step=%d, e=%.8f, ediff=%.8f)",nstep,e[nstep],ediff)
	    } else {
		if (isvcrelax){
		    if (nstep > 1)
			ediff = e[nstep] - e[nstep-1]
		    else
			ediff = 0
		    printf("vc-relax done in %d steps - ene= %.8f diff= %.8f Ry, %.4f kcal/mol ",nstep,e[nstep],ediff,ediff/2*627.51)
		} else {
		    printf("relax done in %d steps - ene= %.8f ",nstep,e[nstep])
		}
	    }
	}
	else
	    printf("calculation not finished (?)")
    } else {
	printf("I do not know how to handle non-optimizations")
    }
    printf("\n")
}
