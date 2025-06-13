---

---

# DDL - Data Definition Language

O DDL (Data Definition Language) é a parte da linguagem SQL usada para definir a estrutura do banco de dados. Com ele, são criadas, alteradas ou removidas tabelas, índices, esquemas e outros objetos. Diferente de comandos que manipulam os dados em si, o DDL cuida da forma como esses dados são organizados e armazenados no sistema.

## Tabelas 

### Tabela `JOGADOR`

A tabela `JOGADOR` refere-se ao usuário cadastrado no sistema.

```sql
CREATE TABLE JOGADOR (
    id_jogador SERIAL,
    usuario VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    senha VARCHAR(50) NOT NULL,

    CONSTRAINT JOGADOR_PK PRIMARY KEY (id_jogador),
    CONSTRAINT JOGADOR_email_UK UNIQUE KEY (email)
);

```

- Colunas: 
    - `id_jogador`: Identificador único do jogador (chave primária).
    - `usuario`: Nome de usuário do jogador.
    - `email`: Email do jogador, deve ser único.
    - `senha`: Senha do jogador.

### Tabela `CLASSE`

A tabela `CLASSE` refere-se a classe do personagem.

```sql
CREATE TABLE CLASSE (
    id_classe SERIAL,
    nome_classe VARCHAR(100) NOT NULL,
    descricao TEXT,

    CONSTRAINT CLASSE_PK PRIMARY KEY (id_classe)
);
```

- Colunas:
    - `id_classe`: Identificador único da classe (chave primária).
    - `nome_classe`: Nome da classe.
    - `descricao`: Descrição da classe.

### Tabela `SALA`

A tabela `SALA` refere-se as salas do sistema.

```sql
CREATE TABLE SALA (
    id_sala SERIAL,
    id_direita INT,
    id_esquerda INT,
    id_baixo INT,
    id_cima INT,
    nome_sala VARCHAR(30),
    descricao_sala TEXT NOT NULL,

    CONSTRAINT SALA_PK PRIMARY KEY (id_sala),
    CONSTRAINT direita_SALA_FK FOREIGN KEY (id_direita) REFERENCES SALA (id_sala),
    CONSTRAINT esquerda_SALA_FK FOREIGN KEY (id_esquerda) REFERENCES SALA (id_sala),
    CONSTRAINT baixo_SALA_FK FOREIGN KEY (id_baixo) REFERENCES SALA (id_sala),
    CONSTRAINT cima_SALA_FK FOREIGN KEY (id_cima) REFERENCES SALA (id_sala)
);
```

- Colunas:
    - `id_sala`: Identificador único da sala (chave primária).
    - `nome_sala`: Nome da sala.
    - `descricao_sala`: Descrição da sala.
    - `id_direita`: Identificador de uma sala na posição direita da atual (chave estrangeira referenciando `SALA`).
    - `id_esquerda`: Identificador de uma sala na posição esquerda da atual (chave estrangeira referenciando `SALA`).
    - `id_baixo`: Identificador de uma sala na posição abaixo da atual (chave estrangeira referenciando `SALA`).
    - `id_cima`: Identificador de uma sala na posição acima da atual (chave estrangeira referenciando `SALA`).

### Tabela `NPC`

A tabela `NPC` refere-se a um personagem não jogável do sistema.

```sql
CREATE TABLE NPC (
    id_npc SERIAL,
    id_sala INT,
    nome VARCHAR(20) NOT NULL,
    descricao TEXT,
    dialogo VARCHAR(1000),

    CONSTRAINT NPC_PK PRIMARY KEY (id_npc),
    CONSTRAINT NPC_SALA_FK FOREIGN KEY (id_sala) REFERENCES SALA (id_sala)
);
```

- Colunas:
    - `id_npc`: Identificador único do NPC (chave primária).
    - `id_sala`: Identificador da sala à qual o NPC pertence (chave estrangeira referenciando `SALA`).
    - `nome`: Nome do NPC.
    - `descricao`: Descrição do NPC.
    - `dialogo`: Diálogos do NPC.

### Tabela `NPC_QUEST`

A tabela `NPC_QUEST` refere-se ao personagem não jogável do sistema que tem a função de passar missões.

```sql
CREATE TABLE NPC_QUEST (
    id_npc INT,

    CONSTRAINT NPC_QUEST PRIMARY KEY (id_npc),
    CONSTRAINT NPC_QUEST_NPC_FK FOREIGN KEY (id_npc) REFERENCES NPC (id_npc)
);
```

- Colunas:
    - `id_npc`: Identificador único que refencia o pai (chave estrangeira referenciando `NPC`). 

### Tabela `NPC_COMBATENTE`

A tabela `NPC_COMBATENTE` refere-se ao personagem não jogável combatente do sistema.

```sql
CREATE TABLE NPC_COMBATENTE (
    id_npc_combatente INT,
    tamanho VARCHAR(15) NOT NULL,
    raca VARCHAR(15) NOT NULL,
    descricao TEXT NOT NULL,
    ataque INT NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT NOT NULL,
    nivel INT NOT NULL DEFAULT 1,
    precisao INT NOT NULL,
    esquiva INT NOT NULL,

    CONSTRAINT NPC_COMBATENTE_PK PRIMARY KEY (id_npc_combatente),
    CONSTRAINT NPC_COMBATENTE_NPC_FK FOREIGN KEY (id_npc_combatente) REFERENCES NPC (id_npc)
);
```

- Colunas:
    - `id_npc`: Identificador único que refencia o pai (chave estrangeira referenciando `NPC`). 

### Tabela `INSTANCIA_NPC_COMBATENTE`

```sql
CREATE TABLE INSTANCIA_NPC_COMBATENTE (
    id_instancia SERIAL,
    id_npc_combatente INT,
    vida_atual INT NOT NULL DEFAULT 100,
    status_npc VARCHAR(15) NOT NULL,
    agressivo BOOLEAN NOT NULL,

    CONSTRAINT INSTANCIA_NPC_COMBATENTE_PK PRIMARY KEY (id_instancia),
    CONSTRAINT INSTANCIA_NPC_COMBATENTE_NPC_COMBATENTE_FK FOREIGN KEY (id_npc_combatente) REFERENCES NPC_COMBATENTE (id_npc_combatente)
);
```

### Tabela `ITEM`

```sql
CREATE TABLE ITEM (
    id_item SERIAL,
    id_npc_combatente INT,
    nome VARCHAR(20) NOT NULL,
    tipo VARCHAR(15) NOT NULL,
    descricao TEXT NOT NULL,
    atributos_bonus INT,
    custo DECIMAL NOT NULL,

    CONSTRAINT ITEM_PK PRIMARY KEY (id_item),
    CONSTRAINT ITEM_NPC_COMBATENTE FOREIGN KEY (id_npc_combatente) REFERENCES NPC_COMBATENTE (id_npc_combatente),
    CONSTRAINT ITEM_nome_UK UNIQUE KEY (nome),
    CONSTRAINT ITEM_tipo_CK CHECK (tipo IN ('CONSUMIVEL', 'ARMADURA', 'ARMA'))
);
```

### Tabelas `ESTOQUE` e `NPC_VENDEDOR`

```sql
CREATE TABLE ESTOQUE (
    id_estoque SERIAL,

    CONSTRAINT ESTOQUE_PK PRIMARY KEY (id_estoque)
);

CREATE TABLE NPC_VENDEDOR (
    id_npc_vendedor SERIAL,
    id_estoque INT,

    CONSTRAINT NPC_VENDEDOR_PK PRIMARY KEY (id_npc_vendedor),
    CONSTRAINT NPC_VENDEDOR_ESTOQUE_FK FOREIGN KEY (id_estoque) REFERENCES ESTOQUE (id_estoque),
    CONSTRAINT NPC_VENDEDOR_NPC_FK FOREIGN KEY (id_npc_vendedor) REFERENCES NPC (id_npc)
);
```

### Tabela `VENDE_ESTOQUE_ITEM`

```sql
CREATE TABLE VENDE_ESTOQUE_ITEM (
    id_estoque INT,
    id_item INT,
    CONSTRAINT vende_ESTOQUE_ITEM_PK PRIMARY KEY (id_estoque, id_item),
    CONSTRAINT vende_ESTOQUE_ITEM_ESTOQUE_FK FOREIGN KEY (id_estoque) REFERENCES ESTOQUE (id_estoque),
    CONSTRAINT vende_ESTOQUE_ITEM_ITEM_FK FOREIGN KEY (id_item) REFERENCES ITEM (id_item)
);
```

### Tabela `MISSAO`

```sql
CREATE TABLE MISSAO (
    id_missao SERIAL,
    id_npc INT,
    requisito_level INT DEFAULT 1,
    xp_base INT NOT NULL,
    xp_classe INT NOT NULL,
    descricao TEXT,
    objetivo VARCHAR(100),
    dinheiro DECIMAL NOT NULL,

    CONSTRAINT MISSAO_PK PRIMARY KEY (id_missao),
    CONSTRAINT MISSAO_NPC_QUEST_FK FOREIGN KEY (id_npc) REFERENCES NPC_QUEST (id_npc)
);
```

### Tabela `PERSONAGEM`

```sql
CREATE TABLE PERSONAGEM (
    id_personagem SERIAL,
    id_jogador INT,
    id_sala INT,
    id_missao INT,
    nome VARCHAR(20) NOT NULL,
    mana INT DEFAULT 10,
    vida INT DEFAULT 300,
    vitalidade INT NOT NULL,
    inteligencia INT NOT NULL,
    agilidade INT NOT NULL,
    sorte INT NOT NULL,
    destreza INT NOT NULL,
    forca INT NOT NULL,
    ataque INT NOT NULL,
    ataque_magico INT NOT NULL,
    precisao INT NOT NULL,
    esquiva INT NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT NOT NULL,
    critico INT NOT NULL,
    velocidade INT NOT NULL,
    nivel INT DEFAULT 1,
    dinheiro INT DEFAULT 100,

    CONSTRAINT PERSONAGEM_PK PRIMARY KEY (id_personagem),
    CONSTRAINT PERSONAGEM_JOGADOR_FK FOREIGN KEY (id_jogador) REFERENCES JOGADOR (id_jogador),
    CONSTRAINT PERSONAGEM_SALA_FK FOREIGN KEY (id_sala) REFERENCES SALA (id_sala),
    CONSTRAINT PERSONAGEM_MISSAO_FK FOREIGN KEY (id_missao) REFERENCES MISSAO (id_missao)
);
```

### Tabela `INVENTARIO`

```sql
CREATE TABLE INVENTARIO (
    id_inventario SERIAL,
    id_personagem INT,
    
    CONSTRAINT INVENTARIO_PK PRIMARY KEY (id_inventario),
    CONSTRAINT INVENTARIO_PERSONAGEM_FK FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM (id_personagem)
);
```

### Tabela `INSTANCIA_ITEM`

```sql
CREATE TABLE INSTANCIA_ITEM (
    id_instancia_item SERIAL,
    id_item INT,
    id_sala INT,
    id_inventario INT,

    CONSTRAINT INSTANCIA_ITEM_PK PRIMARY KEY (id_instancia_item, id_item),
    CONSTRAINT INSTANCIA_ITEM_ITEM_FK FOREIGN KEY (id_item) REFERENCES ITEM (id_item),
    CONSTRAINT INSTANCIA_ITEM_SALA_FK FOREIGN KEY (id_sala) REFERENCES SALA (id_sala),
    CONSTRAINT INSTANCIA_ITEM_INVENTARIO_FK FOREIGN KEY (id_inventario) REFERENCES INVENTARIO (id_inventario)
);
```

### Tabela `pertence_PERSONAGEM_CLASSE`

```sql
CREATE TABLE pertence_PERSONAGEM_CLASSE (
    id_personagem INT NOT NULL,
    id_classe INT NOT NULL,

    CONSTRAINT pertence_PERSONAGEM_CLASSE_PK PRIMARY KEY (id_personagem, id_classe),
    CONSTRAINT pertence_PERSONAGEM_CLASSE_CLASSE_FK FOREIGN KEY (id_classe) REFERENCES CLASSE (id_classe),
    CONSTRAINT pertence_PERSONAGEM_CLASSE_PERSONAGEM_FK FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM (id_personagem)
);
```

### Tabela `HABILIDADE`

```sql
CREATE TABLE HABILIDADE (
    id_habilidade SERIAL,
    id_classe INT NOT NULL,
    nome_habilidade VARCHAR(100) NOT NULL,
    descricao TEXT,
    custo_mana INT,
    dano INT,
    nivel_requerido INT,

    CONSTRAINT HABILIDADE_PK PRIMARY KEY (id_habilidade),
    CONSTRAINT HABILIDADE_CLASSE_FK FOREIGN KEY (id_classe) REFERENCES CLASSE (id_classe)
);
```

### Tabela `CONSUMIVEL` e Subtipos

```sql
CREATE TABLE CONSUMIVEL (
    id_item INT,
    tipo_consumivel CHAR(10),

    CONSTRAINT CONSUMIVEL_PK PRIMARY KEY (id_item),
    CONSTRAINT CONSUMIVEL_ITEM_FK FOREIGN KEY (id_item) REFERENCES ITEM (id_item),
    CONSTRAINT tipo_consumivel_CK CHECK (tipo_consumivel IN ('POCAO', 'PERGAMINHO', 'COMIDA'))
);
```

### Tabela `POCAO`

```sql
CREATE TABLE POCAO (
    id_consumivel INT,
    tipo_bonus_atributo CHAR(20),
    bonus_atributo INT,
    bonus_atributo_duracao INT,
    nome_item VARCHAR(100),
    descricao TEXT,
    custo_iem INT,

    CONSTRAINT POCAO_PK PRIMARY KEY (id_consumivel),
    CONSTRAINT POCAO_CONSUMIVEL_FK FOREIGN KEY (id_consumivel) REFERENCES CONSUMIVEL (id_item)
);
```

### Tabela `PERGAMINHO`

```sql
CREATE TABLE PERGAMINHO (
    id_pergaminho INT,
    tipo_buff VARCHAR(50),
    duracao_buff INT,
    nome_item VARCHAR(100),
    descricao TEXT,
    custo_item INT,

    CONSTRAINT PERGAMINHO_PK PRIMARY KEY (id_pergaminho),
    CONSTRAINT PERGAMINHO_CONSUMIVEL_FK FOREIGN KEY (id_pergaminho) REFERENCES CONSUMIVEL (id_item)
);
```

### Tabela `COMIDA`

```sql
CREATE TABLE COMIDA (
    id_comida INT,
    tipo_bonus_atributo CHAR(20),
    bonus_atributo INT,
    bonus_atributo_duracao INT,
    nome_item VARCHAR(100),
    descricao TEXT,
    custo_item INT,

    CONSTRAINT COMIDA_PK PRIMARY KEY (id_comida),
    CONSTRAINT COMIDA_CONSUMIVEL_FK FOREIGN KEY (id_comida) REFERENCES CONSUMIVEL (id_item)
);
```

### Tabela `ARMADURA` e Subtipos

```sql
CREATE TABLE ARMADURA (
    id_item INT,
    tipo_armadura VARCHAR(20) NOT NULL,

    CONSTRAINT ARMADURA_PK (id_item),
    CONSTRAINT ARMADURA_ITEM_FK FOREIGN KEY (id_item) REFERENCES ITEM (id_item),
    CONSTRAINT tipo_armadura_CK CHECK (tipo_armadura IN ('CAPACETE', 'BOTA', 'ACESSORIO', 'CAPA', 'ESCUDO', 'PEITORAL'))
);
```

### Tabelas `CAPACETE`,  `BOTA`,  `ACESSORIO`,  `CAPA`,  `ESCUDO`,  `PEITORAL`

As estruturas acima seguem padrão semelhante da tabela `CAPACETE`:

```sql
CREATE TABLE CAPACETE (
    id_armadura INT,
    nome_item VARCHAR(20) NOT NULL,
    descricao TEXT NOT NULL,
    custo_item INT NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT,
    bonus_vida INT,

    CONSTRAINT CAPACETE_PK PRIMARY KEY (id_armadura),
    CONSTRAINT CAPACETE_ARMADURA_FK FOREIGN KEY (id_armadura) REFERENCES ARMADURA (id_item)
);
-- Estrutura semelhante para BOTA, ACESSORIO, CAPA, ESCUDO, PEITORAL
```

---

