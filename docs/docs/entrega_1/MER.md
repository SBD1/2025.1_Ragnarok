---

---


# MER - Modelo Entidade-Relacionamento

O **Modelo Entidade-Relacionamento** (MER) é uma técnica utilizada para representar de forma conceitual as entidades de um sistema e as relações entre elas. Ele ajuda a estruturar os dados e a entender como as informações se conectam. Abaixo, apresentamos o **MER** desenvolvido para o jogo *Ragnarok - MUD*.


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
  <!-- retirada de drop -->
  - **ARMA**
    - **LONGO_ALCANCE**
    - **MAGICA**
    <!-- retirada de curto_alcance -->
  - **CONSUMIVEL**
    - **PERGAMINHO**
    - **COMIDA**
    - **POCAO** 
    <!-- retirada de buffs -->
- **INSTANCIA_ITEM**
- **NPC**
  - **NPC_COMBATENTE**
  - **INSTANCIA_NPC_COMBATENTE**
  - **NPC_VENDEDOR**
  <!-- retirada de instancia_npc_vendedor -->
- **MISSAO**
- **ESTOQUE**

## **Atributos**

- **JOGADOR**(<ins>`idJogador`</ins>, `usuario`, `email`, `senha`)

- **PERSONAGEM**(<ins>`idPersonagem`</ins>, ,`idJogador`, `idMissao`,`idSala`,`nome`,`mana`,`vida`, `vitalidade`, `inteligencia`, `agilidade`, `sorte`, `destreza`, `forca`, `ataque`, `ataqueMagico`, `precisao`, `esquiva`, `defesa`, `defesaMagica`, `critico`, `velocidade`, `nivel`, `dinheiro`)
<!-- remoção da chave multivalorada idHabilidade, adição de idJogador -->
- **CLASSE**(<ins>`idClasse`</ins>, `nomeClasse`, `descricao`)

- **HABILIDADE**(<ins>`idHabilidade`</ins>, `idClasse`, `nomeHabilidade`, `descricao`, `custoMana`, `nivelRequerido`)

- **SALA**(<ins>`idSala`</ins>,`idCima`, `idBaixo`, `idEsquerda`, `idDireita`, `nomeSala`, `descricaoSala`)
<!-- remoção de chaves multi. idInstanciaItem e idNpc e tipoSala -->

- **INVENTARIO**(<ins>`idInventario`</ins>,`idPersonagem`, `capacidadeSlots`, `slotsUsados`)
<!-- remoção da chave multivalorada idInstanciaItem -->

- **ITEM**(<ins>`idItem`</ins>,  `idNpcCombatente`, `nomeItem`, `tipoItem`, `descricao`, `custoItem`)
<!-- removi taxa drop e adicionei a fk idNpcCombatente-->

  - **ARMA**(<ins>`idItem`</ins>, `danoBase`,`bonusDano`, `categoriaArma`)
    - **LONGO_ALCANCE**(<ins>`idArma`</ins>, `tipoProjetil`, `quantidadeProjetil`)
    - **MAGICA**(<ins>`idArma`</ins>, `tipoMagia`, `efeitoMagico`) 
    
  <!-- remoção da especialização curto_alcance e adição de categoriaArma em Arma -->

  <!-- remoção da especialização drop -->

  - **ARMADURA**(<ins>`idItem`</ins>,`tipoArmadura`, `defesa`, `defesaMagica`)
    - **PEITORAL**(<ins>`idArmadura`</ins>, `bonusVida`, `bonusDefesa`)
    - **CAPACETE**(<ins>`idArmadura`</ins>, `bonusVida`)
    - **BOTA**(<ins>`idArmadura`</ins>, `bonusVelocidade`)
    - **ESCUDO**(<ins>`idArmadura`</ins>, `bonusVida`, `bonusDefesa`)
    - **CAPA**(<ins>`idArmadura`</ins>, `bonusVida`, `bonusCritico`)
    - **ACESSORIO**(<ins>`idArmadura`</ins>, `bonusVida`, `bonusEsquiva`, `bonusMana`)
  <!-- remoção de atributos e fk -->

  - **CONSUMIVEL**(<ins>`idItem`</ins>, `tipoConsumivel`)
    - **COMIDA**(<ins>`idConsumivel`</ins>, `tipoBonusAtributo`, `bonusAtributo`, `bonusAtributoDuracao`)
    - **POCAO**(<ins>`idConsumivel`</ins>, `tipoBonusAtributo`, `recuperaVida`, `recuperaMana`)
    - **PERGAMINHO**(<ins>`idConsumivel`</ins>, `tipoBuff`, `duracaoBuff`)
  <!-- remoção de fk e adição de atributos faltantes -->
  <!-- troquei alguns nomes pq ta confuso ok! -->

- **INSTANCIA_ITEM**(<ins>`idInstanciaItem`</ins>, <ins>`idItem`</ins>, `idSala`, `idInventario`)

- **NPC**(<ins>`idNpc`</ins>, `idSala`, `nome`, `descricao`, `dialogo`)
<!-- adicionei dialogo em Npc e retirei de Npc_Quest -->
 
  - **NPC_VENDEDOR**(<ins>`idNpc`</ins>, `idEstoque`)
  <!-- remoção de Instancia_Npc_Vendedor e tipoLoja -->

  - **NPC_COMBATENTE**(<ins>`idNPC`</ins>, `tamanho`, `raca`, `descricao`, `ataque`, `defesa`, `defesaMagica`, `nivel`, `precisao`, `esquiva`)

  - **INSTANCIA_NPC_COMBATENTE**(<ins>`idInstanciaNpcCombatente`</ins>, <ins>`idNpc`</ins>, `vidaAtual`, `status`, `agressivo`)

- **MISSAO**(<ins>`idMissao`</ins>, `idNpc`, `idItem`, `requisitoLevel`, `xpBase`, `xpClasse`, `descricao`, `objetivo`, `dinheiroMissao`)

- **ESTOQUE**(<ins>`idEstoque`</ins>)

### Atributos de Relacionamentos 

- **vende**_ESTOQUE_ITEM(<ins>`idEstoque`</ins>, <ins>`idItem`</ins>)
- **garante**_MISSAO_INSTANCIA_ITEM(<ins>`idMissao`</ins>, <ins>`idInstanciaItem`</ins>)
- **pertence**_PERSONAGEM_CLASSE(<ins>`idPersonagem`</ins>, <ins>`idClasse`</ins>)
- **depende**_MISSAO(<ins>`idMissao`</ins>, <ins>`idDependencia`</ins>)

## **Relacionamentos**

- JOGADOR - **cria** - PERSONAGEM

  - Um **JOGADOR** cria um ou mais **PERSONAGEM**s (1,n), mas um **PERSONAGEM** é criado apenas por um **JOGADOR** (1,1)
  - Cardinalidade: (1:n)

- PERSONAGEM - **pertence** - CLASSE

  - Um **PERSONAGEM** pertence a uma ou mais **CLASSE**s (1,n), mas uma **CLASSE** pertence a nenhum ou mais **PERSONAGEM**s (0,n)
  - Cardinalidade: (n:m)

- PERSONAGEM - **possui** - INVENTARIO

  - Um **PERSONAGEM** possui apenas um **INVENTARIO** (1,1), e um **INVENTARIO** é possuído por apenas um **PERSONAGEM** (1,1)
  - Cardinalidade: (1:1)

- PERSONAGEM - **recebe** - MISSAO

  - Um **PERSONAGEM** recebe nenhuma ou uma **MISSAO**s (0,1), e uma **MISSAO** é recebida por nenhum ou mais **PERSONAGEM**s (0,n)
  - Cardinalidade: (n:1)

- PERSONAGEM - **interage** - NPC
  - Um **PERSONAGEM** interage com nenhum ou mais **NPC** (0,n), mas um **NPC** interage com nenhum ou mais **PERSONAGEM**s (0,n)
  - Cardinalidade: (n:m)

- PERSONAGEM - **reside** - SALA

  - Um **PERSONAGEM** reside em apenas uma **SALA** (1,1), mas em uma **SALA** reside nenhum ou mais **PERSONAGEM**s (0,n)
  - Cardinalidade: (n:1)

- CLASSE - **possui** - HABILIDADE

  - Uma **CLASSE** possui nenhuma ou mais **HABILIDADE**s (0,n), e uma **HABILIDADE** é possuída por uma única **CLASSE**s (1,1)
  - Cardinalidade: (1:n)

- INVENTARIO - **armazena** - INSTANCIA_ITEM

  - Um **INVENTARIO** armazena nenhum ou mais **INSTANCIA_ITEM**s (0,n), mas uma **INSTANCIA_ITEM** é armazenada em nenhum ou apenas um **INVENTARIO** (0,1)
  - Cardinalidade: (1:n)

- SALA - **tem** - INSTANCIA_ITEM

  - Uma **SALA** tem nenhum ou mais **INSTANCIA_ITEM**s (0,n), mas uma **INSTANCIA_ITEM** está em nenhuma ou apenas uma **SALA** (0,1)
  - Cardinalidade: (1:n)

- SALA - **contem** - NPC

  - Uma **SALA** contém nenhum ou mais **NPC**s (0,n), mas um **NPC** está contido em apenas uma **SALA** (1,1)
  - Cardinalidade: (1:n)

- ITEM - **possui** - INSTANCIA_ITEM

  - Um **ITEM** possui nenhuma ou mais **INSTANCIA_ITEM**s (0,n), mas uma **INSTANCIA_ITEM** é possuída por um único **ITEM** (1,1)
  - Cardinalidade: (1:n)

<!-- removido cardinalidade de NPC_VENDEDOR e sua instância pois não existe mais -->

- NPC_VENDEDOR - **possui** - ESTOQUE

  - Um **NPC_VENDEDOR** possui apenas um **ESTOQUE** (1,1), e um **ESTOQUE** é possuído por nenhum ou mais **NPC_VENDEDOR** (0,n)
  - Cardinalidade: (1:n)

- NPC_COMBATENTE - **possui** - INSTANCIA_NPC_COMBATENTE

  - Um **NPC_COMBATENTE** possui nenhuma ou mais **INSTANCIA_NPC_COMBATENTE**s (0,n), mas uma **INSTANCIA_NPC_COMBATENTE** é possuída por um único **NPC_COMBATENTE** (1,1)
  - Cardinalidade: (1:n)

- NPC_COMBATENTE - **garante** - ITEM

  - Um **NPC_COMBATENTE** garante um ou mais **ITEM** (1,n), mas um **ITEM** é garantido por nenhum ou um **NPC_COMBATENTE**s (0,1)
  - Cardinalidade: (1:n)
  <!-- adição do relacionamento NPC_COMBATENTE e ITEM -->

<!-- removido DROP -->

- NPC - **designa** - MISSAO

  - Um **NPC** designa uma ou mais **MISSAO**s (1,n), mas uma **MISSAO** é desginada por apenas um **NPC** (1,1)
  - Cardinalidade: (1:n)

- MISSAO - **depende** - MISSAO

  - Uma **MISSAO** pode depender de nenhuma ou uma única **MISSAO** (0,1), e uma **MISSAO** é dependência de nenhuma ou uma **MISSAO** (0,1) 
  - Cardinalidade: (0:1)

- MISSAO - **garante** - INSTANCIA_ITEM

  - Uma **MISSAO** garante um ou mais **INSTANCIA_ITEM**s (1,n), e uma **INSTANCIA_ITEM** é garantida por nenhuma ou mais **MISSAO**s (0,n)
  - Cardinalidade: (n:m)

- MISSAO - **requer** - ITEM
  
  - Uma **MISSAO** requer nenhum ou mais **ITEM**s (0:n), e um **ITEM** é requerido por nenhuma ou mais **MISSAO**s (0:n)
  - Cardinalidade: (n:m)

- ESTOQUE - **possui** - ITEM
  - Um **ESTOQUE** possui um ou mais **ITEM**s (1,n), e um **ITEM** é possuído por nenhum ou mais **ESTOQUE**s (0,n)
  - Cardinalidade: (n:m)

## Histórico de Versão

| Versão |    Data    |      Descrição       |                                                             Autor(es)                                                              |                Revisor(es)                |
| :----: | :--------: | :------------------: | :--------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------: |
|  `1.0`   | 29/05/2025 | Criação do Documento |                      [Amanda Cruz](https://github.com/mandicrz), [Felipe Motta](https://github.com/M0tt1nh4)                       | [Ian Costa](https://github.com/iancostag) |
|  `1.1`   | 01/05/2025 |  Elaboração do MER   | [Amanda Cruz](https://github.com/mandicrz), [Felipe Motta](https://github.com/M0tt1nh4), [Ian Costa](https://github.com/iancostag) | [Kauã Richard ](https://github.com/rich4rd1) |
|  `1.2`   | 02/05/2025 |  Correção de atributos e entidades | [Amanda Cruz](https://github.com/mandicrz), [Felipe Motta](https://github.com/M0tt1nh4) | [Ian Costa](https://github.com/iancostag) |
|  `2.0`   | 10/06/2025 |  Segunda versão do MER | [Amanda Cruz](https://github.com/mandicrz), [Felipe Motta](https://github.com/M0tt1nh4), [Kauã Richard ](https://github.com/rich4rd1) | [Ian Costa](https://github.com/iancostag) |
