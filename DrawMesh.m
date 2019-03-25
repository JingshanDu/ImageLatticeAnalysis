function status = DrawMesh(aryImg, lenA, lenB, angle, oriX, oriY)
%DRAWMESH Calc and draw the defined mesh on the image

hold on
% first check whether inputs make sense
if oriY < 0
    status = 'draw param error';
    return
end
% if angle > 90 && oriX-lenB*sind(angle-90) < 0
%     status = -1;
%     return
% end
% whole image size
imgXSize = size(aryImg,2);
imgYSize = size(aryImg,1);

% horizontal lines
stepky = lenB*sind(angle);
for ky = oriY:stepky:imgYSize
    lx = [1 imgXSize];
    ly = [ky ky];
    plot(lx,ly,'Color','y','LineStyle','-');
end

% tilted vertical lines
for kx = (oriX-lenA*floor(imgXSize/lenA)):lenA:(imgXSize*(1+imgXSize/lenA))
lx = [kx kx+(imgYSize-oriY)*cotd(angle)];
ly = [oriY imgYSize];
plot(lx,ly,'Color','y','LineStyle','-');
end

status = 'draw success';
end