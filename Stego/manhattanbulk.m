selpath1 = uigetdir;
selpath2 = uigetdir;

imgsz = size(image);
h = imgsz(1);
w = imgsz(2);

for gbr=1:20
    path1 = strcat(selpath1,'\',int2str(gbr),'.bmp');
    image = imread(path1);
    path2 = strcat(selpath2,'\',int2str(gbr),'.bmp');
    image2 = imread(path2);
    imgsz = size(image);
    h = imgsz(1);
    w = imgsz(2);
    a=0;
    for i=1:3
        for y=1:h
            for x=1:w
                p1 = double(image(y,x,i));
                p2 = double(image2(y,x,i));
                a = double(a + abs( p1 - p2 ));
            end
        end
    end
    dist(gbr) = a;
end

%c = sum(sum(distance));