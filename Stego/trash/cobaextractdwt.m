    %image cover
[namafile, direktori] = uigetfile('*.*','Pilih gambar cover');
rgb1=imread(num2str(namafile));
subplot(231),imshow(rgb1),title('Gambar cover');
[i_LL,i_LH, i_HL, i_HH]=dwt2(rgb1,'haar');
img1=i_LL;
r1=img1(:,:,1);
g1=img1(:,:,2);
b1=img1(:,:,3);
[U_imgr1,S_imgr1,V_imgr1]=svd(r1);
[U_imgg1,S_imgg1,V_imgg1]=svd(g1);
[U_imgb1,S_imgb1,V_imgb1]=svd(b1);

%image secret
[namafile, direktori] = uigetfile('*.*','Pilih gambar secret');
rgb2=imread(num2str(namafile));
subplot(232),imshow(rgb2),title('Gambar secret');
[i_LL,i_LH, i_HL, i_HH]=dwt2(rgb2,'haar');
img2=i_LL;
r2=img2(:,:,1);
g2=img2(:,:,2);
b2=img2(:,:,3);
[U_imgr2,S_imgr2,V_imgr2]=svd(r2);
[U_imgg2,S_imgg2,V_imgg2]=svd(g2);
[U_imgb2,S_imgb2,V_imgb2]=svd(b2);

[namafile, direktori] = uigetfile('*.*','Pilih gambar stego');
rgb3=imread(num2str(namafile));
subplot(233),imshow(rgb1),title('Gambar stego');
%extract image
rgbimage=rgb3;
[w_LL,w_LH,w_HL,w_HH]=dwt2(rgbimage,'haar');
img_w=w_LL;
r3=img_w(:,:,1);
g3=img_w(:,:,2);
b3=img_w(:,:,3);
[U_imgr3,S_imgr3,V_imgr3]=svd(r3);
[U_imgg3,S_imgg3,V_imgg3]=svd(g3);
[U_imgb3,S_imgb3,V_imgb3]=svd(b3);

S_ewatr=(S_imgr3-S_imgr1)/0.1;
S_ewatg=(S_imgg3-S_imgg1)/0.1;
S_ewatb=(S_imgb3-S_imgb1)/0.1;

ewatr=U_imgr2*S_ewatr*V_imgr2';
ewatg=U_imgg2*S_ewatg*V_imgg2';
ewatb=U_imgb2*S_ewatb*V_imgb2';

ewat=cat(3,ewatr,ewatg,ewatb);

newstegano_LL=ewat;

rgb2=idwt2(newstegano_LL,w_LH,w_HL,w_HH,'haar');

subplot(234),imshow(uint8(rgb2)),title('Gambar hasil extract');

[namafile,direktori]=uiputfile({'*.bmp';'.png'},'Simpan Gambar');
imwrite(uint8(rgb2), namafile);
