%Reads .out format file created from Siesta DFT simulation
%%
%Mohammad Abu Raihan Miah 
%University of California, San Diego
%ver 1.0, 5 February, 2017
%%
%This function reads the data from the file_name.out file of the simulation to read  
%species number, position and name and saves them in 'file_name_input_variables.mat'
%file

function out_read(filename)
    A=fileread(filename);
    coord_atom_ind=strfind(A,'siesta: Atomic coordinates');
    info_species=strfind(A,'NumberOfSpecies');

    fid=fopen(filename,'r');

    fseek(fid,info_species,-1);
    attain_val=textscan(fid,'%*20c %d', 2, 'Delimiter',{'|','=','#'});
    N_species=attain_val{1}(1);
    N_atoms=attain_val{1}(2);
    species_label=textscan(fid,'%d %d %s', N_species , 'HeaderLines',2, 'Delimiter',{'|','=','#'});
    species_name=species_label{1,3};species_num=species_label{1,1};

    fseek(fid,coord_atom_ind,-1);
    position_atom=textscan(fid,'%*7c %f %f %f %d %d', N_atoms, 'HeaderLines',1, 'Delimiter',{'|','=','#'});
    r_x=position_atom{1,1};r_y=position_atom{1,2};r_z=position_atom{1,3};species_num_pos=position_atom{1,4};
    r=[r_x r_y r_z];
    
    fclose(fid);
    
    save([regexprep(filename,'.out','') '_input_variables.mat'], 'r', 'species_num_pos', 'species_num', 'species_name', 'N_species', 'N_atoms');    
end