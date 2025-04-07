function [arclength] = arclength3D(r, lat1, lon1, lat2, lon2)
    % transform polar coordinates to vector form
    x1 = r * cosd(lat1) * cosd(lon1);
    y1 = r * cosd(lat1) * sind(lon1);
    z1 = r * sind(lat1);

    x2 = r * cosd(lat2) * cosd(lon2);
    y2 = r * cosd(lat2) * sind(lon2);
    z2 = r * sind(lat2);

    vec1 = [x1; y1; z1];
    vec2 = [x2; y2; z2];

    % calculate angle between vectors
    angle = acos(dot(vec1, vec2) / (norm(vec1) * norm(vec2)));

    % calculate arc length
    arclength = angle * r;
end