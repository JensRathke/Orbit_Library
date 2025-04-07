function [MJD] = Cal2MJD(YY, MM, DD)
% Conversion from calender date to MJD (Montenbruck A.1.1)
    % A.3 and A.4
    if MM <= 2
        y = YY - 1;
        m = MM + 12;
    else
        y = YY;
        m = MM;
    end

    % A.5
    before = 0;

    if YY == 1582
        if MM == 10
            if d <= 4
                before = 1;
            end
        elseif MM < 10
            before = 1;
        end
    elseif YY < 1582
        before = 1;
    end

    if before == 1
        B = -2 + floor((y + 4716) / 4) - 1179;
    else
        B = floor(y / 400) - floor(y / 100) + floor(y / 4);
    end

    % A.6
    MJD = 365 * y - 679004 + floor(B) + floor(30.6001 * (m + 1)) + DD;
end