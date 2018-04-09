%image cover
[namafile, direktori] = uigetfile('*.*','Pilih gambar cover');
gbrCover=imread(num2str(namafile));
subplot(231),imshow(gbrCover),title('Gambar cover');

%image secret lsb
gbrlsb=gbrCover;
gbrlsb(:,:,1)=0;
gbrlsb(:,:,2)=0;
gbrlsb(:,:,3)=0;

sz1=size(gbrlsb);
size1=sz1(1)*sz1(2);
sz2=size(F);
size2=sz2(1);

gbrStego = stegolsb(gbrlsb,namafiletxt);

subplot(232),imshow(gbrStego),title('Gambar cover');

%dwt2 cover
[i_LL,i_LH, i_HL, i_HH]=dwt2(rgbimage1,'haar');
img=i_LL;
r1=img(:,:,1);
g1=img(:,:,2);
b1=img(:,:,3);
[U_imgr1,S_imgr1,V_imgr1]=svd(r1);
[U_imgg1,S_imgg1,V_imgg1]=svd(g1);
[U_imgb1,S_imgb1,V_imgb1]=svd(b1);

%dwt2 secret
[i_LL,i_LH, i_HL, i_HH]=dwt2(gbrStego,'haar');
img=i_LL;
r2=img(:,:,1);
g2=img(:,:,2);
b2=img(:,:,3);
[U_imgr2,S_imgr2,V_imgr2]=svd(r2);
[U_imgg2,S_imgg2,V_imgg2]=svd(g2);
[U_imgb2,S_imgb2,V_imgb2]=svd(b2);
%[namafile, direktori] = uigetfile('*.*','Buka Teks');
%teks = fopen(namafile,'r');
%charteks = fread(teks,'uint8=>char');
%biner = dec2bin(charteks,8);

%stego dwt
S_wimgr=S_imgr1+(0.1*S_imgr2);
S_wimgg=S_imgg1+(0.1*S_imgg2);
S_wimgb=S_imgb1+(0.1*S_imgb2);

wimgr=U_imgr1*S_wimgr*V_imgr1';
wimgg=U_imgg1*S_wimgg*V_imgg1';
wimgb=U_imgb1*S_wimgb*V_imgb1';

wimg=cat(3,wimgr,wimgg,wimgb);
newhost_LL=wimg;
gbrStego2=idwt2(newhost_LL,i_LH,i_HL,i_HH,'haar');
xlswrite('kintil1',r1);
subplot(233),imshow(uint8(gbrStego2)),title('Gambar hasil stego');

%extract image
gbrExtract=gbrStego2;
[w_LL,w_LH,w_HL,w_HH]=dwt2(gbrExtract,'haar');
img_w=w_LL;
r3=img_w(:,:,1);
g3=img_w(:,:,2);
b3=img_w(:,:,3);
[U_imgr3,S_imgr3,V_imgr3]=svd(r3);
[U_imgg3,S_imgg3,V_imgg3]=svd(g3);
[U_imgb3,S_imgb3,V_imgb3]=svd(b3);

%U_ewatr=(U_imgr3-U_imgr1)/0.1;
%U_ewatg=(U_imgg3-U_imgg1)/0.1;
%U_ewatb=(U_imgb3-U_imgb1)/0.1;

S_ewatr=(S_imgr3-S_imgr1)/0.1;
S_ewatg=(S_imgg3-S_imgg1)/0.1;
S_ewatb=(S_imgb3-S_imgb1)/0.1;

%V_ewatr=(V_imgr3-V_imgr1)/0.1;
%V_ewatg=(V_imgg3-V_imgg1)/0.1;
%V_ewatb=(V_imgb3-V_imgb1)/0.1;

ewatr=U_imgr2*S_ewatr*V_imgr2';
ewatg=U_imgg2*S_ewatg*V_imgg2';
ewatb=U_imgb2*S_ewatb*V_imgb2';

%ewatr=U_ewatr*S_ewatr*V_ewatr';
%ewatg=U_ewatg*S_ewatg*V_ewatg';
%ewatb=U_ewatb*S_ewatb*V_ewatb';

%ewatr=U_imgr2*S_imgr2*V_imgr2';
%ewatg=U_imgg2*S_imgg2*V_imgg2';
%ewatb=U_imgb2*S_imgb2*V_imgb2';

ewat=cat(3,ewatr,ewatg,ewatb);

newstegano_LL=ewat;

gbrExtract=idwt2(newstegano_LL,w_LH,w_HL,w_HH,'haar');

subplot(234),imshow(uint8(gbrExtract)),title('Gambar hasil extract');

[namafile,direktori]=uiputfile({'*.bmp';'.png'},'Simpan Gambar');
imwrite(uint8(rgb2), namafile);

textbin = ExtractLsb(img);

[namafile,direktori]=uiputfile('*.txt','Simpan teks');
teks = fopen(namafile,'w');
pesan = get(proyek.textlist,'Userdata');
fprintf(teks,pesan);
fclose(teks);


function gbr2 = stegodwt(original, namafiletxt)
gbrcover=original;
fid = fopen(namafiletxt,'r');
F = fread(fid);
fclose(fid);

%initialize secret's img size
gbrlsb=original;
gbrlsb(:,:,1)=0;
gbrlsb(:,:,2)=0;
gbrlsb(:,:,3)=0;

sz1=size(gbrlsb);
size1=sz1(1)*sz1(2);
sz2=size(F);
size2=sz2(1);

gbrStego = stegolsb(gbrlsb,namafiletxt);
        
        imwrite(uint16(gbrStego*100), 'secretdwt.png');
        %[namafile,direktori]=uiputfile({'*.bmp';'*.jpg';'*.png'},'Simpan Gambar');
        %imwrite(uint8(gbrStego), namafile);
        
        %cover image dwt2
        [i_LL,i_LH, i_HL, i_HH]=dwt2(gbrcover,'haar');
        img1=i_LL;
        r1=img1(:,:,1);
        g1=img1(:,:,2);
        b1=img1(:,:,3);
        [U_imgr1,S_imgr1,V_imgr1]=svd(r1);
        [U_imgg1,S_imgg1,V_imgg1]=svd(g1);
        [U_imgb1,S_imgb1,V_imgb1]=svd(b1);

        
        %secret image dwt2
        [i_LL,i_LH, i_HL, i_HH]=dwt2(gbrStego,'haar');
        img2=i_LL;
        r2=img2(:,:,1);
        g2=img2(:,:,2);
        b2=img2(:,:,3);
        [U_imgr2,S_imgr2,V_imgr2]=svd(r2);
        [U_imgg2,S_imgg2,V_imgg2]=svd(g2);
        [U_imgb2,S_imgb2,V_imgb2]=svd(b2);
        
        %stego dwt
        S_wimgr=S_imgr1+(0.1*S_imgr2);
        S_wimgg=S_imgg1+(0.1*S_imgg2);
        S_wimgb=S_imgb1+(0.1*S_imgb2);

        wimgr=U_imgr1*S_wimgr*V_imgr1';
        wimgg=U_imgg1*S_wimgg*V_imgg1';
        wimgb=U_imgb1*S_wimgb*V_imgb1';

        wimg=cat(3,wimgr,wimgg,wimgb);
        newhost_LL=wimg;
        gbr2=idwt2(newhost_LL,i_LH,i_HL,i_HH,'haar');
        imwrite(uint16(gbr2*100), 'kontol.png');
end
