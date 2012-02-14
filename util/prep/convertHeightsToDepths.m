function convertHeightsToDepths
%
% Metos3D: A Marine Ecosystem Toolkit for Optimization and Simulation in 3-D
% Copyright (C) 2012  Jaroslaw Piwonski, CAU, jpi@informatik.uni-kiel.de
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%	convertHeightsToDepths

format compact
%load starts
%load ends

fid    = fopen ('gStartIndices.bin', 'r', 'ieee-be');
starts = fread (fid, 4448, 'integer*4');
err    = fclose(fid);

fid    = fopen ('gEndIndices.bin', 'r', 'ieee-be');
ends   = fread (fid, 4448, 'integer*4');
err    = fclose(fid);

fid      = fopen ('dz.petsc', 'r', 'ieee-be');
vecid    = fread (fid, 1, 'integer*4');
n        = fread (fid, 1, 'integer*4');
dz       = fread (fid, n, 'real*8');
err      = fclose(fid);

z = zeros(n,1);

for i = 1 : 4448
    %[i starts(i) ends(i)]
    for j = starts(i) : ends(i)
        if (j == starts(i))
            z(j) = dz(j);
        else
            z(j) = z(j-1) + dz(j);
        end
        %[j dz(j) z(j)]
    end
end

fid = fopen ('z.petsc', 'w', 'ieee-be');
err = fwrite(fid, vecid, 'integer*4');
err = fwrite(fid, n, 'integer*4');
err = fwrite(fid, z, 'real*8');
err = fclose(fid);

end