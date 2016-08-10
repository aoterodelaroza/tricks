% Copyright (C) 2016 Alberto Otero-de-la-Roza
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

function x = load_matrix(file,ignore_nonnum_lines=0,usenan_nonnum_fields=0)
% function x = load_matrix(file,ignore_nonnum_lines=0,usenan_nonnum_fields=0)
%
% load_matrix - read a 2d array of numbers from a file, possibly containing
% non-numeric fields.
%
% ignore_nonnum_lines = 1 -> skip lines not entirely composed of numbers and comments
% ignore_nonnum_lines = 0 -> parse character lines
% - usenan_nonnum_fields = 0 -> skip non-numeric fields
% - uesnan_nonnum_fields = 1 -> use nan in non-numeric fields
% - usenan_nonnum_fields = 2 -> skip the rest of the line if non-numeric field is found
%
  if (!exist(file,"file"))
    x = [];
    return
  endif
  fid = fopen(file,"r");
  mnf = 0;
  nl = 0;
  x = [];
  while (!feof(fid))
    ## Skip blank lines and comments (#)
    line = strtrim(fgetl(fid));
    if (!ischar(line) || length(line) == 0)
      continue
    end
    token = strsplit(line);
    xline = [];
    nf = 0;
    for i = 1:length(token)
      ## A comment - skip the rest of this line
      if (token{i}(1:1) == "#")
        break
      endif

      ## Try to convert the token to a number
      ax = str2num(token{i});
      if (!isempty(ax) && isscalar(ax))
        ## A number -- add it as a new field
        nf++;
        xline(nf) = ax;
      elseif (!ignore_nonnum_lines)
        ## A non-number, and we don't ignore those
        if (!usenan_nonnum_fields)
          ## Go to the next token without increaseing the field counter
          continue
        elseif (usenan_nonnum_fields == 2)
          ## Skip the remainder of the line
          break
        endif
        ## If usenan_nonnum_fields is 1, then add a NaN field
        nf++;
        xline(nf) = NaN;
      else
        ## Ignore non-numeric lines
        break
      endif
    endfor

    ## This line contained some fields, accumulate it in the output array
    if (nf > 1)
      nl++;
      if (nf > mnf)
        ## Make the array bigger to accomodate the line; pad with NaNs
        x = postpad(x,nf,NaN,2);
        mnf = nf;
      endif
      x(nl,1:length(xline)) = xline;
    endif
  endwhile
  fclose(fid);
endfunction
