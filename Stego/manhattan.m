[namafile,direktori]=uigetfile({'*.bmp';'*.png'},'Open Image');
fullpath = strcat(direktori,namafile);
image = imread(fullpath);

[namafile2,direktori2]=uigetfile({'*.bmp';'*.png'},'Open Image');
fullpath2 = strcat(direktori2,namafile2);
image2 = imread(fullpath2);

imgsz = size(image);
h = imgsz(1);
w = imgsz(2);
imgr1 = image(:,:,1);
imgr2 = image2(:,:,1);
distance = zeros(h,w);
for y=1:h
    for x=1:w
        p1 = imgr1(y,x);
        p2 = imgr2(y,x);
        distance(y,x) = abs( p1 - p2 );
    end
end

c = sum(sum(distance));