# Unconstrained-Optimization-Classical-Methods-Search-and-Gradient
This repository contains a collection of MATLAB scripts that implement some of the classical optimization methods for unconstrained optimization models: Steepest-Descent, Newton method, Gauss-Newton, Conjugate Gradient method, Fibonacci search, Golden-section search, Dichotomous search and Exhaustive search.

---

## Algoritmos de Otimização Irrestritos: Métodos de Busca
A otimização irrestrita lida com o problema de encontrar o ponto de mínimo (ou máximo) de uma função-objetivo sem a imposição de quaisquer restrições sobre os valores das variáveis de decisão. O foco aqui são os problemas de otimização unidimensional irrestrita, que buscam minimizar uma função de uma única variável, $f(x)$.

Uma premissa fundamental para a garantia de convergência desses métodos de busca é que a função-objetivo seja **unimodal** no intervalo de busca inicial. Uma função unimodal é aquela que possui apenas um mínimo (ou um pico) em um dado intervalo, permitindo que partes do intervalo sejam eliminadas a cada iteração.

Os algoritmos de busca operam sobre um intervalo inicial de incerteza, $[x_L, x_U]$, que sabidamente contém o ponto de mínimo. A cada iteração, o intervalo é sistematicamente reduzido com base em novas avaliações da função, até que se atinja uma precisão desejada. Uma grande vantagem desses métodos é que a diferenciabilidade da função não é um requisito.

---

### Função-Objetivo dos Exemplos
Todos os scripts de métodos de busca neste repositório foram aplicados para encontrar o ponto de mínimo da seguinte função-objetivo no intervalo $x \in [0, 3]$:

$$f(x) = 0.65 - \frac{0.75}{1 + x^2} - 0.65x \cdot \arctan\left(\frac{1}{x}\right)$$

### Implementações Disponíveis
A seguir, são descritos os métodos implementados.

#### 1. Busca Exaustiva (`Exhaustive_search.m`)
Este é o método de busca mais fundamental. Ele funciona dividindo o intervalo de incerteza inicial $L_0$ em `n` subintervalos equidistantes. A função é então avaliada em cada um dos `n+1` pontos gerados, e o ponto que resulta no menor valor da função é considerado a aproximação do mínimo. O número de divisões `n` é escolhido para satisfazer uma tolerância pré-definida. O princípio que rege a precisão do método é: se o ponto médio do intervalo final de incerteza for tomado como o ponto ótimo aproximado, o desvio máximo pode ser $\frac{L_0}{(n+1)}$, onde $L_0$ é o intervalo de incerteza inicial e `n` é o número de intervalos em que $f(x)$ é avaliada. O gráfico a seguir mostra o ponto de mínimo encontrado:

<img width="700" height="525" alt="473218247-6acd1f81-0bc0-43e0-838c-d7359b374bea" src="https://github.com/user-attachments/assets/98e87ba1-6e5b-422b-8906-f37240d1e4b4" />

#### 2. Busca Dichotomous (`Dichotomous_search.m`)
A busca Dichotomous aprimora a busca exaustiva ao reduzir o intervalo de forma mais inteligente. A cada iteração, dois pontos de teste são posicionados muito próximos um do outro, em torno do ponto médio do intervalo atual. A distância entre eles é definida por um valor muito pequeno, $\delta$. Ao comparar os valores da função nesses dois pontos, o algoritmo consegue eliminar quase metade do intervalo de busca a cada passo, convergindo para o mínimo de forma muito mais eficiente que a busca exaustiva. O gráfico a seguir mostra o ponto de mínimo encontrado:

<img width="700" height="525" alt="473218262-9fa3c4fb-c9a8-4d07-8a0a-81dac6e36687" src="https://github.com/user-attachments/assets/0d151be7-e800-4e16-b8eb-e92055a5d0c9" />

#### 3. Busca Fibonacci (`Fibonacci_search.m`)
O método de busca Fibonacci é conhecido por ser o mais eficiente entre os métodos de busca em termos do número de avaliações da função para atingir uma dada precisão. Ele utiliza a sequência de Fibonacci para determinar a posição dos pontos de teste a cada iteração. Uma característica única é que o número total de iterações, `n`, deve ser definido a priori. A grande vantagem é que, a partir da segunda iteração, apenas uma nova avaliação da função é necessária para reduzir o intervalo de incerteza, reutilizando um dos pontos da iteração anterior. O gráfico a seguir mostra o ponto de mínimo encontrado:

<img width="700" height="525" alt="473218293-b113e6c9-7a96-462f-b25c-edf19dfc9688" src="https://github.com/user-attachments/assets/121fd565-317e-4528-ae19-3f7cc786acdf" />

#### 4. Busca Golden-section (`Golden_section_search.m`)
A busca Golden-section é muito semelhante à busca de Fibonacci, mas com uma vantagem prática importante: ela não exige que o número de iterações seja conhecido antecipadamente. O método utiliza a **razão áurea**, $G \approx 1.618034$, para posicionar os pontos de teste. A cada iteração, o intervalo é reduzido por um fator constante de $1/G \approx 0.618$, o que o torna ligeiramente menos eficiente que o método de Fibonacci, mas mais flexível em sua aplicação. O gráfico a seguir mostra o ponto de mínimo encontrado:

<img width="700" height="525" alt="473218312-43326811-3368-4459-b7aa-73406de92124" src="https://github.com/user-attachments/assets/2fe0bfec-c5b0-419c-868a-c1bfdc1c8b28" />

#### 5. Comparação com `fminbnd` (`Search_fminbnd.m`)
Para validar e comparar os resultados dos algoritmos implementados, foi utilizado o otimizador `fminbnd` do Optimization Toolbox™ do MATLAB. Esta função é um padrão da indústria para otimização unidimensional irrestrita em um intervalo e tipicamente combina métodos robustos como a busca Golden-section e a interpolação parabólica para encontrar o mínimo de forma rápida e precisa. O gráfico a seguir mostra o ponto de mínimo encontrado:

<img width="700" height="525" alt="473218363-45fd088b-d093-4d36-9037-d6849a0551bb" src="https://github.com/user-attachments/assets/1cd267ff-b55d-43f6-803d-678fc70d28e8" />

---

## Algoritmos de Otimização Irrestrita: Métodos de Gradiente
Esta seção do repositório é dedicada aos **métodos de gradiente** (ou métodos de descida) para resolver problemas de otimização irrestrita multidimensional. Estes problemas são definidos pela busca do ponto mínimo de uma função $f(x)$ com $f: \mathbb{R}^n \to \mathbb{R}$, sem que haja restrições sobre as variáveis $x$.

A estratégia central por trás desses métodos é a de um **método de descida**, que gera uma sequência de pontos $x_0, x_1, x_2, ...$ de tal forma que o valor da função-objetivo diminua a cada iteração, ou seja, $f(x_{k+1}) < f(x_k)$. A fórmula iterativa geral é:

$$x_{k+1} = x_k + \alpha_k d_k$$

onde $d_k$ é a **direção de busca** (que deve ser uma direção de descida) e $\alpha_k$ é o **tamanho do passo**, tipicamente encontrado através de um procedimento de busca unidimensional (line search). Os métodos aqui implementados diferem fundamentalmente na maneira como a direção de busca $d_k$ é calculada.

---

### Função-Objetivo dos Exemplos
Todos os scripts de métodos de gradiente neste repositório foram aplicados para encontrar o ponto de mínimo da seguinte função-objetivo quadrática:

$$f(x_1, x_2) = x_1 - x_2 + 2x_1^2 + 2x_1x_2 + x_2^2$$

### Implementações Disponíveis
A seguir, são descritos os métodos de gradiente implementados.

#### 1. Método de Descida Íngreme (Steepest-Descent) (`Steepest_Descent.m`)
Este é um dos métodos de gradiente mais antigos e fundamentais. Sendo um método de primeira ordem, ele utiliza apenas as derivadas primeiras da função. A direção de busca é a do **gradiente negativo**, $d_k = -\nabla f(x_k)$. Esta é a direção na qual a função decresce mais rapidamente a partir do ponto $x_k$. Embora seja simples de implementar, o método pode apresentar convergência lenta, especialmente em funções com vales alongados. O gráfico a seguir apresenta a trajetória de otimização para esse método:

<img width="700" height="525" alt="473253433-e35d21b9-1cb9-4605-9aca-3122979f0f9b" src="https://github.com/user-attachments/assets/2d71c840-a044-46b5-9749-8631bfba4ad7" />

#### 2. Método de Newton (`Newton.m`)
O método de Newton é um método de segunda ordem, pois utiliza tanto o gradiente (derivadas primeiras) quanto a matriz Hessiana (derivadas segundas) da função. Ele se baseia em uma aproximação quadrática da função-objetivo em torno do ponto atual. A direção de busca, conhecida como "direção de Newton", é calculada como $d_k = -H(x_k)^{-1} \nabla f(x_k)$, onde $H(x_k)^{-1}$ é a inversa da matriz Hessiana. A principal vantagem do método de Newton é sua rápida taxa de convergência (quadrática) perto do ponto ótimo. Sua desvantagem é o alto custo computacional para calcular e inverter a matriz Hessiana a cada iteração, além da exigência de que a Hessiana seja positiva definida. O gráfico a seguir apresenta a trajetória de otimização para esse método:

<img width="700" height="525" alt="473253460-7608263f-0c2a-4a6b-8eac-6f8843d9cb3e" src="https://github.com/user-attachments/assets/3bf320ca-a875-4e0e-b9a1-2dacc6d049ff" />

#### 3. Método de Gauss-Newton (`Gauss_Newton.m`)

O método de Gauss-Newton é uma modificação do método de Newton, desenvolvido especificamente para resolver problemas de mínimos quadrados, onde a função-objetivo é uma soma de quadrados de funções não-lineares: $F(x) = \sum_{\rho=1}^{m} [f_{\rho}(x)]^2$. A principal característica deste método é que ele aproxima a matriz Hessiana utilizando apenas as informações das derivadas primeiras (a matriz Jacobiana), através da relação $H_F \approx 2J^T J$. Isso evita o cálculo explícito das custosas derivadas segundas, tornando-o computacionalmente mais atraente que o método de Newton para problemas de mínimos quadrados. O gráfico a seguir apresenta a trajetória de otimização para esse método:

<img width="700" height="525" alt="473253482-239f57a2-3af9-4542-9b64-2890ecffdea2" src="https://github.com/user-attachments/assets/b9e8150a-04dc-4503-a038-8e51cda0c5c4" />

Nota-se que este método não alcançou um ponto de mínimo similar aos demais métodos para a função objetivo deste exemplo. Pode-se dizer que o método de Gauss-Newton não é a ferramenta certa para este trabalho, enquanto a aplicação do método de Newton clássico resolve o problema de forma muito mais direta e eficiente.

#### 4. Método do Gradiente Conjugado (`Gradiente_Conjugado.m`)

O método do Gradiente Conjugado é um dos algoritmos mais eficientes para otimização irrestrita de larga escala. Ele melhora a convergência lenta do método de Descida Íngreme sem incorrer no alto custo do método de Newton. A ideia é que as direções de busca sucessivas sejam mutuamente conjugadas em relação à matriz Hessiana. A nova direção de busca é uma combinação linear do gradiente negativo atual e da direção de busca anterior: $d_{k+1} = -g_{k+1} + \beta_k d_k$. Para uma função quadrática de $n$ variáveis, este método garante a convergência para o mínimo em no máximo $n$ iterações. O gráfico a seguir apresenta a trajetória de otimização para esse método:

<img width="700" height="525" alt="473253492-73873387-62d5-49d9-b162-f8eecda40a48" src="https://github.com/user-attachments/assets/0a907aef-322b-4822-a86e-41522859cfd6" />

## Referências

[1] [Antoniou, 2007] Antoniou, A. and Lu, W.S. Practical Optimization: Algorithms and Engineering Applications, Springer, 2007

[2] [Rao, 2009] Singiresu S. Rao. Engineering Optimization: Theory and Practice, Fourth Ed., 2009, Wiley

[3] [Luenberger 2008] D.G. Luenberger, Y. Ye, Linear and Nonlinear Programming, Third Ed., Addison Wesley, 2008, Springer

[4] Stephen Boyd, Lieven Vandenberghe. Convex Optimization. Cambridge University Press 2004
