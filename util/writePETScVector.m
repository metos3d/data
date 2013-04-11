function writePETScVector(v, filename)
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
%   writePETScVector(v, filename)

fid = fopen(filename, 'w', 'ieee-be');          % open as big-endian (PETSc format)
err = fwrite(fid, 1211214, 'integer*4');        % write PETSc vector cookie
err = fwrite(fid, length(v(:)), 'integer*4');   % write number of rows
err = fwrite(fid, v(:), 'real*8');              % write doubles from v
err = fclose(fid);
