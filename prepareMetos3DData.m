function prepareMetos3DData
%
%	function prepareMetos3DData
%
%   Author:
%       Jaroslaw Piwonski, CAU Kiel, jpi@informatik.uni-kiel.de
%

format compact

%
%   uncompress data
%
uncompressDataFile('Matrix');
uncompressDataFile('Misc');
uncompressDataFile('MITgcm');
uncompressDataFile('PETSC');
uncompressDataFile('MIT_Matrix_Global_2.8deg');
uncompressDataFile('Metos3DData');

%
%   set base path
%
cd 'MIT_Matrix_Global_2.8deg/'
base_path = pwd
save basepath.mat base_path
cd 'KielBiogeochem_NDOP_Matrix5_4/'
save basepath.mat base_path
cd ..
cd ..

%
%   copy
%
copyfile('Matrix/gcm2matrix.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/gcm2matrix.m')
copyfile('Misc/read_binary.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/read_binary.m')
copyfile('Misc/write_binary.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/write_binary.m')
copyfile('MITgcm/rdmds.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/rdmds.m')
copyfile('PETSC/writePetscBin.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/writePetscBin.m')
copyfile('Metos3DData/util/writePetscBinaryMat_mex.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/writePetscBinaryMat_mex.m')
copyfile('Metos3DData/util/convertBoundaryConditionsToPETSc.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/convertBoundaryConditionsToPETSc.m')
copyfile('Metos3DData/util/convertIndices.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/convertIndices.m')
copyfile('Metos3DData/util/convertHeightsToDepths.m','MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/convertHeightsToDepths.m')

%
%   run script from Samar Khatiwala
%
cd 'MIT_Matrix_Global_2.8deg/'
cd 'KielBiogeochem_NDOP_Matrix5_4/'
prep_files_for_petsc_kiel_biogeochem_timestepping_cg
cd ..
cd ..

%
%   convert
%
cd 'MIT_Matrix_Global_2.8deg/'
cd 'KielBiogeochem_NDOP_Matrix5_4/'
% latitude
convertBoundaryConditionsToPETSc(1, 'latitude.bin', 4448);
% fice
convertBoundaryConditionsToPETSc(12, 'fice_', 4448);
% indices
convertIndices
% depths
convertHeightsToDepths
cd ..
cd ..

%
%   make dir structure
%
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

%
%   copy into dir structure
%

%
%   transport
%

% explicit matrix
for imatrix = 0 : 11
    fileNameFrom = ['MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/Ae_' sprintf('%02d', imatrix)]
    fileNameTo   = ['Metos3DData/2.8/Transport/Matrix5_4/1dt/Ae_' sprintf('%02d.petsc', imatrix)]
    copyfile(fileNameFrom, fileNameTo);
end

% implicit matrix
for imatrix = 0 : 11
    fileNameFrom = ['MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/Ai_' sprintf('%02d', imatrix)]
    fileNameTo   = ['Metos3DData/2.8/Transport/Matrix5_4/1dt/Ai_' sprintf('%02d.petsc', imatrix)]
    copyfile(fileNameFrom, fileNameTo);
end

%
% boundary conditions
%

% special
copyfile('Metos3DData/data/fukushima.petsc', 'Metos3DData/2.8/Forcing/BoundaryCondition/Special/fukushima.petsc');

% ice cover
for ivector = 0 : 11
    fileNameFrom = ['MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/fice_' sprintf('%02d.petsc', ivector)]
    fileNameTo   = ['Metos3DData/2.8/Forcing/BoundaryCondition/fice_' sprintf('%02d.petsc', ivector)]
    copyfile(fileNameFrom, fileNameTo);
end

% latitude
copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/latitude.bin.petsc', 'Metos3DData/2.8/Forcing/BoundaryCondition/latitude.petsc');

%
%   domain conditions
%

% heights
copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/dz.petsc', 'Metos3DData/2.8/Forcing/DomainCondition/dz.petsc');

% salinity
for ivector = 0 : 11
    fileNameFrom = ['MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/Ss_' sprintf('%02d', ivector)]
    fileNameTo   = ['Metos3DData/2.8/Forcing/DomainCondition/Ss_' sprintf('%02d.petsc', ivector)]
    copyfile(fileNameFrom, fileNameTo);
end

% temperature
for ivector = 0 : 11
    fileNameFrom = ['MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/Ts_' sprintf('%02d', ivector)]
    fileNameTo   = ['Metos3DData/2.8/Forcing/DomainCondition/Ts_' sprintf('%02d.petsc', ivector)]
    copyfile(fileNameFrom, fileNameTo);
end

%
%   Geometry
%

% indices
copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/gStartIndicesNew.bin', 'Metos3DData/2.8/Geometry/gStartIndices.bin');
copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/gEndIndicesNew.bin', 'Metos3DData/2.8/Geometry/gEndIndices.bin');

%
%   Initialization
%
copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/po4ini.petsc', 'Metos3DData/2.8/Initialization/po4ini.petsc');
copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/dopini.petsc', 'Metos3DData/2.8/Initialization/dopini.petsc');
copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/oxyini.petsc', 'Metos3DData/2.8/Initialization/oxyini.petsc');
copyfile('MIT_Matrix_Global_2.8deg/KielBiogeochem_NDOP_Matrix5_4/phyini.petsc', 'Metos3DData/2.8/Initialization/phyini.petsc');

%
%   Clean Up
%

rmdir('Matrix','s')
rmdir('Misc','s')
rmdir('MITgcm','s')
rmdir('PETSC','s')
rmdir('MIT_Matrix_Global_2.8deg','s')
rmdir('Metos3DData/data','s')
rmdir('Metos3DData/util','s')

end

function uncompressDataFile(filename)
    filetargz = [filename '.tar.gz'];
    filetar   = [filename '.tar'];
    disp(filetargz);
    gunzip(filetargz);
    untar(filetar);
    delete(filetar);
end
