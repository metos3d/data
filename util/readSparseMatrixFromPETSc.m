function S = readSparseMatrixFromPETSc( name );
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
%   S = readSparseMatrixFromPETSc( name );

%
%   open file
%
disp( 'open file ...' );
fid     = fopen ( name, 'r', 'ieee-be' );
id      = fread ( fid, 1,       'integer*4' );
nrow    = fread ( fid, 1,       'integer*4' )
ncol    = fread ( fid, 1,       'integer*4' )
nnz     = fread ( fid, 1,       'integer*4' )
nnzrow  = fread ( fid, nrow,    'integer*4' );
colind  = fread ( fid, nnz,     'integer*4' );
values  = fread ( fid, nnz,     'real*8'    );
err     = fclose( fid )
%
%   create sparse
%
disp( 'create sparse ...' );
D       = zeros( nnz , 3 );
offset  = 0;
for i = 1 : nrow
    if ( nnzrow( i ) ~= 0 )
        D( offset + 1 : offset + nnzrow( i ), 1 ) = i;
        D( offset + 1 : offset + nnzrow( i ), 2 ) = colind( offset + 1 : offset + nnzrow( i ) ) + 1;
        D( offset + 1 : offset + nnzrow( i ), 3 ) = values( offset + 1 : offset + nnzrow( i ) );
        offset = offset + nnzrow( i );
    end
end
%
%   convert sparse
%
disp( 'convert sparse ...' );
S = spconvert( D );

