function convertIndices
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
%	convertIndices

fid     = fopen ('gStartIndices.bin', 'r', 'ieee-be');
indices = fread (fid, 4448, 'integer*4');
err     = fclose(fid);

fid = fopen ('gStartIndicesNew.bin', 'w', 'ieee-be');
err = fwrite(fid, 4448,    'integer*4');
err = fwrite(fid, indices, 'integer*4');
err = fclose(fid);

fid     = fopen ('gEndIndices.bin', 'r', 'ieee-be');
indices = fread (fid, 4448, 'integer*4');
err     = fclose(fid);

fid = fopen ('gEndIndicesNew.bin', 'w', 'ieee-be');
err = fwrite(fid, 4448,    'integer*4');
err = fwrite(fid, indices, 'integer*4');
err = fclose(fid);
