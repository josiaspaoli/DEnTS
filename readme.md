# DEnTS

## 1 Introdução
	O ambiente aqui descrito foi desenvolvido por Josias Paoli Reis como parte de seu trabalho de conclusão do curso de Engenharia Elétrica da Universidade Federal de Viçosa (UFV) em dezembro de 2017. O autor pode ser contatado a partir do email josiaspaoli@gmail.com.
	O DEnTS (Dynamic Environment for Texas hold’em poker Systems) é um ambiente no limits texas hold’em poker feito em Matlab que possibilita o desenvolvimento de IAs nessa plataforma, possibilitando que diferentes IAs batalhem entre si ou que um jogador humano jogue contra diversas IAs, inclusive com a possibilidade de armazenamento de um log com as ações e as variáveis em cada uma das ações. O programa é baseado no OOPoker, criado por Lode Vandevenne, hospedado em https://github.com/lvandeve/oopoker.
	Nesse manual encontra-se breves descrições sobre as configurações do programa e variáveis de comunicação com as IAs desenvolvidas. Mais detalhes sobre o funcionamento do OOPoker, as regras do texas hold’em poker e a terminologia aqui utilizada podem ser encontrados no arquivo readme desse programa, disponibilizado junto de seu código fonte no link onde está hospedado.

## 2 Configurações
	Descrições sobre as opções de jogo são encontradas no programa, entretanto melhores descrições dos modos de jogo, das IAs disponíveis e das variáveis envolvidas são descritas nas seções subsequentes.

### 2.1 Modos de jogo
	Para facilitar a interface do programa com o usuário, o programa possui três modos, selecionáveis durante a configuração da simulação, sendo eles:
    
    • Modo 1 (Teste IA) – Permite que uma única IA implementada no Matlab batalhe contra o número desejado de cada uma das IAs previamente implementadas no OOPoker;
    • Modo 2 (Batalha IA) – Possibilita que IAs implementadas no Matlab joguem entre si;
    • Modo 3 (Humano) – Permite que um jogador humano jogue com IAs implementadas tanto no OOPoker quanto no Matlab, mostrando as artes e as informações originais daquele aplicativo.
    
	Nos modos 1 e 2, pode-se optar por salvar um log original do OOPoker, enquanto no modo 3, dado à falta de necessidade de alta performance, salva-se automaticamente um log como o dos outros modos, além de um arquivo .mat contendo todas as ações tomadas pelo jogador humano e as entradas associadas a cada uma delas. Essa informação pode ser utilizada no desenvolvimento de outras IAs.

### 2.2 Tipos de IA
	As IAs disponíveis originalmente no OOPoker que podem ser colocadas na mesa são:
    
    • IA Random – Toma ações aleatórias, tendo 24% de chance de fold, 1 % de chance de all-in, 45% de chance de call e 30% de chance de bet/raise, dessa forma possuindo tendências agressivas;
    • IA BlindLimp – Somente paga os blinds, qualquer maior aposta no pre-flop ou apostas de qualquer tamanho em rodadas posteriores resultam em um fold desse jogador;
    • IA Call – Paga qualquer aposta, mas nunca aumenta ou faz a primeira aposta, com exceção dos blinds obrigatórios;
    • IA Check/Fold – Nunca paga uma aposta, efetuando checks se possível;
    • IA Raise – Sempre efetua o mínimo raise possível;
    • IA Smart – Implementada pelo criador do OOPoker, essa IA analisa diversas variáveis, inclusive verificando quantas possíveis mãos do oponente ganhariam da sua para tomar suas decisões.
    
	O número total de IAs em uma mesa (incluindo as desenvolvidas pelo usuário) nunca deve ultrapassar 10.
	No modo 2 adiciona-se somente IAs implementadas em MATLAB e no modo 3 primeiro se configura a quantidade de IAs do OOPoker e depois a quantidade de IAs feitas em MATLAB.

### 2.3 Tightness
	Tightness é um parâmetro da IA Smart implementada pelo criador do OOPoker que pode assumir valores de 0 a 0,99 e representa o quão conservadora essa IA será, sendo 0 uma IA completamente agressiva e 0,99 uma IA muito conservadora. Seu valor padrão é 0,8 (considerado o melhor resultado pelo criador da IA). Dentro do DEnTS, esse valor pode ser entre 0,65 e 0,99 e deve ser determinado antes da simulação pelo usuário para cada IA Smart presente na mesa.

## 3 Desenvolvendo sua IA
	As IAs desenvolvidas devem estar em scripts do MATLAB com nomes AI1.m, AI2.m, sucessivamente até AI10.m, que representam as 10 IAs customizadas que podem ser colocadas na mesa. Tenha em mente o fato de, por exemplo, no caso da mesa possuir três IAs personalizadas, serão as IAs contidas nos arquivos IA1, IA2 e IA3, sendo exigido organizá-las quando necessário.
	ATENÇÃO! – Uma vez que a rotina main adiciona todas as pastas e subpastas ao diretório do MATLAB, certifique-se de que cada script criado para sua IA tenha um nome único, independente da pasta onde ele esteja.

### 3.1 Entradas
	São passadas a cada um dos scripts correspondentes a jogadores criados os seguintes valores:
	Cartas – Vetor 1x7 contendo as cartas do jogador e as cartas da mesa, quando disponíveis. As duas primeiras cartas são as cartas da mão do jogador, as três subsequentes representam o flop, a seguinte representa turn e a última o river. Os elementos desse vetor assumem valores de -1 a 51, onde -1 representa uma carta da mesa ainda não revelada (portanto desconhecida), os primeiros 13 valores (de 0 a 12) representam as cartas A, 2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q e K, respectivamente, de paus. As treze seguintes representam as cartas de ouros na mesma ordem, seguidas das cartas de copas e espadas.

	Dados – Vetor 1x12 contendo alguns dados da mesa, sendo eles, respectivamente: 
	1 – Valor do big blind. 
	2 – Valor do stack. 
	3 – Posição do jogador relativa ao dealer na mesa. Esse valor é 1 caso o jogador seja o dealer, 2 se for o small blind, aumentando até n, onde n é o número de jogadores ativos. 
	4 – Lugar do dealer na mesa. Assumindo valores de 1 até n, representa em qual “cadeira” o dealer está sentado. Esse valor é fixo para cada jogador dentro de um torneio, sendo utilizado em conjunto com o vetor Dados e a matriz Histórico, portanto cada jogador é unicamente identificado por um número.
	5 – Lugar do jogador na mesa. Análogo ao lugar do dealer na mesa, representando o lugar do jogador.
	6 – Rodada em que o jogo se encontra (1 = pré-flop, 2 = flop, 3 = turn, 4 = river)
	7 – Valor do pot.
	8 – Valor do wager do jogador (quantidade de fichas movidas para a mesa no total pelo jogador)
	9 – Valor do call, ou seja, quantidade mínima de fichas que o jogador precisa passar à mesa, além de seu wager, para que continue jogando.
	10 – Valor mínimo do raise, ou seja, em caso de um raise do jogador, a quantidade mínima de fichas movidas para a mesa pelo jogador nessa rodada deve ser o valor do call somado ao raise mínimo.
	11 – Número de jogadores ativos, ou seja, que ainda tem fichas disponíveis (não foram eliminados).
	12 – Número de jogadores que ainda decidem na rodada, ou seja, que ainda não deram fold. 

	Estado – Matriz 4xN, sendo N o número total de jogadores, contendo informações disponíveis de todos os jogadores na mesa, sendo elas: posição referente ao dealer, stack, wager e uma variável binária que indica se o jogador desistiu da mão (ela é 1 caso o jogador tenha desistido). Cada coluna representa um jogador e as linhas representam as informações. A primeira coluna é referente ao jogador sentado na “cadeira 1”, a segunda referente à “cadeira 2”, e assim sucessivamente. Quando o jogador está eliminado (não possui mais fichas), a coluna referente a ele é preenchida com zeros.

	Histórico – Matriz 6x4xN, sendo N o número total de jogadores, contendo o número de folds, calls, bets, raises, re-raises e all-ins de cada jogador em cada rodada (pre-flop, flop, turn e river) dentro de todos os torneios jogadas na mesma simulação. A primeira dimensão dessa matriz representa cada uma das ações, a segunda representa a rodada e a terceira os jogadores.

	Em simulações com mais de um torneio, os jogadores são embaralhados ao final de cada uma. Entretanto, para que haja coerência, a matriz histórico também é reorganizada de acordo, e a nova matriz estado também estará de acordo com essa nova ordem. Sendo assim, as posições mostradas no final da siulaçao correspondem às posições no último torneio, somente.
	Vale lembrar que os nomes das matrizes foram dados pelo criador da IA e podem ser modificados caso seja a vontade do usuário.

### 3.2 Saída
	O programa principal deve receber de cada IA desenvolvida somente um valor, referente à quantidade de fichas a serem passadas para a mesa em dada ação. Portanto o desenvolvedor deve tomar cuidado para não passer valores inválidos como saída, para que não haja efeitos indesejados, apesar de o OOPoker arredondar para o máximo valor válido abaixo do valor passado a ele, caso esse seja invalido. 
	Se o valor passado como saída for menor que o valor do call, o programa automaticamente executa um fold. Caso o valor passado seja maior que o valor do call, mas menor que esse parâmetro somado ao raise mínimo, o programa executa uma ação call, exceto quanto o valor do call é 0, executando nesse caso um fold.
