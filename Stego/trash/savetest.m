gbr = imread('lena.jpg');
imshow = gbr;

[namafile,direktori]=uiputfile({'*.bmp';'*.jpg';'*.png'},'Simpan Gambar');
imwrite(uint8(gbr), namafile,'Quality',100,'Mode','lossless');
