# RandomPick

Applicação para realizar sorteios

desenvolvida por @adubas

## Index

1. [Requirements](#requirements)
2. [Setup](#setup)
3. [Libs](#libs)
4. [Testing](#testing)

## Requirements

[Docker](https://docs.docker.com/get-docker/)
[Docker compose](https://docs.docker.com/compose/install/)

## Setup

Initial setup configuration trough docker-compose run

```bash
$ docker-compose build
$ docker-compose run --rm --service-ports app bash
$ mix setup
$ mix phx.server
```

> Access application on `http://localhost:4000/`

## Libs

[Oban](https://github.com/sorentwo/oban), escolhida por ser um lib robusta que executa jobs e que tem
pouca dependências.

[EX-Machina](https://github.com/thoughtbot/ex_machina), escolhida por facilitar a criação de data em testes.

[Faker](https://github.com/elixirs/faker), escolhida para gerar dados falsos para os testes.

## Testing

Run the following

```bash
$ docker-compose run --rm --service-ports app bash
$ mix test
```
