load math_logo
im = math_logo;
IM = fftshift(fft2(ifftshift(im)));
maxIM = max(max(abs(IM)));
shiftim = circshift(circshift(im,5,2),10,1);
figure(1); colormap gray;
subplot(121); imagesc(im);
axis image; title('im')
colorbar('SouthOutside')
subplot(122); imagesc(shiftim);
axis image; title('shifted im')
colorbar('SouthOutside')

% Transforms of im
figure(2); colormap gray;
subplot(221); imagesc(abs(IM), [0 0.02*maxIM]);
axis image; colorbar; title('abs(F[im])')
subplot(222); imagesc(angle(IM), [-pi pi]);
axis image; colorbar; title('angle(F[im])')
subplot(223); imagesc(real(IM), [-0.02*maxIM 0.02*maxIM]);
axis image; colorbar; title('real(F[im])')
subplot(224); imagesc(imag(IM), [-0.02*maxIM 0.02*maxIM]);
axis image; colorbar; title('imag(F[im])')

% Transforms of shiftim
figure(3);
colormap(gray);
SHIFTIM = fftshift(fft2(ifftshift(shiftim)));
% the maximum shouldn't have changed in this particular
% case but we recalculate it anyway
maxSHIFTIM = max(max(abs(SHIFTIM)));
subplot(221); imagesc(abs(SHIFTIM), [0 0.02*maxSHIFTIM]);
axis image; colorbar; title('abs(F[shiftim])')
subplot(222); imagesc(angle(SHIFTIM), [-pi pi]);
axis image; colorbar; title('angle(F[shiftim])')
subplot(223); imagesc(real(SHIFTIM), [-0.02*maxSHIFTIM 0.02*maxSHIFTIM]);
axis image; colorbar; title('real(F[shiftim])')
subplot(224); imagesc(imag(SHIFTIM), [-0.02*maxSHIFTIM 0.02*maxSHIFTIM]);
axis image; colorbar; title('imag(F[shiftim])')

image_sum = sum(sum(im))
fprintf('Image sum: %d\n', image_sum)

