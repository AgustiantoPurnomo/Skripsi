function [gbr2,gbrstg] = stegodwt(original, namafiletxt)
gbrcover=original;
fid = fopen(namafiletxt,'r');
F = fread(fid);
disp(F);
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
        
        %imwrite(uint16(gbrStego*100), 'secretdwt.png');
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
        gbrstg=(idwt2(newhost_LL,i_LH,i_HL,i_HH,'haar'));
        %imwrite(uint16(gbr2*100), 'lala.png');
        
        %extract image
        gbrExtract=gbrstg;
        [w_LL,w_LH,w_HL,w_HH]=dwt2(gbrExtract,'haar');
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
        gbrExtract=idwt2(newstegano_LL,w_LH,w_HL,w_HH,'haar');
        gbr2 = gbrExtract;
        

end
