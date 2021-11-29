obj = VideoReader('pingpong3.mp4');
num = obj.NumberOfFrames;
color_flag = 1;
lower = zeros(1, 3);
upper = zeros(1, 3);


redlower = [185, 50, 0];
redupper = [255, 255, 255];
bluelower = [130, 100, 20];
blueupper = [150, 255, 255];
yellolower = [5, 190, 80];
yelloupper = [50, 255, 255];

for i = 1: num
    if color_flag == 0
        lower = redlower;
        upper = redupper;
        color = 'red';
        color_flag = 1;
    elseif color_flag == 1
        lower = bluelower;
        upper = blueupper;
        color = 'blue';
        color_flag = 2;
    elseif color_flag == 2
        lower = yellolower;
        upper = yelloupper;
        color = 'yello'; 
        color_flag = 0;
    end
    frame = read(obj, i);%读取第几帧
    mask = rgb2hsv(frame);
    [number, plot_x, plot_y, r, mask] = dealwith(mask, lower, upper);
%     figure(1);
%     imshow(mask);%显示帧
    figure(2);
    imshow(frame);%显示帧
    for j=1:number
        hold  on
        plot(plot_y(j) ,plot_x(j), '*')
        num_color = [color, num2str(j)];
        text(plot_y(j),plot_x(j),num_color,'horiz','center','color','k','FontSize',20);
        theta = 0:2*pi/3600:2*pi;
        Circle1 = plot_y(j) + r(j)*cos(theta);
        Circle2 = plot_x(j) + r(j)*sin(theta);
        plot(Circle1,Circle2,'--k')
    end
end

