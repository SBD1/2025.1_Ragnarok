---

---

# Visão Geral de Desenvolvimento do jogo

## Tecnologias Escolhidas

Para este projeto de jogo, as seguintes tecnologias foram cuidadosamente selecionadas para garantir um desenvolvimento eficiente, escalável e de fácil manutenção:

### 1. **Python**

* **Finalidade:** Linguagem de programação principal para a lógica do jogo, interação com o banco de dados e possivelmente a interface de usuário.
* **Motivo da Escolha:**
    * **Versatilidade:** Python é uma linguagem multipropósito, com vastas bibliotecas para diversas áreas.
    * **Sintaxe Clara:** Sua sintaxe limpa e legível acelera o desenvolvimento e facilita a colaboração em equipe.

### 2. **PostgreSQL**

* **Finalidade:** Sistema de gerenciamento de banco de dados relacional (SGBDR) para armazenar todos os dados persistentes do jogo, como informações de jogadores, personagens, inventário, estados de missões, etc.
* **Motivo da Escolha:**
    * **Confiabilidade e Robustez:** Conhecido por sua estabilidade, integridade de dados e recursos avançados para garantir a consistência das informações.
    * **Código Aberto:** É um software de código aberto, o que reduz custos e permite personalização se necessário.

### 3. **Docker e Docker Compose**

* **Finalidade:** Ferramentas de conteinerização para empacotar e executar o banco de dados (e futuramente, outros serviços) em ambientes isolados e portáteis.
* **Motivo da Escolha:**
    * **Portabilidade:** Garante que o ambiente de desenvolvimento seja o mesmo em qualquer máquina, eliminando problemas como "funciona na minha máquina".
    * **Isolamento:** Cada serviço (como o PostgreSQL) roda em seu próprio container, isolado do sistema operacional host e de outros serviços.
    * **Facilidade de Configuração:** O Docker Compose permite definir e orquestrar múltiplos serviços com um único arquivo YAML, simplificando a inicialização do ambiente.
    * **Consistência:** Assegura que todos os desenvolvedores trabalhem com as mesmas versões e configurações das dependências.

Essas tecnologias formam uma base sólida para o desenvolvimento do seu jogo, oferecendo flexibilidade, robustez e uma experiência de desenvolvimento simplificada.

# Funcionalidades do Jogo

## 1. Módulo de Autenticação e Conta

Este módulo abrange todas as funcionalidades relacionadas ao acesso e gerenciamento da conta do jogador.

### 1.1. Login

**Descrição:** Permite que jogadores existentes acessem suas contas para continuar sua jornada no jogo.

**Requisitos:**
* **Acesso:** O usuário deve ser capaz de iniciar o processo de login a partir da tela inicial do jogo.
* **Credenciais:** O sistema deve solicitar um nome de usuário (ou e-mail) e uma senha.
* **Validação:** As credenciais fornecidas devem ser validadas contra o banco de dados.
    * **Sucesso:** Se as credenciais forem válidas, o jogador é autenticado e direcionado para a tela de seleção/criação de personagem ou para a última localização do personagem ativo.
    * **Falha:** Se as credenciais forem inválidas, o sistema deve exibir uma mensagem de erro clara (ex: "Nome de usuário ou senha incorretos").
* **Segurança:** A senha deve ser armazenada de forma segura (hashing e salting) no banco de dados e nunca transmitida em texto puro.
* **Recuperação de Senha (Futuro):** Previsão para funcionalidade de recuperação de senha (ex: via e-mail).

**Entradas:**
* Nome de Usuário (string)
* Senha (string)

**Saídas:**
* Acesso ao jogo (sucesso)
* Mensagem de erro (falha)

---

## 2. Módulo de Criação de Personagem

Este módulo permite que novos jogadores, ou jogadores existentes com slots vazios, criem seus avatares no mundo do jogo.

### 2.1. Criação de Personagem

**Descrição:** Permite ao jogador criar um novo personagem, definindo seus atributos e aparência inicial.

**Requisitos:**
* **Acesso:** Disponível após o login bem-sucedido, se o jogador não tiver personagens ou desejar criar um novo em um slot disponível.
* **Nome do Personagem:** O jogador deve inserir um nome único para o personagem.
    * **Validação:** O nome deve ser validado para unicidade no servidor. O sistema deve informar se o nome já estiver em uso.
    * **Restrições:** O nome pode ter restrições de comprimento e caracteres permitidos.
* **Confirmação:** Após a criação, o personagem é salvo no banco de dados e o jogador é direcionado para a tela de seleção de personagem ou diretamente para o mapa inicial do jogo.

**Entradas:**
* Nome do Personagem (string)


**Saídas:**
* Novo personagem salvo no banco de dados.
* Personagem disponível para seleção.
* Mensagem de erro (ex: nome já em uso, validação falha).

---

## 3. Módulo de Navegação e Movimentação

Este módulo lida com a interação do jogador com o ambiente do jogo e a exploração do mapa.

### 3.1. Andar pelo Mapa (Movimentação Básica)

**Descrição:** Permite que o personagem do jogador se mova pelo ambiente do jogo, explorando diferentes áreas e interagindo com o mundo.

**Requisitos:**
* **Liberação de Movimento:** O movimento do personagem deve ser habilitado após o carregamento bem-sucedido da área do mapa.
* **Atualização de Posição:** A posição do personagem deve ser atualizada em tempo real na interface do usuário.
* **Persistência:** A última posição conhecida do personagem deve ser salva no banco de dados para que, ao fazer login novamente, o jogador retorne ao mesmo local.

**Entradas:**
* Comandos de movimento.

**Saídas:**
* Movimento do personagem no mapa.
* Atualização da posição na interface do usuário.
* Posição atualizada no banco de dados.



## Histórico de Versão

|  Versão  |     Data     | Descrição | Autor(es) | Revisor(es) |
| :------: | :----------: | :-----------: | :---------: | :---------: |
| `1.0` | 16/06/2025 | Criação de documento e primeira versão do Jogo em código | [Danilo Naves](https://github.com/DaniloNavesS) | [Ian Costa](https://github.com/iancostag) |
