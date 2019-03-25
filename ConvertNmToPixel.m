function [pixel,roundnanometer] = ConvertNmToPixel(nanometer)
%CONVERTNMTOPIXEL Converts nanometers to interger pixels
%   Detailed explanation goes here
pixel = round(nanometer/PixSize);
roundnanometer = pixel * PixSize;
end

