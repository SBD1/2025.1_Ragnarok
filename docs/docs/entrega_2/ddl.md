---

---

# DDL - Data Definition Language

O DDL (Data Definition Language) é a parte da linguagem SQL usada para definir a estrutura do banco de dados. Com ele, são criadas, alteradas ou removidas tabelas, índices, esquemas e outros objetos. Diferente de comandos que manipulam os dados em si, o DDL cuida da forma como esses dados são organizados e armazenados no sistema.

## Tabelas 

### Tabela `JOGADOR`

A tabela `JOGADOR` refere-se ao usuário cadastrado no sistema.

```sql
CREATE TABLE JOGADOR (
    id_jogador SERIAL PRIMARY KEY,
    usuario VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    senha VARCHAR(50) NOT NULL,

    CONSTRAINT jogador_uk UNIQUE (email)
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
    id_classe SERIAL PRIMARY KEY,
    nome_classe VARCHAR(100) NOT NULL,
    descricao TEXT
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
    id_sala SERIAL PRIMARY KEY,
    id_direita INT,
    id_esquerda INT,
    id_baixo INT,
    id_cima INT,
    nome_sala VARCHAR(30),
    descricao_sala TEXT NOT NULL,
    FOREIGN KEY (id_direita) REFERENCES SALA(id_sala),
    FOREIGN KEY (id_esquerda) REFERENCES SALA(id_sala),
    FOREIGN KEY (id_baixo) REFERENCES SALA(id_sala),
    FOREIGN KEY (id_cima) REFERENCES SALA(id_sala)
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
    id_npc SERIAL PRIMARY KEY,
    id_sala INT,
    nome VARCHAR(20) NOT NULL,
    descricao TEXT,
    dialogo VARCHAR(1000),
    FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
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
    id_npc INT PRIMARY KEY,
    FOREIGN KEY (id_npc) REFERENCES NPC(id_npc)
);
```

- Colunas:
    - `id_npc`: Identificador único que refencia o pai (chave estrangeira referenciando `NPC`). 

### Tabela `NPC_COMBATENTE`

A tabela `NPC_COMBATENTE` refere-se ao personagem não jogável combatente do sistema.

```sql
CREATE TABLE NPC_COMBATENTE (
    id_npc_combatente INT PRIMARY KEY,
    tamanho VARCHAR(15) NOT NULL,
    raca VARCHAR(15) NOT NULL,
    descricao TEXT NOT NULL,
    ataque INT NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT NOT NULL,
    nivel INT NOT NULL DEFAULT 1,
    precisao INT NOT NULL,
    esquiva INT NOT NULL,
    FOREIGN KEY (id_npc_combatente) REFERENCES NPC(id_npc)
);
```

- Colunas:
    - `id_npc`: Identificador único que refencia o pai (chave estrangeira referenciando `NPC`). 

### Tabela `INSTANCIA_NPC_COMBATENTE`

```sql
CREATE TABLE INSTANCIA_NPC_COMBATENTE (
    id_instancia SERIAL PRIMARY KEY,
    id_npc_combatente INT,
    vida_atual INT NOT NULL DEFAULT 100,
    status_npc VARCHAR(15) NOT NULL,
    agressivo BOOLEAN NOT NULL,
    FOREIGN KEY (id_npc_combatente) REFERENCES NPC_COMBATENTE(id_npc_combatente)
);
```

### Tabela `ITEM`

```sql
CREATE TABLE ITEM (
    id_item SERIAL PRIMARY KEY,
    id_npc_combatente INT,
    nome VARCHAR(20) NOT NULL,
    tipo VARCHAR(15) NOT NULL,
    descricao TEXT NOT NULL,
    atributos_bonus INT,
    custo DECIMAL NOT NULL,
    FOREIGN KEY (id_npc_combatente) REFERENCES NPC_COMBATENTE(id_npc_combatente),
    CONSTRAINT item_nome_uk UNIQUE (nome),
    CONSTRAINT tipo_ck CHECK (tipo IN ('CONSUMIVEL', 'ARMADURA', 'ARMA'))
);
```

### Tabelas `ESTOQUE` e `NPC_VENDEDOR`

```sql
CREATE TABLE ESTOQUE (
    id_estoque SERIAL PRIMARY KEY
);

CREATE TABLE NPC_VENDEDOR (
    id_npc_vendedor SERIAL PRIMARY KEY,
    id_estoque INT,
    FOREIGN KEY (id_estoque) REFERENCES ESTOQUE(id_estoque),
    FOREIGN KEY (id_npc_vendedor) REFERENCES NPC(id_npc)
);
```

### Tabela `VENDE_ESTOQUE_ITEM`

```sql
CREATE TABLE VENDE_ESTOQUE_ITEM (
    id_estoque INT,
    id_item INT,
    PRIMARY KEY (id_estoque, id_item),
    FOREIGN KEY (id_estoque) REFERENCES ESTOQUE(id_estoque),
    FOREIGN KEY (id_item) REFERENCES ITEM(id_item)
);
```

### Tabela `MISSAO`

```sql
CREATE TABLE MISSAO (
    id_missao SERIAL PRIMARY KEY,
    id_npc INT,
    requisito_level INT DEFAULT 1,
    xp_base INT NOT NULL,
    xp_classe INT NOT NULL,
    descricao TEXT,
    objetivo VARCHAR(100),
    dinheiro DECIMAL NOT NULL,
    FOREIGN KEY (id_npc) REFERENCES NPC(id_npc)
);
```

### Tabela `PERSONAGEM`

```sql
CREATE TABLE PERSONAGEM (
    id_personagem SERIAL PRIMARY KEY,
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
    FOREIGN KEY (id_jogador) REFERENCES JOGADOR(id_jogador),
    FOREIGN KEY (id_sala) REFERENCES SALA(id_sala),
    FOREIGN KEY (id_missao) REFERENCES MISSAO(id_missao)
);
```

### Tabela `INVENTARIO`

```sql
CREATE TABLE INVENTARIO(
    id_inventario SERIAL PRIMARY KEY,
    id_personagem INT,
    FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM(id_personagem)
);
```

### Tabela `INSTANCIA_ITEM`

```sql
CREATE TABLE INSTANCIA_ITEM (
    id_instancia_item SERIAL,
    id_item INT,
    id_sala INT,
    id_inventario INT,
    PRIMARY KEY (id_instancia_item, id_item),
    FOREIGN KEY (id_item) REFERENCES ITEM(id_item),
    FOREIGN KEY (id_sala) REFERENCES SALA(id_sala),
    FOREIGN KEY (id_inventario) REFERENCES INVENTARIO(id_inventario)
);
```

### Tabela `PERTENCE_PERSONAGEM_CLASSE`

```sql
CREATE TABLE PERTENCE_PERSONAGEM_CLASSE (
    id_personagem INT NOT NULL,
    id_classe INT NOT NULL,
    PRIMARY KEY (id_personagem, id_classe),
    FOREIGN KEY (id_classe) REFERENCES CLASSE(id_classe),
    FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM(id_personagem)
);
```

### Tabela `HABILIDADE`

```sql
CREATE TABLE HABILIDADE (
    id_habilidade SERIAL PRIMARY KEY,
    id_classe INT NOT NULL,
    nome_habilidade VARCHAR(100) NOT NULL,
    descricao TEXT,
    custo_mana INT,
    dano INT,
    nivel_requerido INT,
    FOREIGN KEY (id_classe) REFERENCES CLASSE(id_classe)
);
```

### Tabela `CONSUMIVEL` e Subtipos

```sql
CREATE TABLE CONSUMIVEL(
    id_item INT PRIMARY KEY,
    tipo_consumivel CHAR(10),
    FOREIGN KEY (id_item) REFERENCES ITEM(id_item),
    CONSTRAINT tipo_consumivel_ck CHECK (tipo_consumivel IN ('POCAO', 'PERGAMINHO', 'COMIDA'))
);
```

### Tabela `POCAO`

```sql
CREATE TABLE POCAO(
    id_consumivel INT PRIMARY KEY,
    tipo_bonus_atributo CHAR(20),
    bonus_atributo INT,
    bonus_atributo_duracao INT,
    nome_item VARCHAR(100),
    descricao TEXT,
    custo_iem INT,
    FOREIGN KEY (id_consumivel) REFERENCES CONSUMIVEL(id_item)
);
```

### Tabela `PERGAMINHO`

```sql
CREATE TABLE PERGAMINHO(
    id_pergaminho INT PRIMARY KEY,
    tipo_buff VARCHAR(50),
    duracao_buff INT,
    nome_item VARCHAR(100),
    descricao TEXT,
    custo_item INT,
    FOREIGN KEY (id_pergaminho) REFERENCES CONSUMIVEL(id_item)
);
```

### Tabela `COMIDA`

```sql
CREATE TABLE COMIDA(
    id_comida INT PRIMARY KEY,
    tipo_bonus_atributo CHAR(20),
    bonus_atributo INT,
    bonus_atributo_duracao INT,
    nome_item VARCHAR(100),
    descricao TEXT,
    custo_item INT,
    FOREIGN KEY (id_comida) REFERENCES CONSUMIVEL(id_item)
);
```

### Tabela `ARMADURA` e Subtipos

```sql
CREATE TABLE ARMADURA (
    id_item INT PRIMARY KEY,
    tipo_armadura VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_item) REFERENCES ITEM(id_item),
    CONSTRAINT tipo_armadura_ck CHECK (tipo_armadura IN ('CAPACETE', 'BOTA', 'ACESSORIO', 'CAPA', 'ESCUDO', 'PEITORAL'))
);
```

### Tabelas `CAPACETE`,  `BOTA`,  `ACESSORIO`,  `CAPA`,  `ESCUDO`,  `PEITORAL`

As estruturas acima seguem padrão semelhante da tabela `CAPACETE`:

```sql
CREATE TABLE CAPACETE (
    id_armadura INT PRIMARY KEY,
    nome_item VARCHAR(20) NOT NULL,
    descricao TEXT NOT NULL,
    custo_item INT NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT,
    bonus_vida INT,

    FOREIGN KEY (id_armadura) REFERENCES ARMADURA(id_item)
);
-- Estrutura semelhante para BOTA, ACESSORIO, CAPA, ESCUDO, PEITORAL
```

---

