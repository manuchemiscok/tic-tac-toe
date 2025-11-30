# Tic-Tac-Toe - Jogo da Velha

Um jogo da velha implementado em Assembly para o Processador-ICMC, com interface gráfica e jogabilidade contra a máquina.

## Instruções do Jogo

### Como Jogar

O jogo é **baseado em turnos**, sendo sempre o **jogador contra a máquina**:

#### **Turno do Jogador (Você)**
1. Use o **teclado numérico (1-9)** para selecionar uma casa no tabuleiro:
   ```
   1 | 2 | 3
   ---------
   4 | 5 | 6
   ---------
   7 | 8 | 9
   ```
2. Após selecionar a casa desejada, pressione **ENTER** para confirmar sua jogada
3. A casa será marcada com um **X**

#### **Turno da Máquina**
1. A máquina escolhe uma casa de forma **pseudo-aleatória**
2. Um seletor circula pela lista de casas numéricas disponíveis (1-9)
3. Pressione **ENTER** para confirmar a jogada da máquina no momento desejado
4. A casa será marcada com um **O**

### Funcionamento da Seleção Aleatória

A máquina utiliza um algoritmo **pseudo-aleatório** que:
- Percorre **circularmente** as casas disponíveis do tabuleiro
- Incrementa a posição continuamente enquanto aguarda o ENTER
- Salva a posição **exatamente no momento** em que você pressiona ENTER
- Coloca o **O** na casa correspondente

### Condições de Vitória

- **Você vence**: Consegue formar uma linha (horizontal, vertical ou diagonal) com 3 **X**s
- **Máquina vence**: Consegue formar uma linha com 3 **O**s
- **Empate**: Quando o tabuleiro se enche sem ninguém vencer

### Ajuste de Delays

Os delays do jogo podem ser ajustados dependendo da **frequência do ciclo de clock** da máquina que estiver rodando. Se o jogo ficar muito rápido ou lento, os valores de delay no código Assembly podem ser modificados para melhor experiência.

## Demonstração

Veja o jogo em ação:

<div align="center">
  <img src="https://media.rubrion.ai/tictactoe.gif" alt="Gameplay do Tic-Tac-Toe" width="500">
  
  *Gameplay do Jogo da Velha contra a máquina*
</div>

## Implementação Técnica

- **Linguagem**: Assembly (Processador-ICMC)
- **Tipo de Projeto**: Jogo interativo com interface de texto
- **Recursos Utilizados**:
  - Teclado para entrada do usuário
  - Buffer de tela para renderização
  - Algoritmo pseudo-aleatório para a máquina
  - Lógica de detecção de vitória/derrota

## Estrutura do Projeto

- `titatoe.asm`: Código fonte principal em Assembly
- `titatoe.mif`: Arquivo de inicialização da memória
- `charmap.mif`: Mapa de caracteres para a interface
- `Processador-ICMC/`: Submodulo contendo os arquivos do processador e montador

## Como Executar

O jogo foi desenvolvido para rodar no simulador do **Processador-ICMC**. Consulte o repositório [Processador-ICMC](https://github.com/manuchemiscok/Processador-ICMC/tree/dd9800769f8b359caa216b6ae1a26a281037af8a) para instruções de montagem e execução do código.