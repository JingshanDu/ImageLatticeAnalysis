function [outputArg1,outputArg2] = Stacker(subdir)
%STACKER Stacks all unit cell images in the given directory for further
%analysis. Workspace dir level is already included.

dirname = fullfile('workspace',subdir);

aryImg = 0;

structFiles = dir(fullfile(dirname,'*.bmp'));
for i = 1:length(structFiles)
    strImagePath = fullfile(dirname, structFiles(i).name);
    aryImg = aryImg + im2double(imread(strImagePath));
end

% normalize
aryImg = (aryImg - min(aryImg)) ./ (max(aryImg) - min(aryImg));

if ~exist(fullfile('workspace',subdir,'stack'), 'dir')
    mkdir(fullfile('workspace',subdir,'stack'));
end
imwrite(aryImg,fullfile('workspace',subdir,'stack','stack.bmp'));
end

