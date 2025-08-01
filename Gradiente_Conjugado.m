clc, clear all, close all

% Lucca Rodrigues Pinto
% https://github.com/Lucca-Rodrigues-main

% Função objetivo
syms x1 x2 real
fo = @(x1,x2) x1 - x2 + 2.*x1.^2 + 2.*x1.*x2 + x2.^2;
n = 2;
% Gradiente calculado para eficiencia
gfo = @(x1,x2) [4*x1 + 2*x2 + 1, 2*x1 + 2*x2 - 1];
% Hessiano calculado para eficiencia
Hfo = @(x1,x2) [4, 2; 2, 2];

% Step 1
% Input x(1) e tolerancia
x(:,1) = [0; 0];
x_history(:,1) = x(:,1);
epsilon = 1e-6;

% Step 2
% Calcular g(1) e d(1)
g(:,1) = gfo(x(1,1),x(2,1));
d(:,1) = -g(:,1);
% Inicializar k
k = 1;

for k = 1:n
    % Step 3
    % Calcular H(k) e alpha(k)
    H(:,:,k) = Hfo(x(1,k),x(2,k));
    alpha(k) = (g(:,k).' * g(:,k)) / (d(:,k).' * H(:,:,k) * d(:,k));
    % Calcular x(k+1) e f(k+1)
    x(:,k+1) = x(:,k) + (alpha(k) * d(:,k));
    x_history(:,k+1) = x(:,k+1);
    f(k+1) = fo(x(1,k+1),x(2,k+1));

    % Step 4
    % Condicao de saida
%     if norm(alpha(k)*d(:,k)) < epsilon
%         break
%     end
    
    % Step 5
    % Calcular g(k+1), beta(k) e d(k+1)
    g(:,k+1) = gfo(x(1,k+1),x(2,k+1));
    beta(k) = (g(:,k+1).' * g(:,k+1)) / (g(:,k).' * g(:,k));
    d(:,k+1) = -g(:,k+1) + beta(k) * d(:,k);
    k = k + 1;
end

% Step 4
% Saida
% xmin = x(:,k+1);
% fmin = f(k+1);

xmin = x(:,k);
fmin = f(k);

fprintf('\nx(1) = [%.6f %.6f]', x(1,1), x(2,1));
fprintf('\nx* = [%.6f %.6f]', xmin(1), xmin(2));
fprintf('\nf(x*) = %.6f', fmin);
fprintf('\nNumero de iteracoes = %d\n\n', k-1);

% Plot da trajetória
figure;
[X1, X2] = meshgrid(-2:0.1:1, -1:0.1:2);
Z = X1 - X2 + 2*X1.^2 + 2*X1.*X2 + X2.^2;
contour(X1, X2, Z, 30); hold on;
plot(x_history(1,1:k), x_history(2,1:k), 'r-o');
plot(-1, 1.5, 'g*', 'MarkerSize', 10);
xlabel('x1'); ylabel('x2');
title('Trajetória de otimização');
legend('Curvas de nível', 'Trajetória', 'Solução ótima');
grid on;