function S = readsparsefrompetsc( name );
%
%   function S = readsparsefrompetsc( name );
%
%   Author: Jaroslaw Piwonski, jpi@informatik.uni-kiel.de
tic;
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
toc;
