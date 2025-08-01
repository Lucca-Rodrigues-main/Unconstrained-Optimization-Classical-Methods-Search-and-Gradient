clc, clear all, close all

% Lucca Rodrigues Pinto
% https://github.com/Lucca-Rodrigues-main

% Fun��o objetivo
f = @(x) 0.65 - (0.75 ./ (1 + x.^2)) - (0.65 .* x .* atan(1 ./ x));

% Par�metros do m�todo
epsilon = 0.05;
delta = 1e-4;

% Intervalo de busca
xL = 0;
xU = 3;

% N�mero de itera��es
I0 = xU - xL;
k = 0;
while (0.5^k * I0) > epsilon
    k = k + 1;
end

% Cabe�alho das itera��es
fprintf('k\t\txL\t\t\txU\t\t\tx1\t\t\tf(x_a)\t\tf(x_b)\t\tx_a\t\t\tx_b\n');

% Itera��es
for i = 1:k
    % Ponto m�dio
    x1 = (xL + xU) / 2;
    
    % Avaliar os dois pontos ao redor de x1
    x_a = x1 - delta/2;
    x_b = x1 + delta/2;
    f_a = f(x_a);
    f_b = f(x_b);
    
    % Verificar qual subintervalo mant�m o m�nimo
    if f_a < f_b
        xU = x_b;  % Reduzir o limite superior
    else
        xL = x_a;  % Reduzir o limite inferior
    end
    
    % Exibir resultados de cada itera��o
    fprintf('%d\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\t %.6f\n', i,...
        xL, xU, x1, f_a, f_b, x_a, x_b);
end

% Ponto m�nimo
x_min = (xL + xU) / 2;
f_min = f(x_min);

% Resultados
fprintf('\nPonto �timo x* = %.6f', x_min);
fprintf('\nValor m�nimo da fun��o f(x*) = %.6f\n', f_min);

% Plotar a fun��o no intervalo
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