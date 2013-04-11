function v3d = reshapeVectorTo3D(landSeaMask,v)
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
%   v3d = reshapeVectorTo3D(landSeaMask,v)

% note the ' (transposed)
landSeaMask = landSeaMask';
[n1,n2] = size(landSeaMask);
profiles = nonzeros(landSeaMask);
n3 = max(profiles);

k = 1;
offset = 1;
v3d = zeros(n1,n2,n3);

for j = 1:n2
for i = 1:n1
    if (landSeaMask(i,j) ~= 0)
        n = profiles(k);
        v3d(i,j,1:n) = v(offset:offset + n - 1);
        k = k + 1;
        offset = offset + n;
    end
end
end
