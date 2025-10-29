# Profile Search

Project to save copies of GitHub profiles, using Playwright for scraping, SQLite FTS5 for full-text search, and integration with Short.io to shorten links.

## Setup and Run

1. **Clone the repository**
  - git clone `git@github.com:joaoscotto/gh-profile.git`
  - cd github-profiles
  - docker compose build
  - docker compose up -d

2. **Open your browser and go to:**
  - http://localhost:3000

---

## Sobre o desafio

### Destaques

Para este desafio, utilizei services com a gem Interactor. Embora eu ainda não tenha muita experiência com ela, a abordagem funcionou muito bem para separar e organizar as regras de negócio, especialmente no caso do scraper. 
Com o uso de organizers, foi possível dividir cada etapa em classes independentes e executá-las em sequência, deixando o código mais legível e de fácil manutenção.
Exemplo: `app/services/interactors/github/organizers/profile_scraper_organizer.rb`

Outro ponto de destaque foi a busca `full-text` com `sqlite`, utilizando o módulo [FTS5](https://sqlite.org/fts5.html) Foi minha primeira experiência com essa funcionalidade, e gostei bastante: é simples de configurar, mas requer atenção para manter os dados da entidade Profile sincronizados com a tabela virtual de busca. Um ponto negativo é que, ao realizar buscas, é necessário escapar caracteres especiais.

Configurei o RSpec e implementei alguns testes de exemplo. Tive pouco tempo, então não consegui fazer uma cobertura mais ampla, mas acredito que já dá para ter uma boa ideia da estrutura. Utilizei a gem factory_bot_rails e segui as convenções recomendadas pelo betterspecs.org.

- https://github.com/joaoscotto/gh-profile/blob/main/spec/controllers/profiles_controller_spec.rb
- https://github.com/joaoscotto/gh-profile/blob/main/spec/model/profile_spec.rb


### Dificuldades

A primeira foi na implementação do scraping. Inicialmente, utilizei o nokogiri, mas a informação de "contribuições do último ano" no GitHub é renderizada via turbo-frame, e como o nokogiri não processa js, precisei de uma ferramenta mais robusta. Escolhi o Playwright por ter uma boa documentação, suporte a JS e manutenções recentes. A instalação, porém, é mais complexa, dependendo de várias bibliotecas e do node.

Outro ponto desafiador foi a interface. No início, tive dificuldade para definir o layout e acabei utilizando apenas ERB com Bootstrap. Pensando agora, depois de finalizado, seria interessante ter implementado com vuejs ou turbo + stimulus, tornaria a interface mais fluida e demonstraria melhor conhecimento em JavaScript.

### Melhorias

- Melhorar a cobertura de testes e implementar testes end-to-end com Capybara
- Aprimorar o front-end:
  - Adicionar validações
  - Exibir indicador de loading ao criar ou editar registros
  - Evitar que o botão de salvar possa ser clicado várias vezes, gerando múltiplos envios
  - Indicar que alguns campos podem demorar para atualizar, já que o scraping e o encurtamento de links são executados de forma assíncrona
- Adicionar o Playwright no Dockerfile de produção
- Otimizar o processo de scraping; algumas configurações já foram aplicadas, mas acredito que existam ajustes melhores
- A implementação da busca com FTS5 também pode ser melhorada. Fiz uma implementação inicial rápida, mas é possível aumentar a assertividade da busca e tratar melhor os problemas com caracteres especiais.
