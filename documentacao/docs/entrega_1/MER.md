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
- **INSTANCIA_ITEM**
- **NPC**
  - **NPC_COMBATENTE**
  - **INSTANCIA_NPC_COMBATENTE**
  - **NPC_QUEST**
  - **NPC_VENDEDOR**
  - **INSTANCIA_NPC_VENDEDOR**
- **MISSAO**
- **ESTOQUE**

## **Atributos**

- **JOGADOR**(<ins>`idJogador`</ins>, `usuario`, `email`, `senha`)

- **PERSONAGEM**(<ins>`idPersonagem`</ins>, `nome`, `idSala`,`mana`,`vida`, `vitalidade`, `inteligencia`, `agilidade`, `sorte`, `destreza`, `forca`, `ataque`, `ataqueMagico`, `precisao`, `esquiva`, `defesa`, `defesaMagica`, `critico`, `velocidade`, `nivel`, `dinheiro`)

- **CLASSE**(<ins>`idClasse`</ins>, `nomeClasse`, `descricao`)

- **HABILIDADE**(<ins>`idHabilidade`</ins>, `nomeHabilidade`, `descricao`, `custoMana`, `nivelRequerido`)

- **SALA**(<ins>`idSala`</ins>, `idCima`, `idBaixo`, `idEsquerda`, `idDireita`, `tipoSala`, `nomeSala`, `descricaoSala`)

- **INVENTARIO**(<ins>`idInventario`</ins>, {`idInstanciaItem`},`idPersonagem`, `capacidadeSlots`, `slotsUsados`)

- **ITEM**(<ins>`idItem`</ins>, `nomeItem`, `tipoItem`, `descricao`, `atributosBonus`)

  - **ARMA**(`velocidadeAtaque`, `tipoDano`, `danoBase`, `alcance`)
    - **CURTO_ALCANCE**(`tipoLamina`)
    - **LONGO_ALCANCE**(`tipoProjetil`, `quantidadeProjetil`)
    - **MAGICA**(`tipoMagia`, `efeitoMagico`)

  - **DROP**(`taxaDrop`, `idNpcCombatente`)

  - **ARMADURA**(`defesaBase`, `resistenciaElemental`)
    - **PEITORAL**(`resistenciaStatus`, `bonusVida`, `bonusDefesa`)
    - **CAPACETE**(`bonusMana`)
    - **BOTA**(`resistencia`, `bonusDefesa`, `bonusCritico`)
    - **ESCUDO**(`resistenciaStatus`)
    - **CAPA**(`resistenciaStatus`, `bonusVida`)
    - **ACESSORIO**(`bonusMana`, `bonusVida`, `bonusEsquiva`)

  - **CONSUMIVEL**
    - **COMIDA**(`bonusAtributo`, `bonusAtributoDuracao`)
    - **POCAO**(`recuperaVida`, `recuperaMana`)
    - **PERGAMINHO**(`tipoBuff`, `duracaoBuff`)

- **INSTANCIA_ITEM**(<ins>`idInstanciaItem`</ins>,<ins>`idItem`</ins>, `idSala`, `idInventario`)

- **NPC**(<ins>`idNpc`</ins>, `nome`, `descricao`, `tipoNpc`)

  - **NPC_COMBATENTE**(`tamanho`, `raca`, `descricao`, `ataque`, `defesa`, `defesaMagica`, `nivel`, `precisao`, `esquiva`)

  - **INSTANCIA_NPC_COMBATENTE**(<ins>`idInstanciaNpcCombatente`</ins>,<ins>`idNpcCombatente`</ins>, `vidaAtual`, `status`, `agressivo`)

  - **NPC_QUEST**(`dialogoFalha`, `dialogoSucesso`)

  - **NPC_VENDEDOR**(`tipoLoja`)

  - **INSTANCIA_NPC_VENDEDOR**(<ins>`idInstanciaNpcVendedor`</ins>, <ins>`idNpcVendedor`</ins>)

- **MISSAO**(<ins>`idMissao`</ins>, `idNpcQuest`, {`idInstanciaItem`}, {`idItem`}, `requisitoLevel`, `xpBase`, `xpClasse`, `descricao`, `objetivo`, `dinheiroMissao`)

- **ESTOQUE**(<ins>`idEstoque`</ins>, `idNpcVendedor`)

### Atributos de Relacionamentos 

- **possui**_ESTOQUE_ITEM(<ins>`idEstoque`</ins>, <ins>`idItem`</ins>, `custoItem`)

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
|  1.1   | 01/05/2025 |  Elaboração do MER   | [Amanda Cruz](https://github.com/mandicrz), [Felipe Motta](https://github.com/M0tt1nh4), [Ian Costa](https://github.com/iancostag) | [Kauã Richard ](https://github.com/rich4rd1) |
|  1.2   | 02/05/2025 |  Correção de atributos e entidades | [Amanda Cruz](https://github.com/mandicrz) | [Ian Costa](https://github.com/iancostag) |
