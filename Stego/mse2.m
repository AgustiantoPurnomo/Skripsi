selpath1 = uigetdir;
selpath2 = uigetdir;
for gbr=1:40
    path1 = strcat(selpath1,'\',int2str(gbr),'.bmp');
    image = imread(path1);
    path2 = strcat(selpath2,'\lsb-',int2str(gbr),'.bmp');
    image2 = imread(path2);

    thePSNR(gbr) = psnr(image2, image);
    %disp(thePSNR(gbr));
    theMSE(gbr) = immse(image2, image);
    %disp(theMSE(gbr))
end