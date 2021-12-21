#! /usr/bin/octave -q

iz1  = [1 1 7 6 8 7 1 1];
ncon1 = [1 1 3 3 1 3 1 1];
idcon1 = [
          3 0 0
          3 0 0
          1 2 4
          3 5 6
          4 0 0
          4 7 8
          6 0 0
          6 0 0
];

iz2  = [7 7 6 1 1 1 1 8];
ncon2 = [3 3 3 1 1 1 1 1];
idcon2 = [
          3 5 6
          3 4 7
          1 2 8
          2 0 0
          1 0 0
          1 0 0
          2 0 0
          3 0 0
];

## Update the possible assignment matrix using Ullmann's criteria.
function passign = update_passign(iz1,ncon1,idcon1,iz2,ncon2,idcon2,passign);
  again = 1;
  while(again)
    again = 0;

    ## run over all the edges associated with i
    for i = 1:length(iz1)
      for ix = 1:ncon1(i)

        ## run over all the possible assignments for i
        for j = find(passign(i,:))
          ## then over all the edges of the candidate
          found = 0;
          for jy = 1:ncon2(j)
            ## check the edge in graph 2 is a possible assignment of the edge in graph 1
            if (passign(idcon1(i,ix),idcon2(j,jy)))
              found = 1;
              break
            endif
          endfor
          if (!found)
            ## this is not a good candidate, kill it and repeat
            passign(i,j) = 0;
            again = 1;
          endif
        endfor
      endfor
    endfor
  endwhile
endfunction

## Find the list of permutations of the atoms in graph 1 to match the
## atoms in graph 2. Uses Ullmann's subgraph isomorphism algorithm.
## Returns the candidates in library.
function [assign,passign,library] = ullmann_graph_search(iz1,ncon1,idcon1,iz2,ncon2,idcon2,assign,passign,library)
  ## nubmer of vertices already assigned
  nas = length(assign);

  ## update possible assignments
  passign = update_passign(iz1,ncon1,idcon1,iz2,ncon2,idcon2,passign);

  ## check that the edges involving the last vertex assigned in graph
  ## 1 have an equivalent in graph 2.
  if (nas > 0)
    for j = 1:ncon1(nas)
      ## only if idcon1(i,j) has been assigned already
      if (idcon1(nas,j) <= nas)
        ## edge i-j in graph 1, edge assign(i),assign(idcon1(i,j)) in graph 2
        if (sum(idcon2(assign(nas),:) == assign(idcon1(nas,j))) == 0)
          return
        endif
      endif
    endfor
  endif

  ## if all vertices are done, record the match and finish
  if (nas == length(iz1))
    library = [library; assign];
    return
  endif

  ## run over possible assignments
  for i = find(passign(nas+1,:))
    ## assign nas+1 to candidate atom i
    assign = [assign,i];

    ## spawn a copy and update the possible assignments matrix with
    ## the information that nas+1 has only i as candidate and that i
    ## can only be a candidate to nas+1.
    passign_ = passign;
    passign_(:,i) = 0;
    passign_(nas+1,:) = 0;
    passign_(nas+1,i) = 1;

    ## recurse
    [assign,passign_,library] = ullmann_graph_search(iz1,ncon1,idcon1,iz2,ncon2,idcon2,assign,passign_,library);

    ## unassign
    assign = assign(1:end-1);

    ## update the possible assignments matrix; eliminate the nas+1-i option.
    passign(nas+1,i) = 0;
    passign = update_passign(iz1,ncon1,idcon1,iz2,ncon2,idcon2,passign);
  endfor
endfunction

## pre-build possible assignments based on atomic number
passign = ones(length(iz1));
for i = 1:length(iz1)
  passign(i,:) = (iz1(i) == iz2);
endfor
[~,~,library] = ullmann_graph_search(iz1,ncon1,idcon1,iz2,ncon2,idcon2,[],passign,[])

