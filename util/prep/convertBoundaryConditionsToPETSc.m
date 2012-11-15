function convertBoundaryConditionsToPETSc(nfile, filebasename, nprofile);
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
%	convertBoundaryConditionsToPETSc(nfile, filebasename, nprofile);

if (nfile == 1)
    filename = filebasename;
%    disp(filename);
    % read old file
    fid = fopen(filename, 'r', 'ieee-be');
    v = fread(fid, nprofile, 'real*8');
    fclose(fid);
    % write new file
    filename = sprintf('%s.petsc', filebasename);
    disp(filename);
    fid = fopen(filename, 'w+', 'ieee-be');
    fwrite(fid, 1211214,  'integer*4');                 % VEC_FILE_COOKIE
    fwrite(fid, nprofile, 'integer*4');
    fwrite(fid, v,        'real*8');
    fclose(fid);
else
    for ifile = 1:nfile
        filename = sprintf('%s%02d', filebasename, ifile-1);
%        disp(filename);
        % read old file
        fid = fopen(filename, 'r', 'ieee-be');
        v = fread(fid, nprofile, 'real*8');
        fclose(fid);
        % write new file
        filename = sprintf('%s%02d.petsc', filebasename,ifile-1);
        disp(filename);
        fid = fopen(filename, 'w+', 'ieee-be');
        fwrite(fid, 1211214,  'integer*4');             % VEC_FILE_COOKIE
        fwrite(fid, nprofile, 'integer*4');
        fwrite(fid, v,        'real*8');
        fclose(fid);
    end
end
