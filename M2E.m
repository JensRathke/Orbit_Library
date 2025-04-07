function E = M2E(M, e, tol, options)
    arguments
        M 
        e
        tol
        options.print = false;
    end

    E = pi;
    i = 1;

    while 1
        delta = - (E - e * sin(E) - M) / (1 - e * cos(E));
        E = E + delta;

        if options.print, fprintf('>> Iteration %i | E = %f | delta = %f\n', i, E, delta), end

        i = i + 1;

        if abs(delta) <= tol || i > 50
            break
        end
    end
end