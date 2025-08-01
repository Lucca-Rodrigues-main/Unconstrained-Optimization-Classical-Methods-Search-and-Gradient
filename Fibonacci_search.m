clc, clear all, close all

% Lucca Rodrigues Pinto
% https://github.com/Lucca-Rodrigues-main

% Step 1
% Função objetivo
f = @(x) 0.65 - (0.75 ./ (1 + x.^2)) - (0.65 .* x .* atan(1 ./ x));

% Precisão
epsilon = 0.05;

% Intervalo de busca
xL(1) = 0;
xU(1) = 3;

% Número necessário de iterações
n = 2;
F = [1 1];
% In = I1 / Fn
% In < epsilon
% epsilon > I1 / Fn
while (epsilon <= (xU(1) - xL(1)) / F(n))
    % Step 2
    F = [F, F(end) + F(end-1)];
    n = n + 1;
end

% Inicializar as variáveis
xL = [xL zeros(1, n-3)];
xU = [xU zeros(1, n-3)];
l = zeros(1, n-1);
x_a = zeros(1, n-2);
x_b = zeros(1, n-2);

% Step 3
l(1) = xU(1) - xL(1);
l(2) = F(n-1)/F(n) * l(1);

x_a(1) = xU(1) - l(2);
x_b(1) = xL(1) + l(2);

f_a = f(x_a);
f_b = f(x_b);

k = 1;

% Cabeçalho das iterações
fprintf('  k\t\tXL,k\t\tXU,k\t\tXa,k\t\tXb,k\t   fa,k\t\t   fb,k\t\t\t  lk+2\n');

% Step 4
while 1
    l(k+2) = (F(n-k-1)/F(n-k)) * l(k+1);
    
    if f_a(k) >= f_b(k)
        xL(k+1) = x_a(k);
        xU(k+1) = xU(k);
        x_a(k+1) = x_b(k);
        x_b(k+1) = xL(k+1) + l(k+2);
        f_a(k+1) = f_b(k);
        f_b(k+1) = f(x_b(k+1));
        
        % Valores das variáveis na iteração atual
        fprintf(['|%2d\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %e'...
            ' |\tfa,k >= fb,k\n'], ...
            k, xL(k), xU(k), x_a(k), x_b(k), f_a(k), f_b(k), l(k+2));
    else
        xL(k+1) = xL(k);
        xU(k+1) = x_b(k);
        x_a(k+1) = xU(k+1) - l(k+2);
        x_b(k+1) = x_a(k);
        f_b(k+1) = f_a(k);
        f_a(k+1) = f(x_a(k+1));
        % Valores das variáveis na iteração atual
        fprintf(['|%2d\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %e'...
            ' |\tfa,k < fb,k\n'], ...
            k, xL(k), xU(k), x_a(k), x_b(k), f_a(k), f_b(k), l(k+2));
    end
    
    % Step 5
    if (k == n-2) || (x_a(k+1) > x_b(k+1))
        break
    end
    
    k = k + 1;
end

% Condição de parada e escolha do ponto mínimo
if f_a(k) >= f_b(k)
    x_min = x_a(k+1);
else
    x_min = x_b(k+1);
end
f_min = f(x_min);

% Imprimir a última iteração
fprintf('|%2d\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %e |\n', ...
    k+1, xL(k+1), xU(k+1), x_a(k+1), x_b(k+1), f_a(k+1), f_b(k+1), l(k+2));

fprintf('\nPonto ótimo x* = %.6f', x_min);
fprintf('\nValor mínimo da função f(x*) = %.6f\n', f_min);

% Plotar a função no intervalo
plot(0:0.01:3, f(0:0.01:3),'LineWidth',2);
hold on
plot([0 3],[f_min f_min],'r');
plot([x_min x_min],[-0.35 -0.05],'r');
grid on
xlabel('$$x$$','interpreter','latex');
ylabel('$$f(x)$$','interpreter','latex');
title(['$$0.65 - \frac{0.75}{1 + x^2} - 0.65x\tan^{-1}\left(\frac{1}{x}'...
    '\right)$$'],'interpreter','latex');
set(gca,'FontSize',14);