%%for lambda=5
%construct full brightfield microscopy image
image = imread('images/lambda=5/brightfield/55um_10x.tif')*3;
%construct full fluorescence image
image_fluor = (imread('images/lambda=5/fluor/55um_g_f_10x.jpg'));

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
intensity_tracker_55um_lambda5 = zeros(num_circles,1);
for n=1:num_circles
    center = centers(n,:);
    radius = radii(n);
    
    [xgrid, ygrid] = meshgrid(1:size(image,2), 1:size(image,1));
    mask = ((xgrid-center(1,1)).^2 + (ygrid-center(1,2)).^2) <= radius.^2;
    intensity_droplet = (image_fluor(mask));
    
    intensity=sum(intensity_droplet);
    norm_intensity = intensity/(radius.^2*pi);
    intensity_tracker_55um_lambda5(n) = norm_intensity;
end