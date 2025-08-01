clc, clear all, close all

% Lucca Rodrigues Pinto
% https://github.com/Lucca-Rodrigues-main

% Função objetivo
syms x1 x2 real
fo = @(x1,x2) x1 - x2 + 2.*x1.^2 + 2.*x1.*x2 + x2.^2;
% Gradiente calculado para eficiencia
gfo = @(x1,x2) [4*x1 + 2*x2 + 1, 2*x1 + 2*x2 - 1];
% Hessiano calculado para eficiencia
Hfo = @(x1,x2) [4, 2; 2, 2];

% Step 1
% Inicializa x, epsilon e k
x(:,1) = [0; 0];
x_history(:,1) = x(:,1);
epsilon = 1e-6;
k = 1;

while 1
    % Step 2
    % Calcula g(k) e H(k)
    g(:,k) = gfo(x(1,k),x(2,k));
    H(:,:,k) = Hfo(x(1,k),x(2,k));
    % Checa se H(k) eh definida ou semi-definida positiva
    av = double(eig(H(:,:,k)));
    if any(av < 0)
        beta = max(max(H(:,:,k))) * 100;
        H(:,:,k) = (H(:,:,k) + beta * eye(length(H))) / (1 + beta);
    end

    % Step 3
    % Calcula a direcao de Newton d(k)
    d(:,k) = -inv(H(:,:,k)) * g(:,k);
    
    % Step 4
    % Usando fminsearch() com x0 = 1 da forma
    % que indica o backtracking line search
    alpha(k) = fminsearch(@(a) fo(x(1,k)+(a*double(d(1,k))),...
        x(2,k)+(a*double(d(2,k)))),1);
    
    % Step 5
    % Calcula x(k+1) e f(k+1)
    x(:,k+1) = x(:,k) + (alpha(k) * d(:,k));
    x_history(:,k+1) = x(:,k+1);
    f(k+1) = fo(x(1,k+1),x(2,k+1));
    
    % Step 6
    % Condicao de saida
    if norm(alpha(k) * d(:,k)) < epsilon
        break
    else
        k = k + 1;
    end
end

% Step 6
% Saida
xmin = x(:,k+1);
fmin = f(k+1);

fprintf('\nx(1) = [%.6f %.6f]', x(1,1), x(2,1));
fprintf('\nx* = [%.6f %.6f]', xmin(1), xmin(2));
fprintf('\nf(x*) = %.6f', fmin);
fprintf('\nPrecisao atingida = %e', norm(alpha(k)*d(:,k)));
fprintf('\nNumero de iteracoes = %d\n\n', k);

% Plot da trajetória
figure;
[X1, X2] = meshgrid(-2:0.1:1, -1:0.1:2);
Z = X1 - X2 + 2*X1.^2 + 2*X1.*X2 + X2.^2;
contour(X1, X2, Z, 30); hold on;
plot(x_history(1,1:k+1), x_history(2,1:k+1), 'r-o');
plot(-1, 1.5, 'g*', 'MarkerSize', 10);
xlabel('x1'); ylabel('x2');
title('Trajetória de otimização');
legend('Curvas de nível', 'Trajetória', 'Solução ótima');
grid on;