%construct full brightfield microscopy image
image = imread('images/brightfield/20190611_55um.BMP');
%construct full fluorescence image
image_fluor = (imread('images/fluor/C2-20190611_55um_f.jpg'));

%detect droplets, may need to change sensitivity parameter to increase
%effectiveness
[centers,radii] = imfindcircles(image,[20 40],'Sensitivity',0.90);
imshow(image)
imshow(image_fluor)
hold on
h = viscircles(centers, radii)
num_circles = length(centers);
hold off

%go through each droplet and calculate and track brightness value
intensity_tracker_55um = zeros(num_circles,1);
for n=1:num_circles
    center = centers(n,:);
    radius = radii(n);
    
    [xgrid, ygrid] = meshgrid(1:size(image,2), 1:size(image,1));
    mask = ((xgrid-center(1,1)).^2 + (ygrid-center(1,2)).^2) <= radius.^2;
    intensity_droplet = (image_fluor(mask));
    
    intensity=sum(intensity_droplet);
    norm_intensity = intensity/(radius.^2*pi);
    intensity_tracker_55um(n) = norm_intensity;
end