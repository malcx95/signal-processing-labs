load peppersmall 
im = peppersmall;

myradius = 25

aver = [1 2 1; 2 4 2; 1 2 1]/16;
aver3 = conv2(conv2(aver,aver,'full'),aver,'full');
aver3im = 0*im;
center = size(im,1)/2+1;
IM = fftshift(fft2(ifftshift(im)));

half = (size(im,1)-1)/2;
[u,v] = meshgrid(-ceil(half):floor(half),-ceil(half):floor(half));
IDEALFILT = sqrt(u.^2+v.^2) < myradius;

RESULT = IM .* IDEALFILT;

idealfilt = fftshift(ifft2(ifftshift(IDEALFILT)));
result = fftshift(ifft2(ifftshift(RESULT)));

maxIM = max(max(abs(IM)));
figure(1); colormap gray;
subplot(131); imagesc(im);
axis image; title('im'); colorbar('SouthOutside')
subplot(132); imagesc(idealfilt);
axis image; title('idealfilt'); colorbar('SouthOutside')
subplot(133); imagesc(result);
axis image; title('result'); colorbar('SouthOutside')
figure(2); colormap gray;
subplot(131); imagesc(abs(IM), [0 0.01*maxIM]);
axis image; title('abs(F[im])'); colorbar('SouthOutside')
subplot(132); imagesc(abs(IDEALFILT));
axis image; title('abs(F[idealfilt])'); colorbar('SouthOutside')
subplot(133); imagesc(abs(RESULT), [0 0.01*maxIM]);
axis image; title('abs(F[result])'); colorbar('SouthOutside')
