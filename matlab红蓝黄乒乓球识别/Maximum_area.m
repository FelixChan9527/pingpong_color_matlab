function [num, plot_x, plot_y, r, mask] = Maximum_area(mask, flag_exit)
    [height, width] = size(mask);
    r_x = 0;r_y = 0;r_flag = 0;
    if(flag_exit == 1)  %当找到有连通域，即可找最大连通域
        mask = bwareaopen(mask, 2000);
        [L,num]=bwlabel(mask, 8);%bwlabel标注二值图像I_bw中的目标物体，返回标识矩阵Ｌ和I_bw中目标物体的数量num，８表示连通数．
        r = zeros(1, num);
        plot_x=zeros(1,num);%%zeros(m,n)产生m×n的全0矩阵．用于记录质心位置的横坐标
        plot_y=zeros(1,num);%zeros(m,n)产生m×n的全0矩阵．用于记录质心位置的纵坐标
        for k=1:num  %num个区域依次统计质心位置    
            sum_x=0;sum_y=0;area=0; %初始化
            for i=1:height  
                for j=1:width
                    if L(i,j)==k
                        if r_flag == 0
                            r_x = i;
                            r_y = j;
                            r_flag = 1;
                        end
                        sum_x=sum_x+i;  %计算第Ｋ区域的横坐标总和
                        sum_y=sum_y+j;  %计算第Ｋ区域的纵坐标总和 
                        area=area+1;    %计算第Ｋ区域的由多少个坐标点表示
                    end
                end
            end
            plot_x(k)=fix(sum_x/area);  %计算第Ｋ区域的质心横坐标
            plot_y(k)=fix(sum_y/area);%计算第Ｋ区域的质心纵坐标
            r(k) = sqrt((r_x-plot_x(k))^2+(r_y-plot_y(k))^2);
            r_flag = 0;
        end
    end
end

