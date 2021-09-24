%Read .EIG file generated from Siesta DFT simulation
%% Author
%Mohammad Abu Raihan Miah 
%University of California, San Diego
%ver 1.0, 08 May, 2017
%% Description
%This function reads the file_name.EIG file and saves the relevant
%information in 'file_name_ener_MP.mat' file. It will not read anything if
%there is already a file with the same name exists in the current folder.
%It will give the .mat file name as output.
%
%fermi_level = Fermi energy of the given system
%no_band = no of energy levels
%no_spin = no of spin (for this function it is assumed to be 1)
%no_k_MP = no of kpoints used for convergence in Monkhrost Pack (MP)
%val_ener_MP = no_k_MP*no_band grid of energy values in MP k points
%% Code
function [saved_EIG_file]=eig_file_read(filename)
    if exist([regexprep(filename,'.EIG','') '_ener_MP.mat'])==0
        fid=fopen(filename,'r');
        fermi=textscan(fid,'%f', 1,'Delimiter',{'|','=','#'});
        fermi_level=fermi{1};
        clear fermi

        point_list=textscan(fid,'%d %d %d', 1,'Delimiter',{'|','=','#'});
        no_band=point_list{1,1};
        no_spin=point_list{1,2};
        no_k_MP=point_list{1,3};
        clear point_list

        val=textscan(fid,['%*d',repmat('%f',[1,no_band])],no_k_MP,'CollectOutput',1, 'Headerlines',1,'Delimiter',{'|','=','#','\n'});
        val_ener_MP=val{1,1};
        clear val
        
        fclose(fid);
        save([regexprep(filename,'.EIG','') '_ener_MP.mat'], 'fermi_level', 'no_band', 'no_spin', 'no_k_MP', 'val_ener_MP');
    end
    saved_EIG_file=[regexprep(filename,'.EIG','') '_ener_MP.mat'];
end