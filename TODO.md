# TODO - Estatísticas por Plantel/Época + Histórico (zerozero.pt)

## Planeado
- [x] 1) Criar UI dentro da view `estatisticas`: menu/filtragem por **Época** e **Escalão** (traquinas/iniciadas/juniores/seniores)
- [x] 2) Implementar rankings por plantel e época: **Jogos / Golos / Assistências** agregando via `vinculo_epocas`
- [x] 3) Atualizar modal `Ver Atleta` para mostrar **histórico por épocas** do atleta (busca `vinculo_epocas` por `id_jogadora`)

- [ ] 4) Ajustar estatísticas gerais:
  - [ ] 4.1) Gráfico nacionalidades de **todas** as atletas
  - [ ] 4.2) Gráfico posições de **ativas** e de **todas**
  - [ ] 4.3) Média de idades **apenas ativas**
- [ ] 5) Desenhar novos gráficos com Chart.js e ligar à função `calcularEstatisticas()`
- [ ] 6) Testar no browser: filtros, rankings, modal histórico e gráficos

