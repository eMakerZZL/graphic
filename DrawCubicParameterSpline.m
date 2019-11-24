function DrawCubicParameterSpline(p)
    [~,n] = size(p.x);
    b1 = 0; bn = 0;

    L      = zeros(1,n);
    lambda = zeros(1,n); mu = zeros(1,n);
    l      = zeros(1,n); m  = zeros(1,n); u  = zeros(1,n);
    D      = struct('x',zeros(1,n),'y',zeros(1,n));
    M      = struct('x',zeros(1,n),'y',zeros(1,n));
    K      = struct('x',zeros(1,n),'y',zeros(1,n));
    B1     = struct('x',zeros(1,n),'y',zeros(1,n));
    B2     = struct('x',zeros(1,n),'y',zeros(1,n));
    B3     = struct('x',zeros(1,n),'y',zeros(1,n));
    B4     = struct('x',zeros(1,n),'y',zeros(1,n));
    delta  = struct('x',zeros(1,n),'y',zeros(1,n));

    c1 = struct('x',0,'y',0); cn = struct('x',0,'y',0);

    for i = 1 : n - 1
        delta.x(i) = p.x(i + 1) - p.x(i);
        delta.y(i) = p.y(i + 1) - p.y(i);
              L(i) = sqrt(delta.x(i)^2 + delta.y(i)^2);
    end

    for i = 2 : n - 1
        lambda(i) = L(i - 1) / (L(i - 1) + L(i));
            mu(i) = L(i)     / (L(i - 1) + L(i));
           D.x(i) = 6        / (L(i - 1) + L(i)) * ((p.x(i + 1) - p.x(i)) / L(i) - (p.x(i) - p.x(i - 1)) / L(i - 1));
           D.y(i) = 6        / (L(i - 1) + L(i)) * ((p.y(i + 1) - p.y(i)) / L(i) - (p.y(i) - p.y(i - 1)) / L(i - 1));
    end
    D.x(1) = 6 * ((p.x(2) - p.x(1)) / L(1) - b1) / L(1);
    D.y(1) = 6 * ((p.y(2) - p.y(1)) / L(1) - b1) / L(1);

    D.x(n) = 6 * (bn - (p.x(n) - p.x(n - 1)) / L(n - 1)) / L(n - 1);
    D.y(n) = 6 * (bn - (p.y(n) - p.y(n - 1)) / L(n - 1)) / L(n - 1);
        
    mu(1) = 1;
    lambda(n) = 1;

    l(1) = 2;
    u(1) = mu(1) / l(1);
    for i = 2 : n
        m(i) = lambda(i);
        l(i) = 2 - m(i) * u(i - 1);
        u(i) = mu(i) / l(i);
    end

    K.x(1) = D.x(1) / l(1);
    K.y(1) = D.y(1) / l(1);

    for i = 2 : n
        K.x(i) = (D.x(i) - m(i) * K.x(i - 1)) / l(i);
        K.y(i) = (D.y(i) - m(i) * K.y(i - 1)) / l(i);
    end

    M.x(n) = K.x(n);
    M.y(n) = K.y(n);

    for i = n - 1 : -1 : 1
        M.x(i) = K.x(i) - u(i) * M.x(i + 1);
        M.y(i) = K.y(i) - u(i) * M.y(i + 1);
    end

    for i = 1 : n - 1
        B1.x(i) = p.x(i);
        B1.y(i) = p.y(i);
        
        B2.x(i) = (p.x(i + 1) - p.x(i)) / L(i) - L(i) * (M.x(i) / 3 + M.x(i + 1) / 6);
        B2.y(i) = (p.y(i + 1) - p.y(i)) / L(i) - L(i) * (M.y(i) / 3 + M.y(i + 1) / 6);
       
        B3.x(i) = M.x(i) / 2;
        B3.y(i) = M.y(i) / 2;
      
        B4.x(i) = (M.x(i + 1) - M.x(i)) / (6 * L(i));
        B4.y(i) = (M.y(i + 1) - M.y(i)) / (6 * L(i));
    end

    index = 1;
    point = struct('x',[],'y',[]);
    for i = 1 : n - 1
        for t = 0 : 0.5 : L(i)
            point.x(index) = B1.x(i) + B2.x(i) * t + B3.x(i) * t^2 + B4.x(i) * t^3;
            point.y(index) = B1.y(i) + B2.y(i) * t + B3.y(i) * t^2 + B4.y(i) * t^3;
            index = index + 1;
        end
    end

    hold on;
    grid on;
    axis equal;
    plot(p.x,p.y,'ro');
    plot(point.x,point.y);
    hold off;
end
