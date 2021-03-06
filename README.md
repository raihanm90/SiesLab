# SiesLab
MATLAB codes to read <a href="https://departments.icmab.es/leem/siesta/"> Siesta </a> [[1]](#1), a Density Functional Theory (DFT) [[2]](#2) calculation platform, generated files.

**cube_file_read.m**: reads wavefunctions from .cube file generated by Siesta  
**eig_file_read.m**: reads eigen energies from .EIG file generated by Siesta  
**gnu_dat_read.m**: reads band energies at specified k points from .dat file formatted and generated with gnubands.f in Siesta/Util directory. It can be used to plot E-k (energy band) diagrams or to extract band energies to perform band unfolding and so on.  
**kp_file_read.m**: reads the list of k points from .KP file used by Siesta during DFT calculation  
**nc_var_read.m**: reads .nc file from Siesta to read orbital specific information  
**out_read.m**: reads the simulation details from .out file generated by Siesta after the DFT simulation  

**References:**  
<a id="1">[1]</a> J. M. Soler, E. Artacho, J. D. Gale, A. García, J. Junquera, P. Ordejón and D. Sánchez-Portal, J. Phys. Condens. Matter, 2002, 14, 2745–2779.  
<a id="2">[2]</a> W. Kohn, L.J. Sham, Phys. Rev. 140, A1133 (1965).  

[![View SiesLab on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/60243-sieslab)
