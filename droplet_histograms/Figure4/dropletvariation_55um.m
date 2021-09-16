%for normal microscopy image
image = imread('55um/NoAA_55um_1.BMP');
%for fluorescence image
image_fluor = (imread('55um/NoAA_55um_1-f.jpg'));
%detect droplets, may need to change sensitivity parameter to increase
%effectiveness
[centers,radii] = imfindcircles(image,[21 30],'Sensitivity',0.90);
imshow(image)
imshow(image_fluor)
hold on
h = viscircles(centers, radii)
num_circles = length(centers);
hold off

intensity_tracker_55um = zeros(num_circles,1);

%go through each droplet and calculate and track brightness value
for n=1:num_circles
    center = centers(n,:);
    radius = radii(n);
    
    [xgrid, ygrid] = meshgrid(1:size(image,2), 1:size(image,1));
    mask = ((xgrid-center(1,1)).^2 + (ygrid-center(1,2)).^2) <= radius.^2;
    intensity_droplet = (image_fluor(mask));
    
    intensity=sum(intensity_droplet);
    norm_intensity = intensity/(radius.^2*pi);
    intensity_tracker_55um(n) = norm_intensity;
    %intensity_tracker_55um(n) = intensity;
end

%make histogram
%droplet_average=mean(intensity_tracker_55um)
%droplet_std=std(intensity_tracker_55um)
%histogram(intensity_tracker_55um)