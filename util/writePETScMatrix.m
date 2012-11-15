function writePETScMatrix(A, filename)
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
%   writePETScMatrix(A, filename)

%
% NOTE:
%   matrix A is transposed internally,
%   MATLAB stores column major, we need row major
%

[nrow ncol] = size(A');
nnzmat      = nnz(A');
[colind,j]  = find(A');
nnzrow      = hist(j,ncol);

fid = fopen(filename, 'w', 'ieee-be');          % open as big-endian (PETSc format)
err = fwrite(fid, 1211216, 'integer*4');        % write PETSc matrix cookie
err = fwrite(fid, nrow, 'integer*4');           % write number of rows
err = fwrite(fid, ncol, 'integer*4');           % write number of columns
err = fwrite(fid, nnzmat, 'integer*4');         % write number of nonzeros
err = fwrite(fid, nnzrow, 'integer*4');         % write number of nonzeros per row
err = fwrite(fid, colind-1, 'integer*4');       % write column indices
err = fwrite(fid, nonzeros(A'), 'real*8');      % write nonzeros
err = fclose(fid);
