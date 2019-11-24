function DrawBezierdeCasteljau(p)
    hold on;
    [col, ~] = size(p);
    n = col - 1;

    mat = cell(4);

    point = [];
    for t = 0 : 0.01 : 1
        for i = 1 : 4
            mat(i,1) = { p(i,:) };
        end

        for i = 2 : 4
            mat(i,2) = { (1 - t) * mat{i - 1, 1} - t * mat{i, 1} };
        end

        for i = 3 : 4
            mat(i,3) = { (1 - t) * mat{i - 1, 2} - t * mat{i, 2} };
        end

        i = 4;
            mat(i,4) = { (1 - t) * mat{i - 1, 3} - t * mat{i, 3} };

        point = [point;mat{4,4}];
    end

    plot(p(:,1),p(:,2),'ro');
    plot(point(:,1),point(:,2));

    hold off;
end
