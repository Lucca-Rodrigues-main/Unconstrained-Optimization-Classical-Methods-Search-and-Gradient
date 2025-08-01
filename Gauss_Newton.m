clc, clear all, close all

% Lucca Rodrigues Pinto
% https://github.com/Lucca-Rodrigues-main

% Função objetivo
syms x1 x2 real
fo = @(x1,x2) x1 - x2 + 2.*x1.^2 + 2.*x1.*x2 + x2.^2;
% Funcao objetivo de valor real
Fo = @(x1,x2) (x1 - x2 + 2.*x1.^2 + 2.*x1.*x2 + x2.^2).^2;
% Jacobiana calculada para eficiencia
Jfo = @(x1,x2) [4*x1 + 2*x2 + 1, 2*x1 + 2*x2 - 1];

% Step 1
% Inicializa x, epsilon e k
x(:,1) = [0; 0];
x_history(:,1) = x(:,1);
epsilon = 1e-6;
k = 1;

% Step 2
% So ha uma funcao objetivo
% Calcula f(k) e a funcao de valor real F(k)
f(k) = fo(x(1,k),x(2,k));
F(k) = f(k)^2;


while 1
    % Step 3
    % Calcula o jacobiano, e com ele o gradiente e o hessiano
    J(:,k) = Jfo(x(1,k),x(2,k));
    g(:,k) = 2 * J(:,k).' * f(k);
    H(:,:,k) = 2 * J(:,k).' * J(:,k);
    
    % Step 4
    % Decompoe H com o algoritmo de Matthews e Davies
    % H eh forcada a se tornar definida positiva
    [L(:,:,k), Dc(:,:,k)] = MatDav(H(:,:,k));
    % Calcula y(k) e a direcao de Newton d(k)
    y(:,k) = -L(:,:,k) * g(:,k);
    d(:,k) = L(:,:,k).' * inv(Dc(:,:,k)) * y(:,k);
    
    % Step 5
    % Usando fminsearch() com x0 = 1 da forma
    % que indica o backtracking line search
    alpha(k) = fminsearch(@(a) Fo(x(1,k)+(a*double(d(1,k))),...
        x(2,k)+(a*double(d(2,k)))),1);
    
    % Step 6
    % Calcula x(k+1), f(k+1) e F(k+1)
    x(:,k+1) = x(:,k) + (alpha(k) * d(:,k));
    x_history(:,k+1) = x(:,k+1);
    f(k+1) = fo(x(1,k+1),x(2,k+1));
    F(k+1) = f(k+1)^2;
    
    % Step 7
    % Condicao de saida
    if abs(F(k+1) - F(k)) < epsilon
        break
    else
        k = k + 1;
    end
end

% Step 7
% Saida
xmin = x(:,k+1);
fmin = f(k+1);
Fmin = F(k+1);

fprintf('\nx(1) = [%.6f %.6f]', x(1,1), x(2,1));
fprintf('\nx* = [%.6f %.6f]', xmin(1), xmin(2));
fprintf('\nf(x*) = %.6f', fmin);
fprintf('\nF(x*) = %.6f', Fmin);
fprintf('\nPrecisao atingida = %e', abs(F(k+1) - F(k)));
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