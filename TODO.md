# TODO - Estatísticas: Nacionalidades & Rankings

- [x] Atualizar `index.html` adicionando Chart.js e containers HTML para:

  - [ ] gráfico de barras por nacionalidades (relativo)
  - [ ] ranking Top 5 por jogos, golos e assistências
- [ ] Implementar helpers JS para:
  - [ ] normalizar nacionalidade (ex: vazio -> "Desconhecida")
  - [ ] ordenar/limitar Top 5
- [ ] Atualizar `calcularEstatisticas()` para:
  - [ ] calcular percentagens por nacionalidade com base em `ativo=true`
  - [ ] calcular rankings por `jogos_clube`, `golos_clube`, `assistencias_clube`
- [ ] Renderizar o gráfico e rankings ao entrar na view `estatisticas`
- [ ] Validar no browser:
  - [x] gráfico aparece
  - [x] rankings aparecem com nomes e valores


