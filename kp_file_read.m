%Read .KP file generated from Siesta DFT simulation
%% Author
%Mohammad Abu Raihan Miah 
%University of California, San Diego
%ver 1.0, 08 May, 2017
%% Description
%This function reads the file_name.KP file and saves the relevant
%information in 'file_name_k_MP.mat' file. It will not read anything if
%there is already a file with the same name exists in the current folder.
%It will give the .mat file name as output.
%
%no_k_MP_KP = no of kpoints used for convergence in Monkhrost Pack (MP)
%            (_KP is used to distinguish between .EIG and .KP file)
%k_MP_coord = coordinated of MP k points
%del_k_MP = Differences between MP k points
%% Code
function [saved_KP_file]=kp_file_read(filename)
    if exist([regexprep(filename,'.KP','') '_k_MP.mat'])==0
        fid=fopen(filename,'r');
        N_k=textscan(fid,'%f', 1,'Delimiter',{'|','=','#'});
        no_k_MP_KP=N_k{1};
        clear N_k

        val=textscan(fid,['%*d',repmat('%f',[1,3]),'%f'],no_k_MP_KP,'CollectOutput',1,'Delimiter',{'|','=','#'});
        k_MP_coord=val{1,1}(:,1:3);
        del_k_MP=val{1,1}(:,4);
        clear val
        
        fclose(fid);
        save([regexprep(filename,'.KP','') '_k_MP.mat'], 'no_k_MP_KP', 'k_MP_coord', 'del_k_MP');
    end
    saved_KP_file=[regexprep(filename,'.KP','') '_k_MP.mat'];
end