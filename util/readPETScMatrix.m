function A = readPETScMatrix(filename)
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
%   A = readPETScMatrix(filename)

fid    = fopen(filename, 'r', 'ieee-be');       % open as big-endian (PETSc format)
matid  = fread(fid, 1, 'integer*4');            % read PETSc matrix cookie
nrow   = fread(fid, 1, 'integer*4');            % read number of rows
ncol   = fread(fid, 1, 'integer*4');            % read number of columns
nnzmat = fread(fid, 1, 'integer*4');            % read number of nonzeros
nnzrow = fread(fid, nrow, 'integer*4');         % read number of nonzeros per row
colind = fread(fid, nnzmat, 'integer*4');       % read column indices
aij    = fread(fid, nnzmat, 'real*8');          % read nonzeros
err    = fclose(fid);

spdata = zeros(nnzmat, 3);
offset = 0;
for i = [1:nrow]
    if (nnzrow(i) ~= 0)
        spdata(offset+1:offset+nnzrow(i), 1) = i;
        spdata(offset+1:offset+nnzrow(i), 2) = colind(offset+1:offset+nnzrow(i))+1;
        spdata(offset+1:offset+nnzrow(i), 3) = aij(offset+1:offset+nnzrow(i));
        offset = offset+nnzrow(i);
    end
end
A = sparse(spdata(:,1), spdata(:,2), spdata(:,3), nrow, ncol);
