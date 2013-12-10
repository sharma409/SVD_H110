% Reads an image and returns its representation
% as a matrix of double values.
function img_double = get_image_mat(file_name,show)

	if (nargin < 1)
		file_name = 'campanile.jpg'
	elseif (strcmp(file_name,''))
		file_name = 'campanile.jpg';
	end

	img = imread(file_name);
	gray_img = rgb2gray(img);
	img_double = im2double(gray_img);
	if (show ~= 0)
		imshow(img_double);
	end