Image = imread('E:\pingpong/mix.jpg');              %read the picture

redlower = [232, 60, 0];
redupper = [250, 255, 255];
redlower = double(redlower)/255;
redupper = double(redupper)/255;

Image_hsv = rgb2hsv(Image);
% Image_hsv = im2uint8(Image_hsv);      %Convert to 8 bitmap
GrayImage= rgb2gray(Image);               %Grayscale
[m,n]=size(GrayImage);                        %Get the size of the grayscale image   
mask = zeros(m,n);
flag_up = 0;

for f_i = 1: m
    for f_j = 1: n
        if ((Image_hsv(f_i, f_j, 1)>=redlower(1)) && (Image_hsv(f_i, f_j, 1)<=redupper(1)) &&....
            (Image_hsv(f_i, f_j, 2)>=redlower(2)) && (Image_hsv(f_i, f_j, 2)<=redupper(2))&&....
            (Image_hsv(f_i, f_j, 3)>=redlower(3)) && (Image_hsv(f_i, f_j, 3)<=redupper(3)))
            if flag_up == 0
                point_up = [f_i, f_j];   %记录最高点，即最顶点坐标
                flag_up = 1;
            end
            mask(f_i, f_j) = 1;
            point_temp = [f_i, f_j];     %循环记录符合颜色的点的最新坐标
        else
            mask(f_i, f_j) = 0;
        end
    end
end

subplot(121),imshow(Image);
title('原图')
subplot(122),imshow(mask);
title('阈值分割二值化')

% point_down = point_temp;          %最新的点的坐标即为最低点坐标
% % mask = bwmorph(mask,'open');  %开运算
% % mask = bwareaopen(mask,20);
% point = [0, 0];
% point(1) = round((point_up(1) + point_down(1)) / 2);    %取中心值，并四舍五入
% point(2) = round((point_up(2) + point_down(2)) / 2);

% figure(1);
% contour1 = bwperim(mask);      %求轮廓
% imshow(contour1);
% 
% L = logical(mask);% 对连通区域进行标记
% stats = regionprops(L);
% Ar = cat(1, stats.Area);
% stats.Area
% ind = find(Ar ==max(Ar));%找到最大连通区域的标号
% ind
% mask(find(L~=ind))=0;%将其他区域置为0
% 
% % figure(2);
% % contour2 = edge(a ,'canny');  
% % imshow(contour2);
% % figure(3);
% % contour3 = edge(a ,'soble'); 
% % imshow(contour3);
%   
% figure(2);
% imshow(Image);
% % hold on
% % plot(point(1), point(2),'g*')
% 
% figure(10);
% imshow(mask);
% % rectangle('position', max_rect, 'EdgeColor', 'r');
