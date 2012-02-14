function convertHeightsToDepths
%
%	convertHeightsToDepths
%
%   Author:
%       Jaroslaw Piwonski, CAU Kiel, jpi@informatik.uni-kiel.de
%

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