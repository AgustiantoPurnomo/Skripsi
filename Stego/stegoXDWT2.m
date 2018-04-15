function textSec = stegoXDWT2(filename,bitdepth)
image = uint16(filename);

n=size(image);
disp(n);
messageLength=image(n(1),n(2),1); % Text Size

els = {'p',[-0.125 0.125],0};
lshaarInt = liftwave('haar','int2int');
lsnewInt = addlift(lshaarInt,els);
[LL,LH,HL,HH] = lwt2(double(image),lsnewInt);

col = size(LH,2);
r = 1;
c = 1;

secret = zeros(messageLength,1);
for i = 1:messageLength;
    letter = 0;
    for b = 8:-1:1;
        letter = bitset(letter,b,bitget(LH(r,c),1,'int16'));
        c = c + 1;
        if (c > col)
            r = r + 1;
            c = 1;
        end
    end
    secret(i) = char(letter);
end
textSec = char(secret');
end