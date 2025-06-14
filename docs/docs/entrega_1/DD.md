---

---

# Ragnarok MUD - Dicionário de Dados
O Dicionário de Dados é uma fonte que descreve de forma detalhada todos os elementos de dados de um banco de dados, como tabelas, campos, tipos de dados, restrições, relacionamentos e índices. Ele funciona como uma documentação técnica que padroniza e organiza as informações estruturais do banco, servindo tanto para o desenvolvimento quanto para a manutenção do sistema. Sua principal função é garantir a consistência e a integridade dos dados, além de facilitar a comunicação entre desenvolvedores e analistas.

## Entidade: JOGADOR
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idJogador|INT|Identificador do jogador.|1-100|Não|Sim. Chave primária|-|
|usuario|VARCHAR(20)|Nome de usuário do jogador.|A-Z, a-z|Não|Não|-|
|email|VARCHAR(50)|Email do jogador.|A-Z, a-z, @, ., 0 - 9|Não|Não|-|
|senha|VARCHAR(50)|Senha do jogador.|A-Z, a-z, @, #|Não|Não|-|

## Entidade: PERSONAGEM
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idPersonagem|INT|Identificador do personagem.|0 - 100|Não|Sim. Chave primária|-|
|idJogador|INT|Chave estrangeira de jogador.|0 - 100|Não|Sim. Chave estrangeira|-|
|idMissao|INT|Chave estrangeira de missao.|0 - 100|Não|Sim. Chave estrangeira|-|
|idSala|INT|Identificador único de sala.|1 - 100|Não|Sim. Chave estrangeira.|-|
|nome|VARCHAR(20)|Nome do personagem|a–z, A–Z|Não|Não|-|
|vida|INT|Pontos de vida|≥ 1|Não|Não|-|
|mana|INT|Pontos de mana|≥ 1|Não|Não|-|
|vitalidade|INT|Atributo: Vitalidade|≥ 1|Não|Não|-|
|inteligencia|INT|Atributo: Inteligência|≥ 1|Não|Não|-|
|agilidade|INT|Atributo: Agilidade|≥ 1|Não|Não|-|
|sorte|INT|Atributo: Sorte|≥ 1|Não|Não|-|
|destreza|INT|Atributo: Destreza|≥ 1|Não|Não|-|
|forca|INT|Atributo: Força|≥ 1|Não|Não|-|
|ataque|INT|Ataque físico|≥ 1|Não|Não|-|
|ataqueMagico|INT|Ataque mágico|≥ 1|Não|Não|-|
|precisao|INT|Precisão|≥ 1|Não|Não|-|
|esquiva|INT|Esquiva|≥ 1|Não|Não|-|
|defesa|INT|Defesa física|≥ 1|Não|Não|-|
|defesaMagica|INT|Defesa mágica|≥ 1|Não|Não|-|
|critico|INT|Chance de crítico|0 - 100|Não|Não|-|
|velocidade|INT|Velocidade de ataque|0 - 100|Não|Não|-|
|nivel|INT|Nível do personagem|≥ 1|Não|Não|-|
|dinheiro|INT|Quantidade de dinheiro|0 - 1000|Não|Não|-|

## Entidade: CLASSE
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idClasse|INT|Identificador de classe.|1-100|Não|Sim. Chave primária|-|
|nomeClasse|VARCHAR(20)|Nome da classe.|a–z, A–Z|Não|Não|-|
|descricao|TEXT|Breve descrição da classe.|a–z, A–Z|Não|Não|-|

## Entidade: HABILIDADE
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idHabilidade|INT|Identificador de habilidade.|1 - 100|Não|Sim. Chave Primária.|-|
|idClasse|INT|Identificador de habilidade.|1 - 100|Não|Sim. Chave estrangeira.|-|
|nomeHabilidade|VARCHAR(20)|Nome da habilidade.|a–z, A–Z|Não|Não|-|
|descricao|TEXT|Breve descrição da habilidade.|a–z, A–Z|Não|Não|-|
|custoMana|INT|Valor de custo da mana.|1 - 1000|Não|Não|-|
|nivelRequerido|INT|Nível requerido para a habilidade.|1 - 100|Não|Não|-|
|dano|INT|Dano causado pela habilidade.|1 - 1000|Não|Não|-|

## Entidade: SALA
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idSala|INT|Identificador de sala.|1 - 100|Não|Sim. Chave Primária.|-|
|idCima|INT|Identificador de localização de cima.|1 - 100|Não|Não|-|
|idBaixo|INT|Identificador de localização de baixo.|1 - 100|Não|Não|-|
|idEsquerda|INT|Identificador de localização de esquerda.|1 - 100|Não|Não|-|
|idDireita|INT|Identificador de localização de direita.|1 - 100|Não|Não|-|
|nomeSala|VARCHAR(20)|Nome da sala.|a–z, A–Z|Não|Não|-|
|descricaoSala|TEXT|Breve descrição da sala.|a–z, A–Z|Não|Não|-|

## Entidade: INVENTARIO
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idInventario|INT|Identificador do inventário.|1 - 100|Não|Sim. Chave Primária.|-|
|idPersonagem|INT|Identificador do personagem.|1 - 100|Não|Sim. Chave estrangeira.|-|
|capacidadeSlots|INT|Quantidade da capacidade do slot.|0 - 100|Não|Não|-|
|slotsUsados|INT|Quantidade de slots utilizados.|1 - 100|Não|Não|-|

## Entidade: ITEM
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idItem|INT|Identificador único do item.|1 - 100|Não|Sim. Chave Primária.|-|
|idNpcCombatente|INT|Identificador único do NPC Combatente.|1 - 100|Não|Sim. Chave estrangeira.|-|
|tipoItem|VARCHAR(15)|Tipo geral do item (ex: arma, poção).|a–z, A–Z|Não|Não|tipoItem === { 'CONSUMIVEL', 'ARMA', 'ARMADURA'}|

## Entidade: ARMA
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idItem|INT|Identificador único do item.|1-100|Não|Sim. Chave Primária e Chave Estrangeira.|-|
|danoBase|INT|Valor base do dano causado pela arma.|1-1000|Não|Não|-|
|bonusDano|INT|Dano extra proporcionado pela arma.|1-1000|Não|Não|-|
|tipoArma|VARCHAR(20)|Tipo da arma (Espada, Adaga, Lança...)|a–z, A–Z|Não|Não|-|
|nomeItem|VARCHAR(20)|Nome que identifica o item.|a–z, A–Z|Não|Não|-|
|descricao|TEXT|Texto explicativo sobre o item.|a–z, A–Z|Não|Não|-|
|custoItem|INT|Custo em dinheiro do item.|1-1000|Não|Não|-|

## Entidade: LONGO_ALCANCE
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idArma|INT|Identificador único da Arma.|1 - 100|Não|Sim. Chave Primária e Chave Estrangeira.|-|
|tipoProjetil|VARCHAR(20)|Tipo de projétil utilizado (ex: flecha, bala)|a–z, A–Z|Não|Não|-|
|quantidadeProjetil|INT|Quantidade de projéteis disponíveis ou carregados|0 - 100|Sim|Não|-|
|nomeItem|VARCHAR(20)|Nome que identifica o item.|a–z, A–Z|Não|Não|-|
|descricao|TEXT|Texto explicativo sobre o item.|a–z, A–Z|Não|Não|-|
|custoItem|INT|Custo em dinheiro do item.|1 - 1000|Não|Não|-|

## Entidade: MAGICA
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idArma|INT|Identificador único da arma.|1 - 100|Não|Sim. Chave Primária e Chave Estrangeira.|-|
|tipoMagia|VARCHAR(20)|Tipo de magia associada ao item ou personagem|a–z, A–Z|Não|Não|-|
|efeitoMagico|VARCHAR(300)|Efeito causado pela magia ao ser utilizada|a–z, A–Z|Não|Não|-|
|nomeItem|VARCHAR(20)|Nome que identifica o item.|a–z, A–Z|Não|Não|-|
|descricao|TEXT|Texto explicativo sobre o item.|a–z, A–Z|Não|Não|-|
|custoItem|INT|Custo em dinheiro do item.|1 - 1000|Não|Não|-|

## Entidade: ARMADURA
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idItem|INT|Identificador único do item.|1 - 100|Não|Sim. Chave Primária e Chave Estrangeira.|-|
|tipoArmadura|VARCHAR|Tipo da armadura.|a–z, A–Z|Não|Não|-|

## Entidade: PEITORAL
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idArmadura|INT|Identificador único da peça.|1 - 100|Não|Sim. Chave Primária e Chave Estrangeira.|-|
|bonusVida|INT|Bônus adicional de pontos de vida concedido pelo peitoral.|1 - 100|Não|Não|-|
|bonusDefesa|INT|Bônus adicional de defesa concedido pelo peitoral.|1 - 100|Não|Não|-|
|defesa|INT|Quantidade de defesa adicional.|1 - 100|Não|Não|-|
|defesaMagica|INT|Quantidade de defesa mágica adicional.|1 - 100|Não|Não|-|
|nomeItem|VARCHAR(20)|Nome que identifica o item.|a–z, A–Z|Não|Não|-|
|descricao|TEXT|Texto explicativo sobre o item.|a–z, A–Z|Não|Não|-|
|custoItem|INT|Custo em dinheiro do item.|1 - 1000|Não|Não|-|

## Entidade: CAPACETE
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idArmadura|INT|Identificador único da peça.|1 - 100|Não|Sim. Chave Primária e Chave Estrangeira.|-|
|bonusVida|INT|Bônus adicional de vida concedido.|1 - 100|Não|Não|-|
|defesa|INT|Quantidade de defesa adicional.|1 - 100|Não|Não|-|
|defesaMagica|INT|Quantidade de defesa mágica adicional.|1 - 100|Não|Não|-|
|nomeItem|VARCHAR(20)|Nome que identifica o item.|a–z, A–Z|Não|Não|-|
|descricao|TEXT|Texto explicativo sobre o item.|a–z, A–Z|Não|Não|-|
|custoItem|INT|Custo em dinheiro do item.|1 - 1000|Não|Não|-|

## Entidade: BOTA
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idArmadura|INT|Identificador único da peça.|1 - 100|Não|Sim. Chave Primária e Chave Estrangeira.|-|
|bonusVelocidade|INT|Bônus adicional de velocidade concedido.|1 - 100|Não|Não|-|
|defesa|INT|Quantidade de defesa adicional.|1 - 100|Não|Não|-|
|defesaMagica|INT|Quantidade de defesa mágica adicional.|1 - 100|Não|Não|-|
|nomeItem|VARCHAR(20)|Nome que identifica o item.|a–z, A–Z|Não|Não|-|
|descricao|TEXT|Texto explicativo sobre o item.|a–z, A–Z|Não|Não|-|
|custoItem|INT|Custo em dinheiro do item.|1 - 1000|Não|Não|-|

## Entidade: ESCUDO
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idArmadura|INT|Identificador único da peça.|1 - 100|Não|Sim. Chave Primária e Chave Estrangeira.|-|
|bonusVida|INT|Bônus adicional de pontos de vida concedido pelo escudo.|1 - 100|Não|Não|-|
|bonusDefesa|INT|Bônus adicional de defesa concedido pelo escudo.|1 - 100|Não|Não|-|
|defesa|INT|Quantidade de defesa adicional.|1 - 100|Não|Não|-|
|defesaMagica|INT|Quantidade de defesa mágica adicional.|1 - 100|Não|Não|-|

## Entidade: CAPA
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idArmadura|INT|Identificador único da peça.|1 - 100|Não|Sim. Chave Primária e Chave Estrangeira.|-|
|bonusVida|INT|Bônus adicional de pontos de vida concedido pela capa.|1 - 100|Não|Não|-|
|bonusCritico|INT|Bônus adicional de dano crítico concedido pela capa.|1 - 100|Não|Não|-|
|defesa|INT|Quantidade de defesa adicional.|1 - 100|Não|Não|-|
|defesaMagica|INT|Quantidade de defesa mágica adicional.|1 - 100|Não|Não|-|
|nomeItem|VARCHAR(20)|Nome que identifica o item.|a–z, A–Z|Não|Não|-|
|descricao|TEXT|Texto explicativo sobre o item.|a–z, A–Z|Não|Não|-|
|custoItem|INT|Custo em dinheiro do item.|1 - 1000|Não|Não|-|

## Entidade: ACESSORIO
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idArmadura|INT|Identificador único da peça.|1 - 100|Não|Sim. Chave Primária e Chave Estrangeira.|-|
|bonusVida|INT|Bônus adicional de pontos de vida.|1 - 100|Não|Não|-|
|bonusEsquiva|INT|Bônus na chance de esquivar de ataques.|1 - 100|Não|Não|-|
|bonusMana|INT|Bônus adicional de pontos de mana.|1 - 100|Não|Não|-|
|defesa|INT|Quantidade de defesa adicional.|1 - 100|Não|Não|-|
|defesaMagica|INT|Quantidade de defesa mágica adicional.|1 - 100|Não|Não|-|
|nomeItem|VARCHAR(20)|Nome que identifica o item.|a–z, A–Z|Não|Não|-|
|descricao|TEXT|Texto explicativo sobre o item.|a–z, A–Z|Não|Não|-|
|custoItem|INT|Custo em dinheiro do item.|1 - 1000|Não|Não|-|

## Entidade: CONSUMIVEL
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idItem|INT|Identificador único do item.|1 - 100|Não|Sim. Chave Primária e Chave Estrangeira.|-|
|tipoConsumivel|VARCHAR(20)|Aumento temporário em algum atributo do personagem.|a–z, A–Z|Não|Não|-|

## Entidade: COMIDA
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idConsumivel|INT|Identificador único do consumivel.|1 - 100|Não|Sim. Chave Primária e Chave Estrangeira.|-|
|bonusAtributo|INT|Aumento temporário em algum atributo do personagem.|1 - 100|Não|Não|-|
|tipoBonusAtributo|INT|Tipo do atributo bônus do personagem.|1 - 100|Não|Não|-|
|bonusAtributoDuracao|INT|Tempo de duração do bônus fornecido pela comida (em turnos/segundos).|1 - 60|Não|Não|-|
|nomeItem|VARCHAR(20)|Nome que identifica o item.|a–z, A–Z|Não|Não|-|
|descricao|TEXT|Texto explicativo sobre o item.|a–z, A–Z|Não|Não|-|
|custoItem|INT|Custo em dinheiro do item.|1 - 1000|Não|Não|-|

## Entidade: POCAO
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idConsumivel|INT|Identificador único do consumivel.|1 - 100|Não|Sim. Chave Primária e Chave Estrangeira.|-|
|recuperaVida|INT|Quantidade de pontos de vida restaurados.|1 - 100|Não|Não|-|
|recuperaMana|INT|Quantidade de pontos de mana restaurados|1 - 100|Não|Não|-|
|nomeItem|VARCHAR(20)|Nome que identifica o item.|a–z, A–Z|Não|Não|-|
|descricao|TEXT|Texto explicativo sobre o item.|a–z, A–Z|Não|Não|-|
|custoItem|INT|Custo em dinheiro do item.|1 - 1000|Não|Não|-|

## Entidade: PERGAMINHO
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idConsumivel|INT|Identificador único do consumivel.|1 - 100|Não|Sim. Chave Primária e Chave Estrangeira.|-|
|tipoBuff|VARCHAR(20)|Tipo de melhoria temporária concedida.|a–z, A–Z|Não|Não|-|
|duracaoBuff|INT|Duração do efeito do buff em turnos ou segundos.|1 - 100|Não|Não|-|
|nomeItem|VARCHAR(20)|Nome que identifica o item.|a–z, A–Z|Não|Não|-|
|descricao|TEXT|Texto explicativo sobre o item.|a–z, A–Z|Não|Não|-|
|custoItem|INT|Custo em dinheiro do item.|1 - 1000|Não|Não|-|

## Entidade: INSTANCIA_ITEM
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idInstanciaItem|INT|Identificador único da instância de item.|1 - 100|Não|Sim. Chave primária.|-|
|idItem|INT|Identificador único de item.|1 - 100|Não|Sim. Chave Primária e Chave Estrangeira.|-|
|idSala|INT|Identificador único de sala.|1 - 100|Não|Sim. Chave estrangeira.|-|
|idInventario|INT|Identificador único de inventario.|1 - 100|Não|Sim. Chave estrangeira.|-|

## Entidade: NPC
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idNpc|INT|Identificador único do NPC.|1 - 100|Não|Sim. Chave primária.|-|
|idSala|INT|Identificador único de Sala.|1 - 100|Não|Sim. Chave estrangeira.|-|
|nome|VARCHAR(20)|Nome do NPC.|a–z, A–Z|Não|Não|-|
|descricao|TEXT|Descrição textual do NPC.|a–z, A–Z|Não|Não|-|
|dialogo|TEXT|Dialogo textual do NPC.|a–z, A–Z|Não|Não|-|

## Entidade: NPC_QUEST
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idNpc|INT|Identificador único de NPC Quest.|1 - 100|Não|Sim. Chave Primária e Chave Estrangeira.|-|

## Entidade: NPC_VENDEDOR
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idNpc|INT|Identificador único de NPC Vendedor|1 - 100|Não|Sim. Chave Primária.|-|
|idEstoque|INT|Identificador único de Estoque|1 - 100|Não|Sim. Chave Estrangeira.|-|

## Entidade: NPC_COMBATENTE
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idNpc|INT|Identificador único de NPC Combatente.|1 - 100|Não|Sim. Chave Primária.|-|
|tamanho|VARCHAR(20)|Tamanho físico do NPC (ex: pequeno, médio, grande).|a–z, A–Z|Não|Não|-|
|raca|VARCHAR(20)|Raça ou tipo da criatura do NPC.|a–z, A–Z|Não|Não|-|
|descricao|TEXT|Descrição do NPC combatente.|a–z, A–Z|Não|Não|-|
|ataque|INT|Valor de ataque base do NPC.|1 - 1000|Não|Não|-|
|defesa|INT|Valor de defesa física do NPC.|1 - 1000|Não|Não|-|
|defesaMagica|INT|Valor de defesa mágica do NPC.|1 - 1000|Não|Não|-|
|nivel|INT|Nível geral do NPC.|1 - 100|Não|Não|-|
|precisao|INT|Capacidade de acerto em ataques.|1 - 100|Não|Não|-|
|esquiva|INT|Capacidade de evitar ataques.|1 - 100|Não|Não|-|

## Entidade: INSTANCIA_NPC_COMBATENTE
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idInstanciaNpcCombatente|INT|Identificador único da instância de NPC combatente.|1 - 100|Não|Sim. Chave primária.|-|
|idNpc|INT|Referência ao NPC base.|1 - 100|Não|Sim. Chave estrangeira.|-|
|vidaAtual|INT|Pontos de vida atuais da instância.|1 - 1000|Não|Não|-|
|status|VARCHAR(20)|Estado atual do NPC (ex: ativo, envenenado)e.|a–z, A–Z|Não|Não|-|
|agressivo|BOOLEAN|Indica se o NPC é agressivo (true/false).|true - false|Não|Não|-|

## Entidade: MISSAO
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idMissao|INT|Identificador único da missão.|1 - 100|Sim. Chave primária.|Não|-|
|idNpcQuest|INT|Referência ao NPC que fornece a missão.|1 - 100|Sim. Chave estrangeira.|Não|-|
|idItem|INT|Referência ao item necessário ou recompensado.|1 - 100|Sim. Chave estrangeira.|Não|-|
|requisitoLevel|INT|Nível mínimo do jogador para aceitar a missão.|1 - 100|Não|Não|-|
|xpBase|INT|Experiência geral recebida pela missão.|1 - 100|Não|Não|-|
|xpClasse|INT|Experiência atribuída à classe do personagem.|1 - 100|Não|Não|-|
|descricao|TEXT|Texto descritivo com detalhes da missão.|a–z, A–Z|Não|Não|-|
|objetivo|VARCHAR(300)|Objetivo principal da missão (ex: derrotar, entregar).|a–z, A–Z|Não|Não|-|
|dinheiroMissao|INT|Quantia de dinheiro recebida ao concluir a missão.|0 - 1000|Não|Não|-|

## Entidade: ESTOQUE
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idEstoque|INT|Identificador único do estoque.|1 - 100|Não|Sim. Chave primária|-|

# Atributos de Relacionamentos
## RELACIONAMENTO: possui_ESTOQUE_ITEM
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idEstoque|INT|Referência ao estoque.|1 - 100|Não|Sim. Chave primária e chave estrangeira.|-|
|idItem|INT|Referência ao Item.|1 - 100|Não|Sim. Chave primária e chave estrangeira.|-|

## RELACIONAMENTO: garante_MISSAO_INSTANCIA
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idMissao|INT|Referência a Missão.|1 - 100|Não|Sim. Chave primária e chave estrangeira.|-|
|idInstanciaItem|INT|Referência ao Item.|1 - 100|Não|Sim. Chave primária e chave estrangeira.|-|

## RELACIONAMENTO: pertence_PERSONAGEM_CLASSE
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idPersonagem|INT|Referência ao Personagem.|1 - 100|Não|Sim. Chave primária e chave estrangeira.|-|
|idClasse|INT|Referência à Classe.|1 - 100|Não|Sim. Chave primária e chave estrangeira.|-|

## RELACIONAMENTO: garante_MISSAO_INSTANCIA
|Variável|Tipo|Descrição|Valores permitidos|Permite valores nulos?|É chave?|Outras restrições|
|:---|:---|:---|:---|:---|:---|:---|
|idMissao|INT|Referência a Missão.|1 - 100|Não|Sim. Chave primária e chave estrangeira.|-|
|idDependencia|INT|Referência á Dependência.|1 - 100|Não|Sim. Chave primária e chave estrangeira.|-|

# Histórico de Versão
|  Versão  |     Data     | Descrição | Autor(es) | Revisor(es) |
| :------: | :----------: | :-----------: | :---------: | :---------: |
| `1.0` | 02/05/2025 | Criação de documento e primeira versão do DD | [Cauã Araujo](https://github.com/caua08) | [Ian Costa](https://github.com/iancostag) |
| `2.0` | 11/06/2025 | Segunda versão do DD | [Cauã Araujo](https://github.com/caua08) | [Amanda Cruz](https://github.com/mandicrz) |
| `3.0` | 14/06/2025 | Terceira versão do DD | [Cauã Araujo](https://github.com/caua08) | [Amanda Cruz](https://github.com/mandicrz) |
