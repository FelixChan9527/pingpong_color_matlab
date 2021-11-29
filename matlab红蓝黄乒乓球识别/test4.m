obj = VideoReader('pingpong3.mp4');     % 添加对应的视频文件，也可以改为摄像头

num = obj.NumberOfFrames;   % 获取视频帧
color_flag = 1;
lower = zeros(1, 3);
upper = zeros(1, 3);

redlower = [185, 50, 0];    % 红蓝黄色阈值
redupper = [255, 255, 255];
bluelower = [130, 100, 20];
blueupper = [150, 255, 255];
yellolower = [5, 190, 80];
yelloupper = [50, 255, 255];

position_x = [];    % 用于存储识别后的球的质心坐标X轴的空数组
position_y = [];    % 用于存储识别后的球的质心坐标Y轴的空数组
pr = 1;

for i = 1: num
    frame = read(obj, i);   %读取第几帧
    mask = rgb2hsv(frame);  % 图像从RGB空间转HSV
    [number_r, plot_x_r, plot_y_r, r_r, mask_r] = dealwith(mask, redlower, redupper);   %   对图像分别取三次阈值掩膜以获得三种不同颜色的识别效果
    [number_b, plot_x_b, plot_y_b, r_b, mask_b] = dealwith(mask, bluelower, blueupper);
    [number_y, plot_x_y, plot_y_y, r_y, mask_y] = dealwith(mask, yellolower, yelloupper);
    figure(2);
    imshow(frame);% 显示帧
    for j=1:number_r  % 红色处理              
        hold  on
        plot(plot_y_r(j) ,plot_x_r(j), '*')
        num_color = ['red', num2str(j)];
        text(plot_y_r(j),plot_x_r(j),num_color,'horiz','center','color','k','FontSize',20); % 写出小球的位置
        
        theta = 0:2*pi/3600:2*pi;                   % 由半径及质心坐标计算并画出圆的轮廓
        Circle1 = plot_y_r(j) + r_r(j)*cos(theta);  % 由半径及质心坐标计算并画出圆的轮廓
        Circle2 = plot_x_r(j) + r_r(j)*sin(theta);  % 由半径及质心坐标计算并画出圆的轮廓
        plot(Circle1,Circle2,'--k')
%         if rem(i, 1) == 0
%             position_x(pr) = plot_x_r(1);
%             position_y(pr) = plot_y_r(1);
%             pr = pr+1;
%         end
    end
    for j=1:number_b
        hold  on
        plot(plot_y_b(j) ,plot_x_b(j), '*')
        num_color = ['blue', num2str(j)];
        text(plot_y_b(j),plot_x_b(j),num_color,'horiz','center','color','k','FontSize',20);
        theta = 0:2*pi/3600:2*pi;
        Circle1 = plot_y_b(j) + r_b(j)*cos(theta);
        Circle2 = plot_x_b(j) + r_b(j)*sin(theta);
        plot(Circle1,Circle2,'--k')
%         if rem(i, 1) == 0
%             position_x(pr) = plot_x_r(1);
%             position_y(pr) = plot_y_r(1);
%             pr = pr+1;
%         end
    end
    for j=1:number_y
        hold  on
        plot(plot_y_y(j) ,plot_x_y(j), '*')
        num_color = ['yellow', num2str(j)];
        text(plot_y_y(j),plot_x_y(j),num_color,'horiz','center','color','k','FontSize',20);
        theta = 0:2*pi/3600:2*pi;
        Circle1 = plot_y_y(j) + r_y(j)*cos(theta);
        Circle2 = plot_x_y(j) + r_y(j)*sin(theta);
        plot(Circle1,Circle2,'--k')
        if rem(i, 1) == 0
            position_x(pr) = plot_x_y(1);
            position_y(pr) = plot_y_y(1);
            pr = pr+1;
        end
    end
    
    for pp = 2: pr
        plot(position_y(pp-1) ,position_x(pp-1), '*')
    end
    
    text(1100, 20, 'Positions: ','horiz','center','color','k','FontSize',15);
    text(1105, 40, ['Red:R1:(',num2str(plot_x_r(1)),', ',num2str(plot_y_r(1)),')'] ,'horiz','center','color','k','FontSize',15);
    text(1105, 60, ['Red:R2:(',num2str(plot_x_r(2)),', ',num2str(plot_y_r(2)),')'],'horiz','center','color','k','FontSize',15);
    text(1105, 80, ['Blue:B1:(',num2str(plot_x_b(1)),', ',num2str(plot_y_b(1)),')'],'horiz','center','color','k','FontSize',15);
    text(1105, 100,['Blue:B2:(',num2str(plot_x_b(2)),', ',num2str(plot_y_b(2)),')'],'horiz','center','color','k','FontSize',15);
    text(1105, 120,['Yellow:Y1:(',num2str(plot_x_y(1)),', ',num2str(plot_y_y(1)),')'],'horiz','center','color','k','FontSize',15);
    text(1105, 140,['Yellow:Y2:(',num2str(plot_x_y(2)),', ',num2str(plot_y_y(2)),')'],'horiz','center','color','k','FontSize',15);
    text(1105, 160,['Total: ',num2str(number_r+number_b+number_y)],'horiz','center','color','k','FontSize',15);
end

