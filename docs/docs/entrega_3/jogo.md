# Jogo Finalizado

Nosso projeto consiste em um jogo Multi-User Dungeon (MUD), jogável via terminal, inspirado no universo do Ragnarok Online. Desenvolvido com foco didático, o jogo integra os principais conceitos de bancos de dados relacionais, sendo uma aplicação prática dos conhecimentos adquiridos ao longo da disciplina de Banco de Dados 1.

## Aspectos Técnicos e Banco de Dados
O sistema foi projetado a partir de um Diagrama Entidade-Relacionamento (DER), posteriormente convertido para um modelo relacional. As operações do jogo são suportadas por um banco de dados PostgreSQL e envolvem:

- DDL (Data Definition Language): criação e estruturação de tabelas e relacionamentos.
- DML (Data Manipulation Language): inserção, atualização e exclusão de dados durante o jogo.
- DQL (Data Query Language): consultas para exibir status, inventário e interações com o mundo.
- Triggers: automatizam processos como a criação de inventário ao se registrar um personagem.
- Stored Procedures: encapsulam lógicas complexas, como o uso de habilidades e movimentação.
- Views: facilitam o acesso a informações como status geral do personagem ou resumo do inventário.

Este projeto não só entrega uma experiência de jogo divertida e interativa, como também demonstra na prática como conceitos de banco de dados podem ser aplicados a sistemas reais. Trata-se de um exemplo completo de integração entre lógica de programação, estrutura de dados e modelagem de informação.

## Como faço para jogar?

Siga os passos indicados no [**README**](https://github.com/SBD1/2025.1_Ragnarok/blob/main/README.md) do projeto.

## Histórico de Versão

|  Versão  |     Data     | Descrição | Autor(es) | Revisor(es) |
| :------: | :----------: | :-----------: | :---------: | :---------: |
| `1.0` | 06/07/2025 | Criação do documento | [Cauã Araujo](https://github.com/caua08) | [Danilo Naves](https://github.com/DaniloNavesS) |