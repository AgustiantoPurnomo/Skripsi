function stego = stegoDWT2(filein,message,bitdepth)
image = filein;
fid = fopen(message,'r');
F = fread(fid);
fclose(fid);
message = double(F');

sz1=size(filein);
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

    els = {'p',[-0.125 0.125],0};
    lshaarInt = liftwave('haar','int2int');
    lsnewInt = addlift(lshaarInt,els);
    [LL,LH,HL,HH] = lwt2(double(image),lsnewInt);

    col = size(LH,2);
    r = 1;
    c = 1;

    for i = 1:length(message);
        letter = message(i);
        for b = 8:-1:1;
            LH(r,c) = bitset(LH(r,c),1,bitget(letter,b,'int16'),'int16');
            c = c + 1;
            if (c > col)
                r = r + 1;
                c = 1;
            end
        end
    end

    stego = ilwt2(LL,LH,HL,HH,lsnewInt);

    txtsz=size2;
    n=size(stego);
    stego(n(1),n(2),1)=txtsz;% Text Size

    if(strcmp(bitdepth,'int8'))
        stego = uint8(stego);
    else
        stego = uint16(stego);
    end
    %imshow(stego);
    %imwrite(stego,fileout);
end