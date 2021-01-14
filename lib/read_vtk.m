function [ lx, ly, lz, u, v ] = read_vtk(fileName)
% READ_VF_FROM_VTK Summary of this function goes here
%   fileName: name of input file
%

disp(['Loading "',fileName,'"...']);

fileIn=fopen(fileName, 'r','b');

if(fileIn<0)  
   error('ERROR: file not found!');    
end

% four header lines
fgets(fileIn);
fgets(fileIn);
fgets(fileIn);
fgets(fileIn);

% read dimensions
fscanf(fileIn, '%s',1);
width = fscanf(fileIn, '%d',1);
height = fscanf(fileIn, '%d',1);
depth = fscanf(fileIn, '%d',1);

% read grid
fscanf(fileIn, '%s',1);
fscanf(fileIn, '%d',1);
fscanf(fileIn, '%s\n',1);
%xc = fscanf(fileIn, '%f',width);
xc = fread(fileIn, width,'float');
fscanf(fileIn, '%s',1);
fscanf(fileIn, '%d',1);
fscanf(fileIn, '%s\n',1);
%yc = fscanf(fileIn, '%f',height);
yc = fread(fileIn, height, 'float');
fscanf(fileIn, '%s',1);
fscanf(fileIn, '%d',1);
fscanf(fileIn, '%s\n',1);
%zc = fscanf(fileIn, '%f',depth);
zc = fread(fileIn, depth, 'float');

% read data
fscanf(fileIn, '%s',1);
noOfPoints = fscanf(fileIn, '%d',1);
fscanf(fileIn, '%s\n',3);
%data = fscanf(fileIn, '%f',3*noOfPoints);
data = fread(fileIn, 3*noOfPoints, 'double');

% post-process
lx = data(1:3:length(data));
ly = data(2:3:length(data)); 
lz = data(3:3:length(data));
lx = reshape(lx,width,height)';
ly = reshape(ly,width,height)';
lz = reshape(lz,width,height)';
[u,v] = meshgrid(xc,yc);

fclose(fileIn);

end

