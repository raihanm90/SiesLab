%Read .nc formatted file from Siesta DFT simulation
%%
%Mohammad Abu Raihan Miah 
%University of California, San Diego
%ver 1.0, 27 January, 2017
%%
%This function reads the file_name.nc file and saves the relevant variable
%in 'file_name_variables.mat' file.
function nc_var_read(filename)
    %This function reads the nc file and saves different variables in
    %'filename_variables' file
        nc_var_disp(filename);
        %Number of interactions of a given orbital
        %Dimensions: norbs
        numd_data=ncread(filename,'numd');

        %Index (minus 1) of the start of a given row
        %Dimensions: norbs
        row_pointer_data=ncread(filename,'row_pointer');

        %Column index of a given element
        %Dimensions: nnzs (No. of non zeros)
        column_data=ncread(filename,'column');

        %Overlap matrix
        %Dimensions: nnzs
        overlap_data=ncread(filename,'overlap');

        %Density matrix (IN)
        %Dimensions: nnzs,nspin,scf_step
        dm_in_data=ncread(filename,'dm_in');

        %Density matrix (OUT)
        %Dimensions: nnzs,nspin,scf_step
        dm_out_data=ncread(filename,'dm_out');

        %Hamiltonian (in Ry)
        %Dimensions: nnzs,nspin,scf_step
        h_data=ncread(filename,'h');

        %Index of equivalent orb in unit cell
        %Dimensions: no_s
        indxuo_data=ncread(filename,'indxuo');

        save ([regexprep(filename,'.nc','') '_variables.mat'])
end