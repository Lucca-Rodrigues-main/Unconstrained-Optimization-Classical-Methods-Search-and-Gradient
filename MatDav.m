function [L, Dc] = MatDav(H)
    % Lucca Rodrigues Pinto
    % https://github.com/Lucca-Rodrigues-main
	
    % Algoritmo de Matthews e Davies para decompor H em L e D
    % Dc eh uma versao definida positiva de D
    
    n = length(H);

    % Step 1
    L = zeros(n);
    Dc = zeros(n);
    if H(1,1) > 0
        h00 = H(1,1);
    else
        h00 = 1;
    end

    % Step 2
    for k = 2:n
        m = k - 1;
        L(m,m) = 1;
        if H(m,m) <= 0
            H(m,m) = h00;
        end

        % Step 2.1
        for i = k:n
            L(i,m) = -H(i,m) / H(m,m);
            H(i,m) = 0;

            % Step 2.1.1
            for j = k:n
                H(i,j) = H(i,j) + L(i,m) * H(m,j);
            end
        end
        
        if 0 < H(k,k) && H(k,k) < h00
            h00 = H(k,k);
        end
    end

    % Step 3
    L(n,n) = 1;
    if H(n,n) <= 0
        H(n,n) = h00;
    end
    for i = 1:n
        Dc(i,i) = H(i,i);
    end
end