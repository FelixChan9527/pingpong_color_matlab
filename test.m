
cam = ipcam('http://192.168.0.101:8080/video') ;
while(1)
%     preview(cam);
    img = snapshot(cam);
%     w = waitforbuttonpress;
    imshow(img);
    pause(0.0001);
%     if w == 1
%         closePreview(cam);
%         break;
%     end
end
