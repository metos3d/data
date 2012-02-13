function convertIndices
%
%	convertIndices
%
%   Author:
%       Jaroslaw Piwonski, CAU Kiel, jpi@informatik.uni-kiel.de
%

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
