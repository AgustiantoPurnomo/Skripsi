[namafile, direktori] = uigetfile('*.txt','Buka Teks');
teks = fopen(namafile,'r');
charteks = fread(teks,'uint8=>char');
biner = dec2bin(charteks,8);
disp(biner);