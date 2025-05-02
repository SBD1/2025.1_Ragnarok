---

---

# 1. MER - Modelo Entidade-Relacionamento



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

  - Um **JOGADOR** cria um ou mais **PERSONAGEM**s (1,n), mas um **PERSONAGEM** é criado apenas por um **JOGADOR** (1,1)
  - Cardinalidade: (1:n)

- PERSONAGEM - **pertence** - CLASSE

  - Um **PERSONAGEM** pertence a uma única **CLASSE** (1,1), mas uma **CLASSE** é usada por nenhum ou mais **PERSONAGEM**s (0,n)
  - Cardinalidade: (n:1)

- PERSONAGEM - **possui** - INVENTARIO

  - Um **PERSONAGEM** possui apenas um **INVENTARIO** (1,1), e um **INVENTARIO** pertence a apenas um **PERSONAGEM** (1,1)
  - Cardinalidade: (1:1)

- PERSONAGEM - **aprende** - HABILIDADE

  - Um **PERSONAGEM** pode aprender nenhuma ou mais **HABILIDADE**s (0,n), e uma **HABILIDADE** pode ser aprendida por nenhum ou mais **PERSONAGEM**s (0,n)
  - Cardinalidade: (n:m)

- PERSONAGEM - **recebe** - MISSAO

  - Um **PERSONAGEM** pode receber nenhuma ou uma **MISSAO**s (0,1), e uma **MISSAO** pode ser recebida por nenhum ou mais **PERSONAGEM**s (0,n)
  - Cardinalidade: (n:1)

- PERSONAGEM - **interage** - NPC
  - Um **PERSONAGEM** interage com nennum ou apenas um **NPC** (0,1), mas um **NPC** interage com nenhum ou mais **PERSONAGEM**s (0,n)
  - Cardinalidade: (n:1)

- PERSONAGEM - **reside** - SALA

  - Um **PERSONAGEM** reside em apenas uma **SALA** (1,1), mas uma **SALA** pode residir nenhum ou mais **PERSONAGEM**s (0,n)
  - Cardinalidade: (n:1)

- CLASSE - **possui** - HABILIDADE

  - Uma **CLASSE** possui uma ou mais **HABILIDADE**s (1,n), e uma **HABILIDADE** pertence a uma ou mais **CLASSE**s (1,n)
  - Cardinalidade: (n:m)

- HABILIDADE - **depende** - HABILIDADE
  - Uma **HABILIDADE** depende de nennuma ou mais **HABILIDADE**s (0,n), e uma **HABILIDADE** é depedência de nenhuma ou mais **HABILIDADE**s (0,n)
  - Cardinalidade: (0:n)

- INVENTARIO - **armazena** - INSTANCIA_ITEM

  - Um **INVENTARIO** armazena nenhum ou mais **INSTANCIA_ITEM**s (0,n), mas uma **INSTANCIA_ITEM** é armazenada em nenhum ou apenas um **INVENTARIO** (0,1)
  - Cardinalidade: (1:n)

- SALA - **tem** - INSTANCIA_ITEM

  - Uma **SALA** tem nenhum ou mais **INSTANCIA_ITEM**s (0,n), mas uma **INSTANCIA_ITEM** está em nenhuma ou apenas uma **SALA** (0,1)
  - Cardinalidade: (1:n)

- SALA - **contem** - NPC

  - Uma **SALA** contém nenhum ou mais **NPC**s (0,n), mas um **NPC** está em apenas uma **SALA** (1,1)
  - Cardinalidade: (1:n)

- ITEM - **possui** - INSTANCIA_ITEM

  - Um **ITEM** possui nenhuma ou mais **INSTANCIA_ITEM**s (0,n), mas uma **INSTANCIA_ITEM** é possuída por um único **ITEM** (1,1)
  - Cardinalidade: (1:n)

- NPC_VENDEDOR - **possui** - INSTANCIA_NPC_VENDEDOR

  - Um **NPC_VENDEDOR** possui nenhuma ou mais **INSTANCIA_NPC_VENDEDOR**es (0,n), mas uma **INSTANCIA_NPC_VENDEDOR** é possuída por um único **NPC_VENDEDOR** (1,1)
  - Cardinalidade: (1:n)

- NPC_VENDEDOR - **possui** - ESTOQUE

  - Um **NPC_VENDEDOR** possui apenas um **ESTOQUE** (1,1), e um **ESTOQUE** é possuído por apenas um **NPC_VENDEDOR** (1,1)
  - Cardinalidade: (1:1)

- NPC_COMBATENTE - **possui** - INSTANCIA_NPC_COMBATENTE

  - Um **NPC_COMBATENTE** possui nenhuma ou mais **INSTANCIA_NPC_COMBATENTE**s (0,n), mas uma **INSTANCIA_NPC_COMBATENTE** é possuída por um único **NPC_COMBATENTE** (1,1)
  - Cardinalidade: (1:n)

- NPC_COMBATENTE - **garante** - DROP
  - Um **NPC_COMBATENTE** garante um ou mais **DROP**s (1,n), mas um **DROP** é garantido por apenas um **NPC_COMBATENTE** (1,1)
  - Cardinalidade: (1:n)

- NPC_QUEST - **designa** - MISSAO

  - Um **NPC_QUEST** designa uma ou mais **MISSAO**s (1,n), mas uma **MISSAO** é desginada por apenas um **NPC_QUEST** (1,1)
  - Cardinalidade: (1:n)

- MISSAO - **depende** - MISSAO

  - Uma **MISSAO** pode depender de nenhuma ou uma única **MISSAO** (0,1), e uma **MISSAO** é dependência de nenhuma ou uma **MISSAO** (0,1) 
  - Cardinalidade: (0:1)

- MISSAO - **garante** - INSTANCIA_ITEM

  - Uma **MISAO** garante um ou mais **INSTANCIA_ITEM**s (1,n), e uma **INSTANCIA_ITEM** é garantida por nenhuma ou mais **MISSAO**s (0,n)
  - Cardinalidade: (n:m)

- MISSAO - **requer** - ITEM
  
  - Uma **MISSAO** requer nenhum ou mais **ITEM** (0:n), e um **ITEM** é requerido por nenhuma ou mais **MISSAO**s (0:n)
  - Cardinalidade: (n:m)

- ESTOQUE - **possui** - ITEM
  - Um **ESTOQUE** possui um ou mais **ITEM**s (1,n), e um **ITEM** é possuído por nenhum ou mais **ESTOQUE**s (0,n)
  - Cardinalidade: (n:m)

## **Histórico de Versão**

| Versão |    Data    |      Descrição       |                                                             Autor(es)                                                              |                Revisor(es)                |
| :----: | :--------: | :------------------: | :--------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------: |
|  1.0   | 29/05/2025 | Criação do Documento |                      [Amanda Cruz](https://github.com/mandicrz), [Felipe Motta](https://github.com/M0tt1nh4)                       | [Ian Costa](https://github.com/iancostag) |
|  1.1   | 01/05/2025 |  Elaboração do MER   | [Amanda Cruz](https://github.com/mandicrz), [Felipe Motta](https://github.com/M0tt1nh4), [Ian Costa](https://github.com/iancostag) | [Kauã Richard ](https://github.com/rich4rd1) |
