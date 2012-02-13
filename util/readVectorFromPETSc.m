function v = readvectorfrompetsc( filename )

%
%   function v = readvectorfrompetsc( filename )
%

fid                         = fopen ( filename, 'r', 'ieee-be' );
c                           = fread ( fid, 1, 'integer*4', 'ieee-be' );    % read PETSc cookie
c                           = fread ( fid, 1, 'integer*4', 'ieee-be' );    % read number of doubles
v                           = fread ( fid, c, 'real*8'   , 'ieee-be' );    % read doubles into v
err                         = fclose( fid );

