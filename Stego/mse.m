selpath1 = uigetdir;
selpath2 = uigetdir;
for gbr=1:40
    path1 = strcat(selpath1,'\',int2str(gbr),'.png');
    image = imread(path1);
    path2 = strcat(selpath2,'\lsb-',int2str(gbr),'.png');
    image2 = imread(path2);
    n=size(image);
    M=n(1);
    N=n(2);
    MSE = sum(sum((image-image2).^2))/(M*N);
    PSNR = 10*log10(256*256/MSE);
    %fprintf('\nMSE: %7.2f ', MSE);
    %fprintf('\nPSNR: %9.7f dB', PSNR);
    %resultmse(gbr) = MSE(1); %dwt
    %resultpsnr(gbr) = PSNR(1); %dwt
    resultmse(gbr) = mean(MSE); %lsb
    resultpsnr(gbr) = mean(PSNR); %lsb
end