% Coded by Sufiyan Ghori
% xufyan@gmail.com
clear all
close all
Text='yuiop'; %This is the text to hide.
wavename = 'haar';
% Matrix equals to the lengh of message.
data = zeros(1,length(Text));
% length of Text = 19
% Now lets store the message in to the Matrix of size 1x19 but we need to
% first convert the message into ASCII characters.
% Adding zero to each character of message will convert it
% into its ASCII equivalent.
for i = 1 : length(Text)
 d = Text(i) + 0; % for example -> r + 0 = 114 (ASCII of r)
 % Now store all the ASCII value into a single matrix
 data(i) = d;
% Output =>
%[71 114 97 115 115 104 111 112 112 101 114 32 78 101 116 119 111 114 107]
end
im = imread('cameraman.tif');
% imshow(im),title('Original Image')
[cA1,cH1,cV1,cD1] = dwt2(im,wavename);
A1 = upcoef2('a',cA1,wavename,1);
H1 = upcoef2('h',cH1,wavename,1);
V1 = upcoef2('v',cV1,wavename,1);
D1 = upcoef2('d',cD1,wavename,1);
% To display the results of the level 1 decomposition, type:
% subplot(2,2,1); image(wcodemat(A1,192));
% title('Approximation A1')
% 
% subplot(2,2,2); image(wcodemat(H1,192));
% title('Horizontal Detail H1')
%
% subplot(2,2,3); image(wcodemat(V1,192));
% title('Vertical Detail V1')
%
% subplot(2,2,4); image(wcodemat(D1,192));
% title('Diagonal Detail D1')
M=max(data); % Maximum value = 119
normalize = data/M; % Divide each ASCII char by maximum ASCII value
n=length(data); % Get the length of the data matrix => 19
% cH1(1,1) = 0.500
% cH1(1,2) = -1
cH1(1,1) = -1*(n/10); % -1x(19/10)
cH1(1,2) = -1*(M/10); % -1x(119/10)
% cH1(1,1) = -1.9000
% cH1(1,2) = -11.9000
 % cH1(1,1) => from 0.500 to -1.9000
% cH1(1,2) => from -1 to -11.9000
[~ , y]=size(cH1); % Siz of Horizontal Details => 135 for later use
% Now let's hide the data in the Vertical details
% Eventhough we have total 19 chars but
% Right now we're hiding just first 10 characters
for i = 1 : ceil(n/2) % 19/2 = 10 <- Loop just 10 times (1 to 10)
 % Data will be hidden on (1,135),(2,135),(3,135)......(10,135)
 cV1(i,y)= normalize(i); %
end
% Let's hide the remaining 19 characters in Diognal details.
for i = ceil(n/2) + 1 : n % start from 11 and ends on 19
 % Data will be hidden on (11,135),(12,135),(13,135)......(19,135)
 cD1(i,y)=normalize(i);
end
figure;
Restore = idwt2 (cA1,cH1,cV1,cD1,wavename);
%imshow(uint8(im));
imshow(uint8(Restore));
%------------------------------------
%------------------------------------
%------------------------------------
%------------------------------------
%------------------------------------
%------------------------------------
%------------------------------------
%------------------------------------
%------------------------------------
%------------------------------------
%------------------------------------
%------------------------------------
%------------------------------------
%------------------------------------
%------------------------------------
[cA1r,cH1r,cV1r,cD1r] = dwt2 (Restore,wavename);
n = ceil ( abs((cH1r(1,1)*10)) );
M = ceil ( abs((cH1r(1,2)*10)) );
data = zeros(1,length(n));
normalize = zeros(1,length(n));
[x y]=size(cH1r);
 for i = 1 : ceil(n/2)
 normalize(i) = cV1r(i,y);
 end
 for i = ceil(n/2)+1 : n
 normalize(i) = cD1r(i,y);
 data = normalize * M;
 end

 Text1='';
 for i = 1 : length(data)
 Text1 = horzcat(Text1,floor(data(i))); %horzcat is better than strcat
 end
%Text1