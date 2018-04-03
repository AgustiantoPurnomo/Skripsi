image=zeros(512,512,3); %initialize
image(:,:,1)=0;
image(:,:,2)=0;
image(:,:,3)=0;

image(1:10,1:10,1)=100;

figure, imshow(image);