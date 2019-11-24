function regularPolygon(edges)
    if nargin == 0
        edges = 3;
    end

    edges = round(edges);

    r = 1;
    l = 2 * pi * r;
    unit_l = l / edges;
    n = (unit_l * 180) / (pi * r);

    t = 90 : n : 450;

    node.x = r * cosd(t);
    node.y = r * sind(t);

    axis equal;
    hold on;
    grid on;

    plot(node.x,node.y);

    if edges >= 5
        points.x(1) = node.x(1);
        points.y(1) = node.y(1);
        tempi = 3;
        for i = 1 : edges
            if mod(tempi,edges) == 0
                j = edges;
            else
                j = mod(tempi,edges);
                tempi = j;
            end

            points.x(i + 1) = node.x(j);
            points.y(i + 1) = node.y(j);
            tempi = tempi + 2;
  
        end
        plot(points.x,points.y);
    end

    hold off;
end
