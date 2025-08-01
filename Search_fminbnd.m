clc, clear all, close all

% Lucca Rodrigues Pinto
% https://github.com/Lucca-Rodrigues-main

% Função objetivo
f = @(x) 0.65 - (0.75 ./ (1 + x.^2)) - (0.65 .* x .* atan(1 ./ x));

% Intervalo de busca
xL = 0;
xU = 3;

% Ponto ótimo
x_min = fminbnd(f,xL,xU);
f_min = f(x_min);

fprintf('Ponto ótimo x* = %.6f', x_min);
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