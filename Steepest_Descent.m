clc, clear all, close all

% Lucca Rodrigues Pinto
% https://github.com/Lucca-Rodrigues-main

% Função objetivo
syms x1 x2 real
fo = @(x1,x2) x1 - x2 + 2.*x1.^2 + 2.*x1.*x2 + x2.^2;
% Gradiente calculado para eficiencia
gfo = @(x1,x2) [4*x1 + 2*x2 + 1, 2*x1 + 2*x2 - 1];

% Hessiana disponivel
Hfo = hessian(fo, [x1, x2])
% afo = double(eig(hessian(fo, [x1, x2])))
% Verificando se autovalores sao >= 0
% isAlways(afo >= 0)
% Verificando o numero de condicao
% CN = double(norm(Hfo) * norm(inv(Hfo)))

% Step 1
% Input x(1) e tolerancia
x(:,1) = [0; 0];
x_history(:,1) = x(:,1);
epsilon = 1e-6;
% Inicializar k e alpha(0)
k = 1;
alpha(1) = 1;
% Calcular f(1)
f(1) = fo(x(1,1), x(2,1));

while 1
    % Step 2
    % Calcular o gradiente g(k)
    g(:,k) = gfo(x(1,k), x(2,k));

    % Step 3
    % Calcular d(k) e alpha_chapeu
    d(:,k) = -g(:,k);
    ac = alpha(1);
    % Calcular f_chapeu
    fc = fo(x(1,k)-(ac*g(1,k)), x(2,k)-(ac*g(2,k)));
    % Calcular alpha(k)
    alpha(k) = (g(:,k)' * g(:,k) * ac^2) / ...
        (2*(fc - f(k) + (ac * g(:,k)' * g(:,k))));

    % Step 4
    % Calcular x(k+1)
    x(:,k+1) = x(:,k) + (alpha(k) * d(:,k));
    x_history(:,k+1) = x(:,k+1);
    % Calcular f(k+1)
    f(k+1) = fo(x(1,k+1), x(2,k+1));

    % Step 5
    % Condicao de saida
    if norm(alpha(k)*d(:,k)) < epsilon
        break
    else
        k = k + 1;
    end
end

% Step 5
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