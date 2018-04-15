[namafile,direktori]=uigetfile({'*.jpg';'*.bmp';'*.png';'*.tiff'},'Open Image');
image = imread(namafile);
r1=image(:,:,1);
xlswrite('kintil1',r1);