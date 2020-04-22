function status = MeshImage(aryImg, lenA, lenB, angle, oriX, oriY)
%MESHIMAGE Divide the image into segments usindg the mesh

% first check whether inputs make sense
if oriY < 0
    status = 'seg param error';
    return
end
% if angle > 90 && oriX-lenB*sind(angle-90) < 0
%     status = -1;
%     return
% end

% whole image size
imgXSize = size(aryImg,2);
imgYSize = size(aryImg,1);

% Calculate the segmented image size
if angle < 90
    simgXSize = lenA + lenB*cosd(angle);
    simgYSize = lenB*sind(angle);
else
    simgXSize = lenA + lenB*sind(angle-90);
    simgYSize = lenB*sind(angle);
end

% how many sections in y direction
ny = floor((imgYSize-oriY)/simgYSize);

flagFirstImg = 1;
dimImg = 0;
for iy = 0:(ny-1)
    % in each row, find vertices
    ioriX = oriX + iy*lenB*cosd(angle);
    if angle < 90
        nxlft = floor((ioriX-1)/lenA);
        nxrt = floor((imgXSize-ioriX-lenB*cosd(angle))/lenA);
    else
        nxlft = floor((ioriX+lenB*cosd(angle)-1)/lenA);
        nxrt = floor((imgXSize-ioriX)/lenA);
    end

    for ix = (-nxlft):(nxrt-1)
        % make mask
        maskX = [ioriX+ix*lenA ioriX+(ix+1)*lenA ioriX+(ix+1)*lenA+lenB*cosd(angle) ioriX+ix*lenA+lenB*cosd(angle) ioriX+ix*lenA];
        maskY = [oriY+iy*simgYSize oriY+iy*simgYSize oriY+(iy+1)*simgYSize oriY+(iy+1)*simgYSize oriY+iy*simgYSize];
        aryMask = poly2mask(maskX,maskY,imgXSize,imgYSize);
        % mask the image
        aryMaskedImg = aryImg;
        aryMaskedImg(~aryMask) = 0;
        % trim image
        if angle < 90
            outimg = imcrop(aryMaskedImg,[floor(maskX(1))+0.5,floor(maskY(1))+0.5,simgXSize,simgYSize]);
        else
            outimg = imcrop(aryMaskedImg,[floor(maskX(4))+0.5,floor(maskY(1))+0.5,simgXSize,simgYSize]);
        end
        % check whether image dimension is consistent
        if flagFirstImg
            flagFirstImg = 0;
            dimImg = [size(outimg,1) size(outimg,2)];
        else
            if ~isequal(dimImg,[size(outimg,1) size(outimg,2)])
                fprintf('Warning: Image dimension does not match!!!\n')
            end
        end
        % save image
        if ~exist(fullfile('workspace','output'), 'dir')
            mkdir(fullfile('workspace','output'));
        end
        if any(any(outimg))
            imwrite(outimg, fullfile('workspace','output',strcat('y',num2str(iy),'x',num2str(ix),'.bmp')));
        end
    end
end

status = 'seg success';

end

