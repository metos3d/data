function convertBoundaryConditionsToPETSc(nfile, filebasename, nprofile);
%
%	function convertBoundaryConditionsToPETSc(nfile, filebasename, nprofile);
%
%   Author:
%       Jaroslaw Piwonski, CAU Kiel, jpi@informatik.uni-kiel.de
%

if (nfile == 1)
    filename = filebasename;
    disp(filename);
    % read old file
    fid = fopen(filename, 'r', 'ieee-be');
    v = fread(fid, nprofile, 'real*8');
    fclose(fid)
    % write new file
    filename = sprintf('%s.petsc', filebasename);
    disp(filename);
    fid = fopen(filename, 'w+', 'ieee-be');
    fwrite(fid, 1211214,  'integer*4');                 % VEC_FILE_COOKIE
    fwrite(fid, nprofile, 'integer*4');
    fwrite(fid, v,        'real*8');
    fclose(fid)
else
    for ifile = 1:nfile
        filename = sprintf('%s%02d', filebasename, ifile-1);
        disp(filename);
        % read old file
        fid = fopen(filename, 'r', 'ieee-be');
        v = fread(fid, nprofile, 'real*8');
        fclose(fid)
        % write new file
        filename = sprintf('%s%02d.petsc', filebasename,ifile-1);
        disp(filename);
        fid = fopen(filename, 'w+', 'ieee-be');
        fwrite(fid, 1211214,  'integer*4');             % VEC_FILE_COOKIE
        fwrite(fid, nprofile, 'integer*4');
        fwrite(fid, v,        'real*8');
        fclose(fid)
    end
end
