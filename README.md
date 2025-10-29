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

### Sobre o desafio

Para este desafio, utilizei services com a gem Interactor. Embora eu ainda não tenha muita experiência com ela, a abordagem funcionou muito bem para separar e organizar as regras de negócio, especialmente no caso do scraper. 
Com o uso de organizers, foi possível dividir cada etapa em classes independentes e executá-las em sequência, deixando o código mais legível e de fácil manutenção.
Exemplo: `app/services/interactors/github/organizers/profile_scraper_organizer.rb`

Outro ponto de destaque foi a busca `full-text` com `sqlite`, utilizando o módulo [FTS5](https://sqlite.org/fts5.html) Foi minha primeira experiência com essa funcionalidade, e gostei bastante: é simples de configurar, mas requer atenção para manter os dados da entidade Profile sincronizados com a tabela virtual de busca. Um ponto negativo é que, ao realizar buscas, é necessário escapar caracteres especiais.


