%requires 4 brightfield and ImageJ-edited fluorescence photos to have more
%than 100 droplets for 150 um diameter droplets

%construct full brightfield microscopy image
image1 = imread('images/lambda=20/brightfield/150um_10x.tif')*3;
image2 = imread('images/lambda=20/brightfield/150um_10x_2.tif')*3;
image3 = imread('images/lambda=20/brightfield/150um_10x_3.tif')*3;
image4 = imread('images/lambda=20/brightfield/150um_10x_4.tif')*3;
image_total = [image1 image2 image3 image4];
%construct full fluorescence image
image_fluor1 = (imread('images/lambda=20/fluor/150um_g_f_10x.jpg'));
image_fluor2 = (imread('images/lambda=20/fluor/150um_g_f_10x_2.jpg'));
image_fluor3 = (imread('images/lambda=20/fluor/150um_g_f_10x_3.jpg'));
image_fluor4 = (imread('images/lambda=20/fluor/150um_g_f_10x_4.jpg'));
image_fluor_total = [image_fluor1 image_fluor2 image_fluor3 image_fluor4];

%detect droplets, may need to change sensitivity parameter to increase
%effectiveness and change diameter range to get within acceptable droplet
%size range
[centers,radii] = imfindcircles(image_total,[60 80],'Sensitivity',0.94);
imshow(image_total)
imshow(image_fluor_total)
hold on
h = viscircles(centers, radii)
num_circles = length(centers);
hold off

%go through each droplet and calculate and track brightness value
intensity_tracker_150um_lambda20 = zeros(num_circles,1);
for n=1:num_circles
    center = centers(n,:);
    radius = radii(n);
    
    [xgrid, ygrid] = meshgrid(1:size(image_total,2), 1:size(image_total,1));
    mask = ((xgrid-center(1,1)).^2 + (ygrid-center(1,2)).^2) <= radius.^2;
    intensity_droplet = (image_fluor_total(mask));
    
    intensity=sum(intensity_droplet);
    norm_intensity = intensity/(radius.^2*pi);
    intensity_tracker_150um_lambda20(n) = norm_intensity;
end