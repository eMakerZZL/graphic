function DrawCardinalCurve(p)
    hold on;

    u = 0.1;
    s = (1 - u) / 2;
    mat = [
        -s  , 2-s , s-2   , s;
        2*s , s-3 , 3-2*s , -s;
        -s  , 0   , s     , 0;
        0   , 1   , 0     , 0;
    ];

    [col,~] = size(p);
    for i = 1 : col - 2 - 1
        point = [p(i, :); p(i + 1, :); p(i + 2, :); p(i + 3, :)];

        point(:,1) = mat * point(:,1);
        point(:,2) = mat * point(:,2);

        for t = 0 : 0.01 : 1
            node = t^3 * point(1,:) + t^2 * point(2,:) + t * point(3,:) + point(4,:);
            plot(node(1,1),node(1,2),'ro');
        end
    end

    hold off;
end
