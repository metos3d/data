Metos3D: A Marine Ecosystem Toolkit for Optimization and Simulation in 3-D

-- Data --

Metos3D was developed to use data provided by the Transport Matrix Method in the first place (see [Khatiwala et al., 2005], [1]). This data is maintained by Samar Khatiwala (see [2]). Metos3D supplies you with a MATLAB (see [3]) script to prepare the data for usage.

-- Quick start --

Assuming you have downloaded this repository, unzipped it and changed into the directory, do the following:

1. Download the required data:

data $>
wget http://www.ldeo.columbia.edu/~spk/Research/TMM/MIT_Matrix_Global_2.8deg.tar.gz  # 503M !!!  
wget http://www.ldeo.columbia.edu/~spk/Code/Matlab/Matrix.tar.gz                     #   9K  
wget http://www.ldeo.columbia.edu/~spk/Code/Matlab/Misc.tar.gz                       #  23K  
wget http://www.ldeo.columbia.edu/~spk/Code/Matlab/MITgcm.tar.gz                     #  16K  
wget http://www.ldeo.columbia.edu/~spk/Code/Matlab/PETSC.tar.gz                      #  14K  

2. Start MATLAB and call:

>>
prepareMetos3DData

-- Documentation --

You can find a LaTeX document in the 'doc' directory with more detailed information on the data.

-- References --

[1]
www.ldeo.columbia.edu/~spk/Research/TMM/tmm.html

[2]
www.ldeo.columbia.edu/~spk/

[3]
Registered trademark of The MathWorks, Inc., www.mathworks.com

[Khatiwala et al., 2005]
Khatiwala, S., Visbeck, M., Cane, M., 2005.
Accelerated simulation of passive tracers in ocean circulation models.
Ocean Modelling 9, 51– 69.
