%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image Lattice Analysis
% This tool segments an image usindg a periodic 2D parallelogram mesh and
% stack them together for further analysis. An example use is to segment a
% lattice image into individual unit cells.
% Note: one axis of the lattice is always horizontal. Rotate original image
% before processindg when necessary.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Jingshan S. Du, Northwestern University
% du@u.northwestern.edu
% Please cite the following article if you use this code in your research:
% .....
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Setup %%%
% Define file path
strImagePath = fullfile('workspace','0268-BPF3px-12.67deg.bmp');
% Define mesh
meshALength = 390; % in pixel
meshBLength = 365; % in pixel
meshAngle = 91.35; % in degrees
meshOriginX = 2850; % in pixel, from upperleft
meshOriginY = 760;

% test meshing with ready = 0; then switch to 1 for segmentation
ready = 1;

% import image
aryImage = im2double(imread(strImagePath));
% Draw image
imshow(aryImage);
hold on
% Draw mesh
DrawMesh(aryImage, meshALength, meshBLength, meshAngle, meshOriginX, meshOriginY)
hold off
% segment the image
if ready
    MeshImage(aryImage, meshALength, meshBLength, meshAngle, meshOriginX, meshOriginY)
end