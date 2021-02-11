#! /usr/bin/octave -q

NA = 6.02214076e23;
ha2J = 4.3597447222071e-18;
ev2J = 1.602176634e-19;
invm2J = 1.986445857e-25;
invcm2J = invm2J * 1e2;
cal2J = 4.184;
kcalmol2J = cal2J / NA * 1000;
kjmol2J = 1 / NA * 1000;
hz2J = 6.62607015e-34;
thz2J = hz2J * 1e12;
K2J = 1.380649e-23;

xrow = [ha2J, ev2J, invcm2J, kcalmol2J, kjmol2J, 1, hz2J, K2J];
names = {"Hartree","eV","cm-1","kcal/mol","kJ/mol","J","Hz","K"};

printf("| %20s |","");
for i = 1:length(names)
  printf(" %20s |",names{i});
endfor
printf("\n");

for i = 1:length(names)
  printf("| %20s |",names{i});
  for j = 1:length(names)
    printf(" %20.14e |",xrow(i)/xrow(j));
  endfor
  printf("\n");
endfor

