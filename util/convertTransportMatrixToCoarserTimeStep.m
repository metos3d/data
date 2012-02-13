function convertTransportMatrixToCoarserTimeStep(dirFrom, dirTo, nmatrix, m)

%
%	function convertTransportMatrixToCoarserTimeStep(dirFrom, dirTo, nmatrix, m)
%
%	Compute Ae and Ai with m*dt
%
%	Author: Jaroslaw Piwonski, jpi@informatik.uni-kiel.de
%
%	m*Ae = I + m*(Ae - I)
%	m*Ai = Ai^m
%
%	see: Khatiwala, 2007, A computational framework for simulation of biogeochemical tracers in the ocean
%

for i = 1:nmatrix

	%%
	%%   read explicit matrix: Ae
	%%
	filename = sprintf('%s/Ae_%02d',dirFrom,i-1);
	disp(filename);
	fid     = fopen ( filename, 'r', 'ieee-be'   );
	id      = fread ( fid, 1,    'integer*4' );
	nrow    = fread ( fid, 1,    'integer*4' );
	ncol    = fread ( fid, 1,    'integer*4' );
	nnz     = fread ( fid, 1,    'integer*4' );
	nnzrow  = fread ( fid, nrow, 'integer*4' );
	colind  = fread ( fid, nnz,  'integer*4' );
	values  = fread ( fid, nnz,  'real*8'    );
	err     = fclose( fid );
	%
	%	create index for spconvert
	%
	idx = zeros(nnz,1);
	offset = 0;
	for j =1:nrow;
		idx(offset+1:offset+nnzrow(j)) = j;
		offset = offset + nnzrow(j);
	end;
	%
	%	convert to matlab sparse matrix
	%	
	Ae = spconvert([idx colind+1 values]);
	%
	%	compute bigger time steps for explicit matrix
	%
	I = speye(size(Ae));
	Aemdt = I+m*(Ae-I);
	%
	%	write new explicit matrix to disc
	%
	filename = sprintf('%s/Ae_%02d',dirTo,i-1);
	disp(filename);
	fid = fopen ( filename, 'w', 'ieee-be' );
	c = fwrite ( fid, id,     'integer*4' );
	c = fwrite ( fid, nrow,   'integer*4' );
	c = fwrite ( fid, ncol,   'integer*4' );
	c = fwrite ( fid, nnz,    'integer*4' );
	c = fwrite ( fid, nnzrow, 'integer*4' );
	c = fwrite ( fid, colind, 'integer*4' );
	c = fwrite ( fid, nonzeros(Aemdt'), 'real*8' );
	err = fclose( fid );
	
	%%
	%%	read implicit matrix: Ai
	%%
	filename = sprintf('%s/Ai_%02d',dirFrom,i-1);
	disp(filename);
	fid     = fopen ( filename, 'r', 'ieee-be'   );
	id      = fread ( fid, 1,    'integer*4' );
	nrow    = fread ( fid, 1,    'integer*4' );
	ncol    = fread ( fid, 1,    'integer*4' );
	nnz     = fread ( fid, 1,    'integer*4' );
	nnzrow  = fread ( fid, nrow, 'integer*4' );
	colind  = fread ( fid, nnz,  'integer*4' );
	values  = fread ( fid, nnz,  'real*8'    );
	err     = fclose( fid );
	%
	%	create index for spconvert
	%
	idx = zeros(nnz,1);
	offset = 0;
	for j =1:nrow;
		idx(offset+1:offset+nnzrow(j)) = j;
		offset = offset + nnzrow(j);
	end;
	%
	%	convert to matlab sparse matrix
	%	
	Ai = spconvert([idx colind+1 values]);
	%
	%	compute bigger time steps for implicit matrix
	%
	Aimdt = Ai^m;
	%
	%	write new implicit matrix to disc
	%
	filename = sprintf('%s/Ai_%02d',dirTo,i-1);
	disp(filename);
	fid = fopen ( filename, 'w', 'ieee-be' );
	c = fwrite ( fid, id,     'integer*4' );
	c = fwrite ( fid, nrow,   'integer*4' );
	c = fwrite ( fid, ncol,   'integer*4' );
	c = fwrite ( fid, nnz,    'integer*4' );
	c = fwrite ( fid, nnzrow, 'integer*4' );
	c = fwrite ( fid, colind, 'integer*4' );
	c = fwrite ( fid, nonzeros(Aimdt'), 'real*8' );
	err = fclose( fid );
	
end

