function DrawCubicSpline(p)
    [~,n] = size(p);
    b1 = 0; bn = 0;
    h      = zeros(1, n);
    lambda = zeros(1, n);
    mu     = zeros(1, n);
    D      = zeros(1, n);
    l      = zeros(1, n);
    m      = zeros(1, n);
    u      = zeros(1, n);
    M      = zeros(1, n);
    K      = zeros(1, n);
    a      = zeros(1, n);
    b      = zeros(1, n);
    c      = zeros(1, n);
    d      = zeros(1, n);

    for i = 1 : n - 1
        h(i) = p(i + 1).x - p(i).x;
    end

    for i = 2 : n - 1
        lambda(i) = h(i - 1) / (h(i - 1) + h(i));
        mu(i)     = h(i) / (h(i - 1) + h(i));
        D(i)      = 6 / (h(i - 1) + h(i)) * (((p(i + 1).y -p(i).y) / h(i)) - ((p(i).y - p(i - 1).y) / h(i - 1)));
    end
    D(1)      = 6 / h(1) * ((p(2).y - p(1).y) / h(1) - b1);
    D(n)      = 6 / h(n - 1) * (bn - (p(n).y - p(n - 1).y) / h(n - 1));
    mu(1)     = 1;
    lambda(n) = 1;

    l(1) = 2;
    u(1) = mu(1) / l(1);

    for i = 2 : n
        m(i) = lambda(i);
        l(i) = 2 - m(i) * u(i-1);
        u(i) = mu(i) / l(i);
    end

    K(1) = D(1) / l(1);
    for i = 2 : n
        K(i) = (D(i) - m(i) * K(i - 1)) / l(i);
    end
    M(n) = K(n);

    for i = n - 1 : -1 : 1
        M(i) = K(i) - u(i) * M(i + 1);
    end

    for i = 1 : n - 1
        a(i) = p(i).y;
        b(i) = (p(i+1).y - p(i).y) / h(i) - h(i) * (M(i) / 3 + M(i + 1) / 6);
        c(i) = M(i) / 2;
        d(i) = (M(i + 1) - M(i)) / (6 * h(i));
    end

    hold on;
    plot([p.x],[p.y],'ro');
    point = [];
    for i = 1 : n - 1
        for x = p(i).x : 0.05 : p(i+1).x
            y = a(i) + b(i) * (x - p(i).x) + c(i) * (x - p(i).x)^2 + d(i) * (x - p(i).x)^3;
            point = [x y;point];
        end
    end
    plot(point(:,1),point(:,2));
    hold off;
end
