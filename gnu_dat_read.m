%Reads GNUplot format .dat file created from Siesta DFT simulation
%% Author
%Mohammad Abu Raihan Miah 
%University of California, San Diego
%ver 2.0, 08 May, 2017
%% Description
%This function reads the data from a formatted dat file intended for plotting with 
%gnuplot. This takes the file path from which data will be read as input.
%In Siesta software gnubands.dat file can be created by gnubands.f file provided
%in Siesta/Util and then it may require to plot specific number of band datas
%in MATLAB or extract datas for other purposes like band unfolding and so on.
%
%E_f = fermi Level
%k_min = lowest value of the k axes
%k_max = highest value of the k axes
%E_min = lowest eigen energy
%E_max = highes eigen energy
%Nbands = number of energy bands
%Nspin = value of spin
%Nk = number of kpoints in the simulation
%k_p = list of k points in array
%Ener = value of eigen energies in all k-points. Values for each band are listed in columns
%N_b = number of bands for which data will be read
%f_path = dat file path
%% Code
function [E_f, k_min, k_max, E_min, E_max, Nbands, Nspin, Nk, k_p, Ener]=gnu_dat_read (N_b, f_path)

fid=fopen(f_path,'r');

%Read fermi level
fermi=textscan(fid,'%*s %*s %f', 1, 'HeaderLines', 4,'Delimiter',{'|','=','#'});
E_f=fermi{1};

%Read maximum and minimum value of k axes
k_points=textscan(fid,'%*s %*s %f %f', 1,'Delimiter',{'|','=','#'});
k_min=k_points{1};
k_max=k_points{2};

%Read maximum and minimum value of energies
E_range=textscan(fid,'%*s %*s %f %f', 1,'Delimiter',{'|','=','#'});
E_min=E_range{1};
E_max=E_range{2};

%Read total number of bands used in simulation, Number of spin and total number of k points
N_points=textscan(fid,'%*s %*s %f %f %f', 1,'Delimiter',{'|','=','#'});
Nbands=N_points{1};
Nspin=N_points{2}; 
Nk=N_points{3};

del = textscan(fid,'%*s',1,'Delimiter',{'|','='});
	
val = textscan(fid,'%f %f',Nk,'HeaderLines', 3);
k_p=val{1};
Ener(:,1)=val{2}; %Eigen energies
for p=2:N_b
    val = textscan(fid,'%*f %f',Nk,'HeaderLines', 3);
    Ener(:,p)=val{1}; %Eigen energies
end
fclose(fid);

end