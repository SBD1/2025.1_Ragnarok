---
sidebar_position: 2
---

# **MER** - Modelo Entidade-Relacionamento

O Modelo Entidade-Relacionamento (MER) é uma ferramenta gráfica usada para representar a estrutura de um banco de dados. Ele descreve as entidades do sistema, seus atributos e os relacionamentos entre elas. O MER ajuda a planejar e organizar dados de forma clara, facilitando a criação e gestão de bancos de dados eficientes e bem estruturados.

## **Entidades**

- **JOGADOR**
- **PERSONAGEM**
- **CLASSE**
- **HABILIDADE**
- **SALA**
- **INVENTARIO**
- **ITEM**
  - **ARMADURA**
    - **PEITORAL**
    - **CAPACETE**
    - **BOTA**
    - **ESCUDO**
    - **CAPA**
    - **ACESSORIO**
  - **DROP**
    - **COMUM**
    - **ITEM_PRODUCAO**
  - **ARMA**
    - **CURTO_ALCANCE**
    - **MEDIO_ALCANCE**
    - **MAGICA**
  - **CONSUMIVEL**
    - **PERGAMINHO**
    - **COMIDA**
    - **POCAO**
    - **BUFFS**
    - **STATUS_CURE**
- **INSTANCIA_ITEM**
- **NPC**
  - **NPC_COMBATENTE**
  - **INSTANCIA_NPC_COMBATENTE**
  - **NPC_QUEST**
  - **INSTANCIA_NPC_COMBATENTE**
  - **NPC_VENDEDOR**
  - **INSTANCIA_NPC_VENDEDOR**
- **MISSAO**
- **ESTOQUE**

## **Atributos**

- **JOGADOR**(<ins>`idJogador`</ins>, `usuario`, `email`, `senha`)

- **PERSONAGEM**(<ins>`idPersonagem`</ins>, `nome`, `idSala`,`mana`,`vida`, `vitalidade`, `inteligencia`, `agilidade`, `sorte`, `destreza`, `forca`, `ataque`, `ataqueMagico`, `precisao`, `esquiva`, `defesa`, `defesaMagica`, `critico`, `velocidade`)

- **CLASSE**(<ins>`idClasse`</ins>, `nomeClasse`, `descricao`)

- **HABILIDADE**(<ins>`idHabilidade`</ins>, `nomeHabilidade`, `descricao`, `custoMana`, `nivelRequerido`)

- **SALA**(<ins>`idSala`</ins>, `idCima`, `idBaixo`, `idEsquerda`, `idDireita`, `tipoSala`, `nomeSala`, `descricaoSala`)

- **INVENTARIO**(<ins>`idInventario`</ins>, `idPersonagem`, `capacidadeSlots`, `slotsUsados`)

- **ITEM**(<ins>`idItem`</ins>, `nomeItem`, `tipoItem`, `descricao`, `atributosBonus`)

  - **ARMADURA**()
    - **PEITORAL**()
    - **CAPACETE**()
    - **BOTA**()
    - **ESCUDO**()
    - **CAPA**()
    - **ACESSORIO**()
  - **DROP**()

    - **COMUM**()
    - **ITEM_PRODUCAO**()

  - **ARMA**()
    - **CURTO_ALCANCE**()
    - **MEDIO_ALCANCE**()
    - **MAGICA**()
  - **CONSUMIVEL**()
    - **PERGAMINHO**()
    - **COMIDA**()
    - **POCAO**()
    - **BUFFS**()
    - **STATUS_CURE**()

- **INSTANCIA_ITEM**(<ins>`idInstanciaItem`</ins>,<ins>`idItem`</ins>,`idItem`, `idSala`, `idInventario`)

- **NPC**(<ins>`idNpc`</ins>, `nome`, `descricao`, `tipoNpc`)

  - **NPC_COMBATENTE**(<ins>`idNpcCombatente`</ins>, `tamanho`, `raca`, `descricao`, `ataque`, `defesa`, `defesaMagica`, `nivel`, `precisao`, `esquiva`)

  - **INSTANCIA_NPC_COMBATENTE**(<ins>`idInstanciaNpcCombatente`</ins>,<ins>`idNpcCombatente`</ins>, `vidaAtual`, `status`, `agressivo`)

  - **NPC_QUEST**(<ins>`idNpcQuest`</ins>)

  - **INSTANCIA_NPC_QUEST**(<ins>`idInstanciaNpcQuest`</ins>, <ins>`idNpcQuest`</ins>)

  - **NPC_VENDEDOR**(<ins>`idNpcVendedor`</ins>)

  - **INSTANCIA_NPC_VENDEDOR**(<ins>`idInstanciaNpcVendedor`</ins>, <ins>`idNpcVendedor`</ins>)

- **MISSAO**(<ins>`idMissao`</ins>, `idNpcQuest`, `requisitoLevel`, `xpBase`, `xpClasse`, `descricao`, `requisitoMissao`, `objetivo`)

- **ESTOQUE**(<ins>`idEstoque`</ins>, `idInstNpcVendedor`)

## **Relacionamentos**

- JOGADOR - **cria** - PERSONAGEM

  - Um **JOGADOR** cria vários **PERSONAGEM**s, mas um **PERSONAGEM** é criado apenas por um **JOGADOR**
  - Cardinalidade: (1:n)

- PERSONAGEM - **pertence** - CLASSE

  - Um **PERSONAGEM** pertence a uma única **CLASSE**, mas uma **CLASSE** é usada por vários **PERSONAGEM**s
  - Cardinalidade: (n:1)

- PERSONAGEM - **possui** - INVENTARIO

  - Um **PERSONAGEM** possui apenas um **INVENTARIO**, e um **INVENTARIO** pertence a apenas um **PERSONAGEM**
  - Cardinalidade: (1:1)

- PERSONAGEM - **aprende** - HABILIDADE

  - Um **PERSONAGEM** pode aprender várias **HABILIDADE**s, e uma **HABILIDADE** pode ser aprendida por vários **PERSONAGEM**s
  - Cardinalidade: (n:m)

- PERSONAGEM - **recebe** - MISSAO

  - Um **PERSONAGEM** pode receber nenhuma ou uma **MISSAO**s, e uma **MISSAO** pode ser recebida por um ou mais **PERSONAGEM**s
  - Cardinalidade: (n:1)

- CLASSE - **possui** - HABILIDADE

  - Uma **CLASSE** possui várias **HABILIDADE**, e uma **HABILIDADE** pertence a várias **CLASSE**s
  - Cardinalidade: (n:m)

- INVENTARIO - **armazena** - INSTANCIA_ITEM

  - Um **INVENTARIO** armazena várias **INSTANCIAS_ITEM**s, mas uma **INSTANCIA_ITEM** é armazenada em apenas um **INVENTARIO**
  - Cardinalidade: (1:n)

- SALA - **contem** - PERSONAGEM

  - Uma **SALA** contém vários **PERSONAGEM**s, mas um **PERSONAGEM** está em apenas uma **SALA** por vez
  - Cardinalidade: (1:n)

- SALA - **tem** - INSTANCIA_ITEM

  - Uma **SALA** tem vários **INSTANCIA_ITEM**s, mas uma **INSTANCIA_ITEM** está em apenas uma **SALA**
  - Cardinalidade: (1:n)

- SALA - **contem** - NPC

  - Uma **SALA** contém vários **NPC**s, mas um **NPC** está em apenas uma **SALA** por vez
  - Cardinalidade: (1:n)

- ITEM - **possui** - INSTANCIA_ITEM

  - Um **ITEM** pode possuir várias **INSTANCIA_ITEM**s, mas uma _INSTANCIA_ITEM_ é possuída por um único **ITEM**
  - Cardinalidade: (1:n)

- NPC_VENDEDOR - **possui** - INSTANCIA_NPC_VENDEDOR

  - Um **NPC_VENDEDOR** possui várias **INSTANCIA_NPC_VENDEDOR**es, mas uma **INSTANCIA_NPC_VENDEDOR** é possuída por um único **NPC_VENDEDOR**
  - Cardinalidade: (1:n)

- NPC_VENDEDOR - **possui** - ESTOQUE

  - Um **NPC_VENDEDOR** possui apenas um **ESTOQUE**, e um **ESTOQUE** é possuído por apenas um **NPC_VENDEDOR**
  - Cardinalidade: (1:1)

- NPC_COMBATENTE - **possui** - INSTANCIA_NPC_COMBATENTE

  - Um **NPC_COMBATENTE** possui várias **INSTANCIA_NPC_COMBATENTE**s, mas uma **INSTANCIA_NPC_COMBATENTE** é possuída por um único **NPC_COMBATENTE**
  - Cardinalidade: (1:n)

- NPC_QUEST - **designa** - MISSAO

  - Um **NPC_QUEST** designa várias **MISSAO**s, mas uma **MISSAO** é desginada por apenas um **NPC_QUEST**
  - Cardinalidade: (1:n)

- MISSAO - **depende** - MISSAO

  - Uma **MISSAO** pode depender de nenhuma ou uma única **MISSAO**
  - Cardinalidade: (0:1)

- MISSAO - **garante** - INSTANCIA_ITEM

  - Uma **MISAO** garante um ou mais **INSTANCIA_ITEM**s, e uma **INSTANCIA_ITEM** é garantida por nenhuma ou mais **MISSAO**s
  - Cardinalidade: (n:m)

- ESTOQUE - **possui** - ITEM
  - Um **ESTOQUE** pode possuir vários **ITEM**s, e um **ITEM** pode ser possuído por vários **ESTOQUE**s
  - Cardinalidade: (n:m)

## **Histórico de Versão**

| Versão |    Data    |      Descrição       |                                                             Autor(es)                                                              |                Revisor(es)                |
| :----: | :--------: | :------------------: | :--------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------: |
|  1.0   | 29/05/2025 | Criação do Documento |                      [Amanda Cruz](https://github.com/mandicrz), [Felipe Motta](https://github.com/M0tt1nh4)                       | [Ian Costa](https://github.com/iancostag) |
|  1.1   | 01/05/2025 |  Elaboração do MER   | [Amanda Cruz](https://github.com/mandicrz), [Felipe Motta](https://github.com/M0tt1nh4), [Ian Costa](https://github.com/iancostag) |             [COLOCAR AQUI ]()             |
