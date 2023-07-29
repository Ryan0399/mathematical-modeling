function [X,Y] = getThePoint()
   X = []; Y = [];
   hold on;
   while true
       [x,y,button] = ginput(1);
       if button == 3 % right mouse button exits loop
           break;
       end
       X(end+1) = x; Y(end+1) = y;
       scatter(x,y,'blue','filled'); % plot the selected point in blue
   end
end
