obj = VideoReader('pingpong.mp4');
frame = readframe(obj);
redlower = [100, 0, 0];
redupper = [150, 255, 255];

while(1)
    img = snapshot(cam);
    Image_hsv = rgb2hsv(img);
    [point, mask] = dealwith(Image_hsv, redlower, redupper);
    subplot(1,2,1),  imshow(imresize(img, [600, 600]));
    subplot(1,2,2),  imshow(imresize(mask, [600, 600]));
%     hold on
%     plot(point(1), point(2),'r+')
end

