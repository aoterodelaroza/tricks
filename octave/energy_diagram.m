% Copyright (C) 2018 Alberto Otero-de-la-Roza
%
% This octave routine is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or (at
% your option) any later version. See <http://www.gnu.org/licenses/>.
%
% The routine distributed in the hope that it will be useful, but WITHOUT
% ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
% FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
% more details.

function energy_diagram(name,g,type,label,
                pos=1:length(g),ybuf = [2.5 4],xoff=0.1,ydlabel=1.5,bcolors={"000000","FF0000"})
  %% function energy_diagram(name,g,type,label,pos=1:length(g),ybuf = [2.5 4],xoff=0.1,ydlabel=1.5,bcolors={"000000","FF0000"})
  %%
  %% Create a reaction free energy profile from calculated free energies.
  %% name - Name of the tex/pdf file
  %% g - Free energies in Hartree (vector, length n).
  %% type - Types of species: 1 = stable, 2 = ts. (vector, length n)
  %% label - Label for each species (cell array, length n).
  %% ybuf - space above and below the profile (vector, length 2)
  %% xoff - offset space for the dash lines
  %% ydlabel - vertical space for the labels
  %% bcolors - colors of the bars (cell array, length 2)

  g = (g - min(g)) * 627.50947;

  printf("set terminal cairolatex pdf standalone font ',14'\n");
  printf("set output '%s.tex'\n",name);
  printf("set encoding iso_8859_1\n");
  printf("\n");
  printf("set style line 1 lc rgb '#%s' lw 6\n",bcolors{1});
  printf("set style line 2 lc rgb '#%s' lw 6\n",bcolors{2});
  printf("\n");
  printf("set style line 99 lc rgb '#000000' lw 3 dashtype '-'\n");
  printf("\n");
  for i = 1:length(g)
    printf("g%d  = %.15f\n",i,g(i));
  endfor
  printf("\n");
  printf("set xrange [%d:%d]\n",min(pos)-1,max(pos));
  printf("set yrange [%d:%d]\n",-ybuf(1),max(g)+ybuf(2));
  printf("\n");
  printf("unset key\n");
  printf("set ylabel 'Free energy (kcal/mol)'\n");
  printf("unset xtics\n");
  printf("\n");
  printf("xoff = %.10f\n",xoff);
  printf("ydlabel = %.10f\n",ydlabel);
  printf("\n");
  printf("## stable compounds and transition states\n");
  for i = 1:length(g)
    printf("set arrow from %d-1+xoff, g%d to %d-xoff, g%d nohead ls %d\n",pos(i),i,pos(i),i,type(i));
  endfor
  printf("\n");
  printf("## connections\n");
  for i = 1:length(g)-1
    printf("set arrow from %d-xoff, g%d to %d-1+xoff, g%d nohead ls 99\n",pos(i),i,pos(i+1),i+1);
  endfor
  printf("\n");
  printf("## labels\n");
  for i = 1:length(g)
    printf("set label '\\scshape\\small\\bfseries %s' at %.10f, g%d+ydlabel center\n",
          label{i},pos(i)-0.5,i);
  endfor
  printf("\n");
  printf("## numeric labels\n");
  for i = 1:length(g)
    printf("set label '\\scshape\\scriptsize\\bfseries %+.2f' at %.10f, g%d-ydlabel center\n",
           g(i),pos(i)-0.5,i);
  endfor
  printf("\n");
  printf("f(x) = 9999999\n");
  printf("plot f(x) \n");
endfunction

