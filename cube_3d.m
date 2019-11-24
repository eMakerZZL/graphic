function cube_3d(a,b,c)
    length = 0;
    width  = 0;
    height = 0;

    if nargin == 1
        length = a;
        width  = a;
        height = a;
    elseif nargin == 2
        length = a;
        width  = b;
        height = b;
    elseif nargin == 3
        length = a;
        width  = b;
        height = c;
    end

    point(1).x = 0      ; point(1).y = 0     ; point(1).z = 0 ;
    point(2).x = 0      ; point(2).y = width ; point(2).z = 0 ;
    point(3).x = length ; point(3).y = width ; point(3).z = 0 ;
    point(4).x = length ; point(4).y = 0     ; point(4).z = 0 ;
    point(5).x = 0      ; point(5).y = 0     ; point(5).z = height ;
    point(6).x = 0      ; point(6).y = width ; point(6).z = height ;
    point(7).x = length ; point(7).y = width ; point(7).z = height ;
    point(8).x = length ; point(8).y = 0     ; point(8).z = height ;

    surface(1,1) = 5; surface(1,2) = 6; surface(1,3) = 7; surface(1,4) = 8;
    surface(2,1) = 1; surface(2,2) = 4; surface(2,3) = 3; surface(2,4) = 2;
    surface(3,1) = 1; surface(3,2) = 5; surface(3,3) = 8; surface(3,4) = 4;
    surface(4,1) = 2; surface(4,2) = 3; surface(4,3) = 7; surface(4,4) = 6;
    surface(5,1) = 3; surface(5,2) = 4; surface(5,3) = 8; surface(5,4) = 7;
    surface(6,1) = 1; surface(6,2) = 2; surface(6,3) = 6; surface(6,4) = 5;
    
    axis equal;
    maxLength = max(length,max(width,height));
    maxLength = maxLength + 5;
    axis([0 maxLength 0 maxLength 0 maxLength]);

    screenPoint = zeros(4,3);
    hold on;
    for i = 1 : 6
        for j = 1 : 4
            screenPoint(j,1) = point(surface(i,j)).x;
            screenPoint(j,2) = point(surface(i,j)).y;
            screenPoint(j,3) = point(surface(i,j)).z;
        end
        plot3(screenPoint(:,1),screenPoint(:,2),screenPoint(:,3),'b');
    end
    hold off;
end
