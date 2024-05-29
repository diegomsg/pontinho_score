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
