function sphere_3d(radius, alpah, beta)
    hold on;
    grid on;
    axis equal;

    r = 0;
    unit_alpha = 0;
    unit_beta  = 0;

    if nargin == 0
        r = 10;
        unit_alpha = pi / 4;
        unit_beta  = unit_alpha;
    elseif nargin == 1
        r = radius;
        unit_alpha = pi / 4;
        unit_beta  = unit_alpha;
    elseif nargin == 2
        r = radius;
        unit_alpha = alpah;
        unit_beta  = unit_alpha;
    elseif nargin == 3
        r = radius;
        unit_alpha = alpah;
        unit_beta  = beta;
    end

    N1 = pi / unit_beta;
    N2 = 2 * pi / unit_alpha;

    p = struct('x',[],...
               'y',[],...
               'z',[]);

    p(1).x = 0; p(1).y = r; p(1).z = 0;

    for i = 0 : N1 - 2
        mAlpha = (i + 1) * unit_alpha;
        for j = 0 : N2 - 1
            mBeta = j * unit_beta;
            p(i * N2 + j + 2).x = r * sin(mAlpha) * sin(mBeta);
            p(i * N2 + j + 2).y = r * cos(mAlpha);
            p(i * N2 + j + 2).z = r * sin(mAlpha) * cos(mBeta);
        end
    end

    p((N1 - 1) * N2 + 2).x = 0; p((N1 - 1) * N2 + 2).y = -r; p((N1 - 1) * N2 + 2).z = 0;

%     plot3([p.x],[p.y],[p.z],'ro');

    surface = struct('Index' ,[],...
                     'Number',[]);

    for i = 1 : N2
        temp = i + 1;
        if temp == N2 + 1
            temp = 1;
        end
        NorthIndex(1) = 1;
        NorthIndex(2) = i + 1;
        NorthIndex(3) = temp + 1;

        for k = 1 : 3
            surface(1,i).Index(k) = NorthIndex(k);
            surface(1,i).Number = 3;
        end
    end

    for i = 2 : N1 - 1
        for j = 1 : N2
            BodyIndex(1) = (i - 2) * N2 + j + 1;

            BodyIndex(2) = BodyIndex(1) + 1;
            if mod(BodyIndex(2),(i - 1) * N2 + 2) == 0
                BodyIndex(2) = (i - 2) * N2 + 2;
            end

            BodyIndex(3) = (i - 1) * N2 + j + 1;

            BodyIndex(4) = BodyIndex(3) + 1;
            if mod(BodyIndex(4),i * N2 + 2) == 0
                BodyIndex(4) = (i - 1) * N2 + 2;
            end

            for k = 1 : 4
                surface(i,j).Index(k) = BodyIndex(k);
                surface(i,j).Number = 4;
            end
        end
    end

    for i = 1 : N2
        SouthIndex(1) = (N1 - 2) * N2 + i + 1;
        SouthIndex(2) = SouthIndex(1) + 1;
        if SouthIndex(2) == ((N1 - 1) * N2 + 2)
            SouthIndex(2) = (N1 - 2) * N2 + 2;
        end
        SouthIndex(3) = (N1 - 1) * N2 + 2;

        for k = 1 : 3
            surface(N1,i).Index(k) = SouthIndex(k);
            surface(N1,i).Number = 3;
        end
    end

    point3 = zeros(3,3);
    point4 = zeros(4,3);

    for i = 1 : N1
        for j = 1 : N2
            if surface(i,j).Number == 3
                for k = 1 : 3
                    point3(k,1) = p(surface(i,j).Index(k)).x;
                    point3(k,2) = p(surface(i,j).Index(k)).y;
                    point3(k,3) = p(surface(i,j).Index(k)).z;
                end
                plot3([point3(1,1),point3(2,1)],[point3(1,2),point3(2,2)],[point3(1,3),point3(2,3)], 'b-');
                plot3([point3(2,1),point3(3,1)],[point3(2,2),point3(3,2)],[point3(2,3),point3(3,3)], 'b-');
                plot3([point3(3,1),point3(1,1)],[point3(3,2),point3(1,2)],[point3(3,3),point3(1,3)], 'b-');
            else
                for k = 1 : 4
                    point4(k,1) = p(surface(i,j).Index(k)).x;
                    point4(k,2) = p(surface(i,j).Index(k)).y;
                    point4(k,3) = p(surface(i,j).Index(k)).z;
                end
                plot3([point4(1,1),point4(2,1)],[point4(1,2),point4(2,2)],[point4(1,3),point4(2,3)], 'b-');
                plot3([point4(2,1),point4(3,1)],[point4(2,2),point4(3,2)],[point4(2,3),point4(3,3)], 'b-');
                plot3([point4(3,1),point4(4,1)],[point4(3,2),point4(4,2)],[point4(3,3),point4(4,3)], 'b-');
                plot3([point4(4,1),point4(1,1)],[point4(4,2),point4(1,2)],[point4(4,3),point4(1,3)], 'b-');
            end
        end
    end

    hold off;
end
