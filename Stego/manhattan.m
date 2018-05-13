[namafile,direktori]=uigetfile({'*.bmp';'*.png'},'Open Image');
fullpath = strcat(direktori,namafile);
image = imread(fullpath);

[namafile2,direktori2]=uigetfile({'*.bmp';'*.png'},'Open Image');
fullpath2 = strcat(direktori2,namafile2);
image2 = imread(fullpath2);

imgsz = size(image);
h = imgsz(1);
w = imgsz(2);
%distance = 1111111;
manhatt = 0;
for i=1:3
    for y=1:h
        for x=1:w
            p1 = double(image(y,x,i));
            p2 = double(image2(y,x,i));
            manhatt = manhatt + abs( p1 - p2 );
        end
    end
end

%c = sum(sum(distance));