selpath1 = uigetdir;
selpath2 = uigetdir;
for gbr=1:20
    path1 = strcat(selpath1,'\',int2str(gbr),'.bmp');
    image = imread(path1);
    path2 = strcat(selpath2,'\',int2str(gbr),'.bmp');
    image2 = imread(path2);
    n=size(image);
    M=n(1);
    N=n(2);
    MSE = sum(sum((image-image2).^2))/(M*N);
    PSNR = 10*log10(256*256/MSE);
    resultmse(gbr) = a;
    resultpsnr(gbr) = a;
end