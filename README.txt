Metos3D: A Marine Ecosystem Toolkit for Optimization and Simulation in 3-D

-- Data --

Metos3D was developed to use data provided by the Transport Matrix Method in the first place [Khatiwala et al., 2005], (1). This data is maintained by Samar Khatiwala (2). Metos3D supplies you with a MATLAB (3) script to prepare it for usage.

-- Quick start --

Assuming you are in the same directory as the 'README.txt' file, do the following:

1. Download the required data:

$>
wget http://www.ldeo.columbia.edu/~spk/Research/TMM/MIT_Matrix_Global_2.8deg.tar.gz  # 503M !!!  
wget http://www.ldeo.columbia.edu/~spk/Code/Matlab/Matrix.tar.gz                     #   9K  
wget http://www.ldeo.columbia.edu/~spk/Code/Matlab/Misc.tar.gz                       #  23K  
wget http://www.ldeo.columbia.edu/~spk/Code/Matlab/MITgcm.tar.gz                     #  16K  
wget http://www.ldeo.columbia.edu/~spk/Code/Matlab/PETSC.tar.gz                      #  14K  

2. Start MATLAB and call:

>>
prepareMetos3DData

-- Documentation --

You can compile the LaTeX document in the 'doc' directory for more detailed information about file formats and resolution.

-- References --

(1) www.ldeo.columbia.edu/~spk/Research/TMM/tmm.html

(2) www.ldeo.columbia.edu/~spk/

(3) Registered trademark of The MathWorks, Inc., www.mathworks.com.

[Khatiwala et al., 2005]
Khatiwala, S., Visbeck, M., Cane, M., 2005.
Accelerated simulation of passive tracers in ocean circulation models.
Ocean Modelling 9, 51– 69.
