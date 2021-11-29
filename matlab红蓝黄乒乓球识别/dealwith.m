function [num, plot_x, plot_y, r, mask] = dealwith(Image_hsv, redlower, redupper)
    flag_exit = 0;      %用于检测是否有对应颜色的像素点，避免后面找连通域时对比矩阵不一致
    redlower = double(redlower)/255;        %需要将uint8像素转为double
    redupper = double(redupper)/255;        %需要将uint8像素转为double
    [m, n, o]=size(Image_hsv);                        %Get the size of the grayscale image 
    mask = zeros(m,n);                              %生成掩膜空矩阵
    
    %   对图片进行遍历，若某像素点符合该像素范围，则该店像素为255（归一化为1）
    %   否则为0
    for f_i = 1: m
        for f_j = 1: n
            if ((Image_hsv(f_i, f_j, 1)>=redlower(1)) && (Image_hsv(f_i, f_j, 1)<=redupper(1)) &&....
                (Image_hsv(f_i, f_j, 2)>=redlower(2)) && (Image_hsv(f_i, f_j, 2)<=redupper(2))&&....
                (Image_hsv(f_i, f_j, 3)>=redlower(3)) && (Image_hsv(f_i, f_j, 3)<=redupper(3)))     
                flag_exit = 1;                      %至少找到一个连通域  
                mask(f_i, f_j) = 1;             %符合像素范围，像素为1
            else
                mask(f_i, f_j) = 0;             %不符合像素范围，像素为0
            end
        end
    end
    [num, plot_x, plot_y, r, mask]= Maximum_area(mask, flag_exit);        %找最大面积
end

