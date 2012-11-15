function prepareMetos3DData
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
%   prepareMetos3DData
%
%   Prepares downloaded Transport Matrix Method data for usage with Metos3D.

% make the output compact
format compact

% prepare data files
prepareDataFiles();

% set base path
setBasePath();

% copy needed files
copyNeededFiles();

% run script from Samar Khatiwala
disp('Run script from Samar Khatiwala ...');
cd 'MIT_Matrix_Global_2.8deg/'
cd 'KielBiogeochem_NDOP_Matrix5_4/'
prep_files_for_petsc_kiel_biogeochem_timestepping_cg;
cd ..
cd ..

% convert data to PETSc format
convertDataToPETScFormat();

% make dir structure
makeDirectoryStructure();

% copy into dir structure
disp('Copy into directory structure ...');

% transport
disp('Transport ...');
% explicit matrix
for imatrix = 0 : 11
    fileNameFrom = ['MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/Ae_' sprintf('%02d', imatrix)];
    fileNameTo   = ['Metos3DData/2.8/Transport/Matrix5_4/1dt/Ae_' sprintf('%02d.petsc', imatrix)];
    disp(fileNameTo);
    copyfile(fileNameFrom, fileNameTo);
end
% implicit matrix
for imatrix = 0 : 11
    fileNameFrom = ['MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/Ai_' sprintf('%02d', imatrix)];
    fileNameTo   = ['Metos3DData/2.8/Transport/Matrix5_4/1dt/Ai_' sprintf('%02d.petsc', imatrix)];
    disp(fileNameTo);
    copyfile(fileNameFrom, fileNameTo);
end

% boundary conditions
disp('Boundary conditions ...');
% special
copyfile('util/prep/fukushima.petsc', 'Metos3DData/2.8/Forcing/BoundaryCondition/Special/fukushima.petsc');
% ice cover
for ivector = 0 : 11
    fileNameFrom = ['MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/fice_' sprintf('%02d.petsc', ivector)];
    fileNameTo   = ['Metos3DData/2.8/Forcing/BoundaryCondition/fice_' sprintf('%02d.petsc', ivector)];
    disp(fileNameTo);
    copyfile(fileNameFrom, fileNameTo);
end
% latitude
copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/latitude.bin.petsc', 'Metos3DData/2.8/Forcing/BoundaryCondition/latitude.petsc');

% domain conditions
disp('Domain conditions ...');
% heights
copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/dz.petsc', 'Metos3DData/2.8/Forcing/DomainCondition/dz.petsc');
% depths
copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/z.petsc', 'Metos3DData/2.8/Forcing/DomainCondition/z.petsc');
% salinity
for ivector = 0 : 11
    fileNameFrom = ['MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/Ss_' sprintf('%02d', ivector)];
    fileNameTo   = ['Metos3DData/2.8/Forcing/DomainCondition/Ss_' sprintf('%02d.petsc', ivector)];
    disp(fileNameTo);
    copyfile(fileNameFrom, fileNameTo);
end
% temperature
for ivector = 0 : 11
    fileNameFrom = ['MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/Ts_' sprintf('%02d', ivector)];
    fileNameTo   = ['Metos3DData/2.8/Forcing/DomainCondition/Ts_' sprintf('%02d.petsc', ivector)];
    disp(fileNameTo);
    copyfile(fileNameFrom, fileNameTo);
end

% geometry
disp('Geometry ...');
% indices
%copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/gStartIndicesNew.bin', 'Metos3DData/2.8/Geometry/gStartIndices.bin');
%copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/gEndIndicesNew.bin', 'Metos3DData/2.8/Geometry/gEndIndices.bin');

% tracer initialization
disp('Tracer initialization ...');
copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/po4ini.petsc', 'Metos3DData/2.8/Initialization/po4ini.petsc');
copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/dopini.petsc', 'Metos3DData/2.8/Initialization/dopini.petsc');
copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/oxyini.petsc', 'Metos3DData/2.8/Initialization/oxyini.petsc');
copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/phyini.petsc', 'Metos3DData/2.8/Initialization/phyini.petsc');

% clean Up
disp('Clean up ...');
rmdir('Matrix','s')
rmdir('Misc','s')
rmdir('MITgcm','s')
rmdir('PETSC','s')
rmdir('MIT_Matrix_Global_2.8deg','s')

end

%
%   make directory structure
%
function makeDirectoryStructure
    disp('Make directory structure ...');
    mkdir('Metos3DData/2.8')
    mkdir('Metos3DData/2.8/Forcing')
    mkdir('Metos3DData/2.8/Forcing/BoundaryCondition')
    mkdir('Metos3DData/2.8/Forcing/BoundaryCondition/Special')
    mkdir('Metos3DData/2.8/Forcing/DomainCondition')
    mkdir('Metos3DData/2.8/Geometry')
    mkdir('Metos3DData/2.8/Initialization')
    mkdir('Metos3DData/2.8/Transport')
    mkdir('Metos3DData/2.8/Transport/Matrix5_4')
    mkdir('Metos3DData/2.8/Transport/Matrix5_4/1dt')
end

%
%   convert data to PETSc format
%
function convertDataToPETScFormat
    disp('Convert data to PETSc format ...');
    cd 'MIT_Matrix_Global_2.8deg/'
    cd 'KielBiogeochem_NDOP_Matrix5_4/'
    % latitude
    convertBoundaryConditionsToPETSc(1, 'latitude.bin', 4448);
    % fice
    convertBoundaryConditionsToPETSc(12, 'fice_', 4448);
    % depths
    convertHeightsToDepths
    cd ..
    cd ..
end

%
%   copy needed files
%
function copyNeededFiles
    disp('Copy needed files ...');
    copyfile('Matrix/gcm2matrix.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/gcm2matrix.m')
    copyfile('Misc/read_binary.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/read_binary.m')
    copyfile('Misc/write_binary.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/write_binary.m')
    copyfile('MITgcm/rdmds.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/rdmds.m')
    copyfile('PETSC/writePetscBin.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/writePetscBin.m')
    copyfile('util/prep/writePetscBinaryMat_mex.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/writePetscBinaryMat_mex.m')
    copyfile('util/prep/convertBoundaryConditionsToPETSc.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/convertBoundaryConditionsToPETSc.m')
    copyfile('util/prep/convertHeightsToDepths.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/convertHeightsToDepths.m')
end

%
%   set base path for script from SPK
%
function setBasePath
    disp('Set base path ...');
    cd 'MIT_Matrix_Global_2.8deg/'
    base_path = pwd;
    disp(sprintf('base_path: %s', base_path));
    save basepath.mat base_path
    cd 'KielBiogeochem_NDOP_Matrix5_4/'
    save basepath.mat base_path
    cd ..
    cd ..
end

%
%   uncompress all needed archives
%
function prepareDataFiles
    disp('Prepare data files ...');
    uncompressDataFile('Matrix');
    uncompressDataFile('Misc');
    uncompressDataFile('MITgcm');
    uncompressDataFile('PETSC');
    uncompressDataFile('MIT_Matrix_Global_2.8deg');
end

%
%   uncompress a '*.tar.gz' file
%
function uncompressDataFile(filename)
    % prepare file name
    filetargz = [filename '.tar.gz'];
    filetar   = [filename '.tar'];
    disp(sprintf('extract: %s', filetargz));
    % check, if present
    if exist(filetargz, 'file')
        gunzip(filetargz);
        untar(filetar);
        delete(filetar);
    else
        error(['File "' filetargz '" does not exists!']);
    end
end
