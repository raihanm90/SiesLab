%Read .cube formatted file
%% Author
%Mohammad Abu Raihan Miah 
%University of California, San Diego
%ver 1.1, 21 November, 2017
%% Description
%This function reads the file_name.cube file from SIESTA and saves the relevant
%information in 'file_name_3D_data.mat' file. It will not read anything if
%there is already a file with the same name exists in the current folder.
%It will give the .mat file name as output.
%
%no_atom = number of atoms in the given range
%origin_coord = (x,y,z) coordinates of origin
%x_point_info = 1*4 cell (no of x points, (delx,dely,delz))
%y_point_info = 1*4 cell (no of y points, (delx,dely,delz))
%z_point_info = 1*4 cell (no of z points, (delx,dely,delz))
%atomic_number = no_atom*1 matrix of atomic numbers of the atoms
%atomic_charge = no_atom*1 matrix of atomic charges of the atoms
%atomic_position = no_atom*(x,y,z) matrix of atomic positions of the atoms
%val_3d = 3D grid of data with size of (nox*noy*noz)
%% Code
function [saved_cube_file]=cube_file_read(filename)
    if exist([regexprep(filename,'.cube','') '_3D_data.mat'])==0
        fid=fopen(filename,'r');
        no_atom_origin=textscan(fid,'%d %f %f %f', 1, 'HeaderLines', 2,'Delimiter',{'|','=','#'});
        no_atom=no_atom_origin{1}(1);
        origin_coord=[no_atom_origin{2}(1) no_atom_origin{3}(1) no_atom_origin{4}(1)];
        clear no_atom_origin

        x_point_info=textscan(fid,'%d %f %f %f', 1, 'Delimiter',{'|','=','#'});
        y_point_info=textscan(fid,'%d %f %f %f', 1, 'Delimiter',{'|','=','#'});
        z_point_info=textscan(fid,'%d %f %f %f', 1, 'Delimiter',{'|','=','#'});

        atom_coord=textscan(fid,'%d %f %f %f %f', no_atom, 'Delimiter',{'|','=','#'});
        atomic_number=atom_coord{1,1};
        atomic_charge=atom_coord{1,2};
        atomic_position=[atom_coord{1,3} atom_coord{1,4} atom_coord{1,5}];
        clear atom_coord

        val_raw=textscan(fid,'%f',x_point_info{1,1}*y_point_info{1,1}*z_point_info{1,1}, 'Delimiter',{'|','=','#'});
        val_3D=permute(reshape(val_raw{1,1},z_point_info{1,1},y_point_info{1,1},x_point_info{1,1}),[3 2 1]);
        clear val_raw

        fclose(fid);
        save([regexprep(filename,'.cube','') '_3D_data.mat'], 'no_atom', 'origin_coord', 'x_point_info', 'y_point_info', 'z_point_info', 'atomic_number', 'atomic_position', 'val_3D');
    end
    saved_cube_file=[regexprep(filename,'.cube','') '_3D_data.mat'];
end