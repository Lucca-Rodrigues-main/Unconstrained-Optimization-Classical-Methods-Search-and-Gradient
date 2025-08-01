clc, clear all, close all

% Lucca Rodrigues Pinto
% https://github.com/Lucca-Rodrigues-main

% Fun��o objetivo
f = @(x) 0.65 - (0.75 ./ (1 + x.^2)) - (0.65 .* x .* atan(1 ./ x));

% Precis�o
epsilon = 0.05;

% Intervalo de busca
xL = 0;
xU = 3;

% N�mero necess�rio de divis�es para atingir a precis�o
% 3/(n+1) < epsilon
n = ceil(3/epsilon - 1);

% Gerar os pontos no intervalo de busca de forma equidistante
x = linspace(xL, xU, n+1);

% Avaliar a fun��o em cada ponto
f_values = f(x);

% Encontrar o valor m�nimo e o ponto correspondente
[f_min, idx_min] = min(f_values);
x_min = x(idx_min);

% Resultados
fprintf('N�mero de divis�es: %d\n', n);
fprintf('Ponto �timo aproximado x* = %.6f\n', x_min);
fprintf('Valor m�nimo da fun��o f(x*) = %.6f\n', f_min);

% Plotar a fun��o e os pontos avaliados
figure;
plot(0:0.01:3, f(0:0.01:3),'LineWidth',2);
hold on;
plot(x, f_values, 'ro', 'MarkerFaceColor', 'r');
plot([0 3],[f_min f_min],'b');
plot([x_min x_min],[-0.35 -0.05],'b');
xlabel('$$x$$','interpreter','latex');
ylabel('$$f(x)$$','interpreter','latex');
title(['$$0.65 - \frac{0.75}{1 + x^2} - 0.65x\tan^{-1}\left(\frac{1}{x}'...
    '\right)$$'],'interpreter','latex');
grid on;
set(gca,'FontSize',14);