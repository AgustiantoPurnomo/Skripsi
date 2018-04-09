function gbr2=stegolsb(original,namafiletxt)
target = original;
fid = fopen(namafiletxt,'r');
F = fread(fid);
fclose(fid);

sz1=size(original);
size1=sz1(1)*sz1(2);
sz2=size(F);
size2=sz2(1);


if size2> size1 
    fprintf('\nImage File Size  %d\n',size1);
    fprintf('Text  File Size  %d\n',size2);
    disp('Text File is too Large');
else
    fprintf('\nImage File Size  %d\n',size1);
    fprintf('Text  File Size  %d\n',size2);
    disp('Text File is Small');
    
    i=1;j=1;k=1;
        while k<=size2
        a=F(k);
        o1=original(i,j,1);
        o2=original(i,j,2);
        o3=original(i,j,3);
        
        [r1,r2,r3]=hidetext(o1,o2,o3,a); 
        
        target(i,j,1)=r1;
        target(i,j,2)=r2;
        target(i,j,3)=r3;
        
            if(i<sz1(1))
                i=i+1;
            else
                i=1;
                j=j+1;
            end
            k=k+1;
        end
        width=sz1(1);
        txtsz=size2;
        n=size(original);
        target(n(1),n(2),1)=txtsz;% Text Size
        target(n(1),n(2),2)=width;% Image's Width
        disp(k);
        
        %save secret.mat target;% txtsz width;
       gbr2 = target;
    
end
