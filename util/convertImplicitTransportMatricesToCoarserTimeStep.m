function convertImplicitTransportMatricesToCoarserTimeStep(nMatrix, m, dirFrom, dirTo, fileFormat)
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
%	convertImplicitTransportMatricesToCoarserTimeStep(nMatrix, m, dirFrom, dirTo, fileFormat)
%
%   nMatrix     number of matrices
%   m           m times the original time step
%   dirFrom     read matrices from directory
%   dirTo       write matrices to directory
%   fileFormat  used format for filenames
%
%	Compute Aimp with m*dt
%
%	m*Aimp = Aimp^m
%
%   see: Khatiwala, S., 2007.
%        A computational framework for simulation of biogeochemical tracers in the ocean.
%        Global Biogeochemical Cycles 21.


for i = 0:nMatrix-1

    % prepare file name
    filename = sprintf(fileFormat, i);
    fileFrom = [dirFrom '/' filename];
    fileTo = [dirTo '/' filename];
    disp([fileFrom ' -> ' fileTo]);

    % read matrix
    A = readPETScMatrix(fileFrom);

    % compute IMPLICIT matrix with coarser time step
    Amdt = A^m;

    % write matrix
    writePETScMatrix(Amdt, fileTo);

end
