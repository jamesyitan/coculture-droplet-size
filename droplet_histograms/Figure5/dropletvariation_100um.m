%for normal microscopy image
image1 = imread('100um/NoAA_100um_1.BMP');
image2 = imread('100um/NoAA_100um_4.BMP');
image3 = imread('100um/NoAA_100um_7.BMP');
image_total = [image1 image2 image3];
%for fluorescence image
image_fluor1 = (imread('100um/NoAA_100um_1-f.jpg'));
image_fluor2 = (imread('100um/NoAA_100um_4-f.jpg'));
image_fluor3 = (imread('100um/NoAA_100um_7-f.jpg'));
image_fluor_total = [image_fluor1 image_fluor2 image_fluor3];
%detect droplets, may need to change sensitivity parameter to increase
%effectiveness
[centers,radii] = imfindcircles(image_total,[40 60],'Sensitivity',0.90);
imshow(image_total)
imshow(image_fluor_total)
hold on
h = viscircles(centers, radii);
num_circles = length(centers);
hold off

intensity_tracker_100um = zeros(num_circles,1);

%go through each droplet and calculate and track brightness value
for n=1:num_circles
    center = centers(n,:);
    radius = radii(n);
    
    [xgrid, ygrid] = meshgrid(1:size(image_total,2), 1:size(image_total,1));
    mask = ((xgrid-center(1,1)).^2 + (ygrid-center(1,2)).^2) <= radius.^2;
    intensity_droplet = (image_fluor_total(mask));
    
    intensity=sum(intensity_droplet);
    norm_intensity = intensity/(radius.^2*pi);
    intensity_tracker_100um(n) = norm_intensity;
    %intensity_tracker_100um(n) = intensity;
end

%make histogram
%droplet_average=mean(intensity_tracker_100um)
%droplet_std=std(intensity_tracker_100um)
%figure
%histogram(intensity_tracker_100um)