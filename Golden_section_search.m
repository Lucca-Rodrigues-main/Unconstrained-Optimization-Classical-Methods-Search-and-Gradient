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

% Step 2
% Constante de proporção áurea
K = 1.618034;

I(1) = xU(1) - xL(1);
I(2) = I(1)/K;

xa(1) = xU(1) - I(2);
xb(1) = xL(1) + I(2);

fa(1) = f(xa(1));
fb(1) = f(xb(1));

k = 1;

% Cabeçalho das iterações
fprintf('  k\t\tXL,k\t\tXU,k\t\tXa,k\t\tXb,k\t   fa,k\t\t   fb,k\t\t\t  lk+2\n');

% Step 3
% Iteração
while I(k) > epsilon
    I(k+2) = I(k+1)/K;
    
    if fa(k) >= fb(k)
        xL(k+1) = xa(k);
        xU(k+1) = xU(k);
        xa(k+1) = xb(k);
        xb(k+1) = xL(k+1) + I(k+2);
        fa(k+1) = fb(k);
        fb(k+1) = f(xb(k+1));
        
        % Valores das variáveis na iteração atual
        fprintf(['|%2d\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %e'...
            ' |\tfa,k >= fb,k\n'], ...
            k, xL(k), xU(k), xa(k), xb(k), fa(k), fb(k), I(k+2));
    else
        xL(k+1) = xL(k);
        xU(k+1) = xb(k);
        xa(k+1) = xU(k+1) - I(k+2);
        xb(k+1) = xa(k);
        fb(k+1) = fa(k);
        fa(k+1) = f(xa(k+1));
        
        % Valores das variáveis na iteração atual
        fprintf(['|%2d\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %e'...
            ' |\tfa,k >= fb,k\n'], ...
            k, xL(k), xU(k), xa(k), xb(k), fa(k), fb(k), I(k+2));
    end
    
    % Step 4
    % Condição de parada
    if (I(k+1) < epsilon) || (xa(k+1) > xb(k+1))
        break;
    end
    
    % Step 5
    k = k + 1;
end

% Imprimir a última iteração
fprintf('|%2d\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %.6f\t| %e |\n', ...
    k+1, xL(k+1), xU(k+1), xa(k+1), xb(k+1), fa(k+1), fb(k+1), I(k+2));

% Step 4
if fa(k+1) > fb(k+1)
    x_min = 1/2 * (xb(k+1) + xU(k+1));
elseif fa(k+1) == fb(k+1)
    x_min = 1/2 * (xa(k+1) + xb(k+1));
else
    x_min = 1/2 * (xL(k+1) + xa(k+1));
end
f_min = f(x_min);

% Resultados
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