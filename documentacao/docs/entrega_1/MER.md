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

## **Histórico de Versão**

| Versão |    Data    |      Descrição       |                                                             Autor(es)                                                              |                Revisor(es)                |
| :----: | :--------: | :------------------: | :--------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------: |
|  1.0   | 29/05/2025 | Criação do Documento |                      [Amanda Cruz](https://github.com/mandicrz), [Felipe Motta](https://github.com/M0tt1nh4)                       | [Ian Costa](https://github.com/iancostag) |
|  1.1   | 01/05/2025 |  Elaboração do MER   | [Amanda Cruz](https://github.com/mandicrz), [Felipe Motta](https://github.com/M0tt1nh4), [Ian Costa](https://github.com/iancostag) |             [COLOCAR AQUI ]()             |
