function writePetscBinaryMat_mex(filename, A)
%
%	function writePetscBinaryMat_mex(filename, A)
%
%   Author:
%       Jaroslaw Piwonski, CAU Kiel, jpi@informatik.uni-kiel.de
%
disp(filename);

id = 1211216;
[nrowA ncolA] = size(A);
nnzA = nnz(A);
[colindA,jA] = find(A);
nnzrowA = hist(jA,ncolA);

fid = fopen ( filename, 'w', 'ieee-be' );
c = fwrite ( fid, id,     'integer*4' );
c = fwrite ( fid, nrowA,   'integer*4' );
c = fwrite ( fid, ncolA,   'integer*4' );
c = fwrite ( fid, nnzA,    'integer*4' );
c = fwrite ( fid, nnzrowA, 'integer*4' );
c = fwrite ( fid, colindA-1, 'integer*4' );
c = fwrite ( fid, nonzeros(A), 'real*8' );
err = fclose( fid );

end
