% Copyright (C) 2015 Alberto Otero-de-la-Roza <aoterodelaroza@gmail.com>
%
% acp is free software: you can redistribute it and/or modify it under
% the terms of the GNU General Public License as published by the Free
% Software Foundation, either version 3 of the License, or (at your
% option) any later version. See <http://www.gnu.org/licenses/>.
%
% The routine distributed in the hope that it will be useful, but WITHOUT
% ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
% FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
% more details.

function ac = strfields(txt)
  %% function ac = strfields(txt)
  %%
  %% Separate the string txt into a cell array of fields.
  
  ac = {};
  af = -1;
  txt = strtrim(txt);
  af = sscanf(txt,"%s","C");
  while (!isempty(af))
    ac = {ac{:} af};
    txt = strtrim(txt(length(af)+1:end));
    af = sscanf(txt,"%s","C");
  endwhile
end
