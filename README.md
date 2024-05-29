# pontinho_score

Estruturar dados de pontuação de jogo familiar conhecido como **pontinho**, a fim de poder gerar resultados e estatísticas a partir de dados digitados `txt`, em alimentação manual a partir de anotações em imagens `img/`.

# estrutura

- `img/`: imagens das pontuações
- `test_data/`: amostras para testes

## nomes

- `img/`: data_id
  - `data`: yyyy-mm-dd
  - `id`: int
- `test_data`: data_id_order
  - `data`: yyyy-mm-dd
  - `id`: int[1]
  - `order`: int[1]

# score

Cada jogador inicia a partira com 99 pontos, a cada rodada, o batedor desconta 0, e os demais desconta os pontos na mão da pontuação inicial.
Rodadas sucessivas ocorrem, enquanto isso, quando o jogador fica com pontuação resultante negativa, marca-se um X correpondendo à quantidade de *estouros*, e o jogador retorna com a menor pontuação dentre os demais.
O jogo prossegue rodada após rodada até sobrar sem estourar apenas um único batedor.

## tabela de pontuação

Em txt bruto separado por espaço.
- 1a linha: jogadores
- pontuação inicial omitida: 99 para cada
- linha par: identificador do *dealer* da rodada, seguido da pontuação a descontar de cada jogador
- linha ímpar: sem identificador, apenas as pontuações remanescentes após rodada
- última linha: placar final

- jogadores ausentes na rodada terão `-` marcados em lugar dos pontos
