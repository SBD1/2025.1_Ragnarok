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
    dialogo TEXT,

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

### Tabela `NPC_COMBATENTE`

A tabela `NPC_COMBATENTE` refere-se ao personagem não jogável do tipo combatente do sistema.

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
    - `id_npc_combatente`: Identificador único do NPC combatente que refencia o NPC (chave primária e chave estrangeira referenciando `NPC`). 
    - `tamanho`: Tamanho do NPC combatente.
    - `raca`: Raça do NPC combatente.
    - `descricao`: Descrição do NPC combatente.
    - `ataque`: Dano do ataque do NPC combatente.
    - `defesa`: Quantidade de defesa física do NPC combatente.
    - `defesa_magica`: Quantidade de defesa mágica do NPC combatente.
    - `nivel`: Nível do NPC combatente.
    - `precisao`: Taxa da precisão do NPC combatente.
    - `esquiva`: Taxa de esquivamento do NPC combatente.

### Tabela `INSTANCIA_NPC_COMBATENTE`

A tabela `INSTANCIA_NPC_COMBATENTE` refere-se a uma instância específica de um personagem não jogável combatente do sistema.

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

- Colunas:
    - `id_instancia`: Identificador único da instância (chave primária).
    - `id_npc_combatente`: Identificador do NPC (chave estrangeira referenciando `NPC_COMBATENTE`).
    - `vida_atual`: Vida atual do NPC combatente.
    - `status_npc`: Status atual do NPC combatente.
    - `agressivo`: Valor booleano que identifica a agressividade do NPC combatente.

### Tabela `ITEM`

A tabela `ITEM` refere-se aos itens genéricos presentes no sistema.

```sql
CREATE TABLE ITEM (
    id_item SERIAL,
    id_npc_combatente INT,
    tipo_item VARCHAR(15) NOT NULL,

    CONSTRAINT ITEM_PK PRIMARY KEY (id_item),
    CONSTRAINT ITEM_NPC_COMBATENTE FOREIGN KEY (id_npc_combatente) REFERENCES NPC_COMBATENTE (id_npc_combatente),
    CONSTRAINT ITEM_tipo_CK CHECK (tipo IN ('CONSUMIVEL', 'ARMADURA', 'ARMA'))
);
```

- Colunas:
    - `id_item`: Identificador único do item (chave primária).
    - `id_npc_combatente`: Identificador do NPC combatente pode dropar o item (chave estrangeira referenciando `NPC_COMBATENTE`, opcional).
    - `tipo_item`: Tipo do item (restrição entre `CONSUMIVEL`, `ARMADURA` e `ARMA`).

### Tabela `ESTOQUE`

A tabela `ESTOQUE` refere-se ao estoque possuído por um NPC_VENDEDOR.

```sql
CREATE TABLE ESTOQUE (
    id_estoque SERIAL,

    CONSTRAINT ESTOQUE_PK PRIMARY KEY (id_estoque)
);
```

- Colunas:
    - `id_estoque`: Identificador único do estoque (chave primária).

### Tabela `NPC_VENDEDOR`

A tabela `NPC_VENDEDOR` refere-se a um personagem não jogador do tipo vendedor.

```sql
CREATE TABLE NPC_VENDEDOR (
    id_npc_vendedor SERIAL,
    id_estoque INT,

    CONSTRAINT NPC_VENDEDOR_PK PRIMARY KEY (id_npc_vendedor),
    CONSTRAINT NPC_VENDEDOR_ESTOQUE_FK FOREIGN KEY (id_estoque) REFERENCES ESTOQUE (id_estoque),
    CONSTRAINT NPC_VENDEDOR_NPC_FK FOREIGN KEY (id_npc_vendedor) REFERENCES NPC (id_npc)
);
```

- Colunas:
    - `id_npc_vendedor`: Identificador único do NPC vendedor que referencia o NPC (chave primária e estrangeira referenciando `NPC`).
    - `id_estoque`: Identificador do estoque que o NPC vendedor possui (chave estrangeira referenciando `ESTOQUE`).

### Tabela `vende_ESTOQUE_ITEM`

A tabela `vende_ESTOQUE_ITEM` refere-se ao item vendido a partir do estoque.

```sql
CREATE TABLE vende_ESTOQUE_ITEM (
    id_estoque INT,
    id_item INT,

    CONSTRAINT vende_ESTOQUE_ITEM_PK PRIMARY KEY (id_estoque, id_item),
    CONSTRAINT vende_ESTOQUE_ITEM_ESTOQUE_FK FOREIGN KEY (id_estoque) REFERENCES ESTOQUE (id_estoque),
    CONSTRAINT vende_ESTOQUE_ITEM_ITEM_FK FOREIGN KEY (id_item) REFERENCES ITEM (id_item)
);
```

- Colunas:
    - `id_estoque`: Identificador único que referencia o estoque (chave primária e estrangeira referenciando `ESTOQUE`).
    - `id_item`: Identificador único que referencia o item (chave primária e estrangeira referenciando `ITEM`).

### Tabela `MISSAO`

A tabela `MISSAO` refere-se ás missões do sistema.

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
    CONSTRAINT MISSAO_NPC_FK FOREIGN KEY (id_npc) REFERENCES NPC (id_npc)
);
```

- Colunas:
    - `id_missao`: Identificador único da missão (chave primária).
    - `id_npc`: Identificador do NPC quest que repassa a missão (chave estrangeira referenciando `NPC_QUEST`).
    - `requisito_level`: Requisito de nível para a missão.
    - `xp_base`: XP dado pela completude da missão.
    - `xp_classe`: XP dado pela completude da missão de acordo com a classe do personagem.
    - `descricao`: Descrição da missão.
    - `objetivo`: Objetivo da missão.
    - `dinheiro`: Dinheiro dado pela missão.

### Tabela `PERSONAGEM`

A tabela `PERSONAGEM` refere-se ao personagem criado pelo jogador no sistema.

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

- Colunas: 
    - `id_personagem`: Identificador único do personagem (chave primária).
    - `id_jogador`: Referência ao jogador dono do personagem (chave estrangeira referenciando `JOGADOR`).
    - `id_sala`: Sala atual onde o personagem está localizado (chave estrangeira referenciando `SALA`).
    - `id_missao`: Missão atualmente atribuída ao personagem (chave estrangeira referenciando `MISSAO`).
    - `nome`: Nome do personagem.
    - `mana`: Quantidade atual de mana.
    - `vida`: Quantidade atual de vida.
    - `vitalidade, inteligencia, agilidade, sorte, destreza, forca`: Atributos base do personagem.
    - `ataque, ataque_magico`: Poder ofensivo físico e mágico.
    - `precisao`
    - `esquiva`: Capacidade de acertar e evitar ataques.
    - `defesa, defesa_magica`: Resistência física e mágica.
    - `critico`: Taxa de acerto crítico.
    - `velocidade`: Velocidade de ação do personagem.
    - `nivel`: Nível atual do personagem.
    - `dinheiro`: Quantia de dinheiro carregada pelo personagem.

### Tabela `INVENTARIO`

A tabela `INVENTARIO` refere-se ao inventário do jogador.

```sql
CREATE TABLE INVENTARIO (
    id_inventario SERIAL,
    id_personagem INT,
    
    CONSTRAINT INVENTARIO_PK PRIMARY KEY (id_inventario),
    CONSTRAINT INVENTARIO_PERSONAGEM_FK FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM (id_personagem)
);
```

- Colunas:
    - `id_inventario`: Identificador único do inventário (chave primária).
    - `id_personagem`: Identificador do personagem que possui o inventário (chave estrangeira referenciando `PERSONAGEM`).

### Tabela `INSTANCIA_ITEM`

A tabela `INSTANCIA_ITEM` refere-se a instância específica de um item no sistema.

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

- Colunas:
    - `id_instancia_item`: Identificador único da instância do item (chave primária).
    - `id_item`: Identificador único que referencia o item genérico (chave primária e estrangeira referenciando `ITEM`).
    - `id_sala`: Identificador da sala em que o item se encontra (chave estrangeira referenciando `SALA`).
    - `id_inventario`: Identificador do inventário em que o item se encontra (chave estrangeira referenciando `INVENTARIO`).

### Tabela `pertence_PERSONAGEM_CLASSE`

- A tabela `pertence_PERSONAGEM_CLASSE` refere-se a classe em que o personagem pertence no sistema.

```sql
CREATE TABLE pertence_PERSONAGEM_CLASSE (
    id_personagem INT NOT NULL,
    id_classe INT NOT NULL,

    CONSTRAINT pertence_PERSONAGEM_CLASSE_PK PRIMARY KEY (id_personagem, id_classe),
    CONSTRAINT pertence_PERSONAGEM_CLASSE_CLASSE_FK FOREIGN KEY (id_classe) REFERENCES CLASSE (id_classe),
    CONSTRAINT pertence_PERSONAGEM_CLASSE_PERSONAGEM_FK FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM (id_personagem)
);
```

- Colunas:
    - `id_personagem`: Identificador único que referencia o personagem (chave primária e estrangeira referenciando `PERSONAGEM`).
    - `id_classe`: Identificador único que referencia a classe do personagem (chave primária e estrangeira referenciando `CLASSE`).

### Tabela `HABILIDADE`

A tabela `HABILIDADE` refere-se as habilidades de uma classe no sistema.

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

- Colunas:
    - `id_habilidade`: Identificador único da habilidade (chave primária).
    - `id_classe`: Identificador da classe a qual a habilidade pertence (chave estrangeira referenciando `CLASSE`).
    - `nome_habilidade`: Nome da habilidade.
    - `descricao`: Descrição da habilidade.
    - `custo_mana`: Custo de mana da habilidade.
    - `dano`: Dano da habilidade.
    - `nivel_requerido`: Nível necessário para aprender uma habilidade.

### Tabela `CONSUMIVEL` e Subtipos

A tabela `Consumível` refere-se aos itens consumíveis do jogo.

```sql
CREATE TABLE CONSUMIVEL (
    id_item INT,
    tipo_consumivel CHAR(10),

    CONSTRAINT CONSUMIVEL_PK PRIMARY KEY (id_item),
    CONSTRAINT CONSUMIVEL_ITEM_FK FOREIGN KEY (id_item) REFERENCES ITEM (id_item),
    CONSTRAINT tipo_consumivel_CK CHECK (tipo_consumivel IN ('POCAO', 'PERGAMINHO', 'COMIDA'))
);
```

- Colunas: 
    - `id_item`: Identificador único que referencia o item genérico (chave primária e estrangeira referenciando `ITEM`).
    - `tipo_consumivel`: Tipo de item consumível (restrição entre `POCAO`, `PERGAMINHO` e `COMIDA`).

### Tabela `POCAO`

A tabela `POCAO` refere-se aos itens consumíveis do tipo poção.

```sql
CREATE TABLE POCAO(
    id_consumivel INT,
    tipo_bonus_atributo VARCHAR(20),
    recupera_vida INT,
    recupera_mana INT,
    nome_item VARCHAR(100),
    descricao TEXT,
    custo_item INT,

    CONSTRAINT POCAO_PK PRIMARY KEY (id_consumivel),
    CONSTRAINT POCAO_CONSUMIVEL_FK FOREIGN KEY (id_consumivel) REFERENCES CONSUMIVEL(id_item)
);
```

- Colunas:
    - `id_consumivel`: Identificador único da pocao que referencia o item consumível (chave primária e estrangeira referenciando `CONSUMIVEL`).
    - `tipo_bonus_atributo`: Tipo de bônus e atributos que a poção oferece ao personagem.
    - `recupera_vida`: Quantidade de vida recuperada pela poção.
    - `recupera_mana`: Quantidade de mana recuperada pela poção.
    - `nome_item`: Nome do item consumível do tipo poção.
    - `descricao`: Descrição do item consumível do tipo poção.
    - `custo_item`: Custo do item consumível do tipo poção.

### Tabela `PERGAMINHO`

A tabela `PERGAMINHO` refere-se aos itens consumíveis do tipo pergaminho.

```sql
CREATE TABLE PERGAMINHO (
    id_consumivel INT,
    tipo_buff VARCHAR(50),
    duracao_buff INT,
    nome_item VARCHAR(100),
    descricao TEXT,
    custo_item INT,

    CONSTRAINT PERGAMINHO_PK PRIMARY KEY (id_pergaminho),
    CONSTRAINT PERGAMINHO_CONSUMIVEL_FK FOREIGN KEY (id_pergaminho) REFERENCES CONSUMIVEL (id_item)
);
```

- Colunas:
    - `id_consumivel`: Identificador único do pergaminho que referencia o item consumível (chave primária e estrangeira referenciando `CONSUMIVEL`).
    - `tipo_bonus_atributo`: Tipo de bônus e atributos que a poção oferece ao personagem.
    - `bonus_atributo`: Bônus de atributo que a poção oferece.
    - `bonus_atributo_duracao`: Duração do bônus.
    - `nome_item`: Nome do item consumível do tipo poção.
    - `descricao`: Descrição do item consumível do tipo poção.
    - `custo_item`: Custo do item consumível do tipo poção.

### Tabela `COMIDA`

A tabela `COMIDA` refere-se aos itens consumíveis do tipo comida.

```sql
CREATE TABLE COMIDA (
    id_consumivel INT,
    tipo_bonus_atributo VARCHAR(20),
    bonus_atributo INT,
    bonus_atributo_duracao INT,
    nome_item VARCHAR(100),
    descricao TEXT,
    custo_item INT,

    CONSTRAINT COMIDA_PK PRIMARY KEY (id_comida),
    CONSTRAINT COMIDA_CONSUMIVEL_FK FOREIGN KEY (id_comida) REFERENCES CONSUMIVEL (id_item)
);
```

- Colunas:
    - `id_consumivel`: Identificador único da comida que referencia o item consumível (chave primária e estrangeira referenciando `CONSUMIVEL`).
    - `tipo_bonus_atributo`: Tipo de bônus e atributos que a poção oferece ao personagem.
    - `bonus_atributo`: Bônus de atributo que a poção oferece.
    - `bonus_atributo_duracao`: Duração do bônus.
    - `nome_item`: Nome do item consumível do tipo poção.
    - `descricao`: Descrição do item consumível do tipo poção.
    - `custo_item`: Custo do item consumível do tipo poção.


### Tabela `ARMADURA` e Subtipos

A tabela `ARMADURA` refere-se aos itens do tipo armadura.

```sql
CREATE TABLE ARMADURA (
    id_item INT,
    tipo_armadura VARCHAR(20) NOT NULL,

    CONSTRAINT ARMADURA_PK (id_item),
    CONSTRAINT ARMADURA_ITEM_FK FOREIGN KEY (id_item) REFERENCES ITEM (id_item),
    CONSTRAINT tipo_armadura_CK CHECK (tipo_armadura IN ('CAPACETE', 'BOTA', 'ACESSORIO', 'CAPA', 'ESCUDO', 'PEITORAL'))
);
```

- Colunas:
    - `id_item`: Identificador único de armadura que referencia o item (chave primária e chave estrangeira referenciando `ITEM`).
    - `tipo_armadura`: Tipo de armadura (restrições entre `CAPACETE`, `BOTA`, `ACESSORIO`, `CAPA`, `ESCUDO`).

### Tabelas `CAPACETE`,  `BOTA`,  `ACESSORIO`,  `CAPA`,  `ESCUDO`,  `PEITORAL`

As tabela acima, como `CAPACETE` refere-se aos itens de armadura do tipo CAPACETE. As seguintes possuem um padrão semelhante a ela:

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
```

- Colunas:
    - `id_armadura`: Identificador único de capacete que referencia a armadura (chave primária e estrangeira referenciando `ARMADURA`).
    - `nome_item`: Nome da armadura do tipo capacete.
    - `descricao`: Descrição da armadura do tipo capacete.
    - `custo_item`: Custo da armadura do tipo capacete.
    - `defesa`: Defesa física da armadura do tipo capacete.
    - `defesa_magica`: Defesa mágica da armadura do tipo capacete.
    - `bonus_vida`: Quantidade de bônus de vida da armadura do tipo capacete.

### Tabela `BOTA`

A tabela `BOTA` refere-se aos itens de armadura do tipo bota.

```sql
CREATE TABLE BOTA (
    id_armadura INT
    nome_item VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    custo_item INT NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT,
    bonus_velocidade INT ,
    
    CONSTRAINT BOTA_PK PRIMARY KEY (id_armadura),
    CONSTRAINT BOTA_ARMADURA_FK FOREIGN KEY (id_armadura) REFERENCES ARMADURA (id_item)
);
```

### Tabela `ACESSORIO`

A tabela `ACESSORIO` refere-se aos itens de armadura do tipo acessorio.

```sql
CREATE TABLE ACESSORIO (
    id_armadura INT PRIMARY KEY,
    nome_item VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    custo_item DECIMAL NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT,
    bonus_vida INT ,
    bonus_esquiva INT ,
    bonus_mana INT ,
    
    CONSTRAINT ACESSORIO_PK PRIMARY KEY (id_armadura),
    CONSTRAINT ACESSORIO_ARMADURA_FK FOREIGN KEY (id_armadura) REFERENCES ARMADURA (id_item)
);
```

### Tabela `CAPA`

A tabela `CAPA` refere-se aos itens de armadura do tipo capa.

```sql
CREATE TABLE CAPA (
    id_armadura INT PRIMARY KEY,
    nome_item VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    custo_item DECIMAL NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT ,
    bonus_critico INT ,
    bonus_vida INT ,
    
    CONSTRAINT CAPA_PK PRIMARY KEY (id_armadura),
    CONSTRAINT CAPA_ARMADURA_FK FOREIGN KEY (id_armadura) REFERENCES ARMADURA (id_item)
);
```

### Tabela `ESCUDO`

A tabela `ESCUDO` refere-se aos itens de armadura do tipo escudo.

```sql
CREATE TABLE ESCUDO (
    id_armadura INT PRIMARY KEY,
    nome_item VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    custo_item DECIMAL NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT ,
    bonus_vida INT ,
    bonus_defesa INT ,
    
    CONSTRAINT ESCUDO_PK PRIMARY KEY (id_armadura),
    CONSTRAINT ESCUDO_ARMADURA_FK FOREIGN KEY (id_armadura) REFERENCES ARMADURA (id_item)
);
```

### Tabela `PEITORAL`

A tabela `PEITORAL` refere-se aos itens de armadura do tipo peitoral.

```sql
CREATE TABLE PEITORAL (
    id_armadura INT PRIMARY KEY,
    nome_item VARCHAR(100) NOT NULL,
    descricao TEXT,
    custo_item INT NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT ,
    bonus_vida INT ,
    bonus_defesa INT ,
    
    CONSTRAINT PEITORAL_PK PRIMARY KEY (id_armadura),
    CONSTRAINT PEITORAL_ARMADURA_FK FOREIGN KEY (id_armadura) REFERENCES ARMADURA (id_item)
);
```

### Tabela `ARMA` e Subtipos

A tabela `ARMA` refere-se aos itens do tipo arma.

```sql
CREATE TABLE ARMA (
    id_item INT,
    tipo_arma VARCHAR(15),
    dano_base INT,
    bonus_danos INT,
    descricao TEXT,
    nome_item VARCHAR(100) NOT NULL,
    custo_item INT,

    CONSTRAINT ARMA_PK PRIMARY KEY (id_item),
    CONSTRAINT ARMA_ITEM_FK FOREIGN KEY (id_item) REFERENCES ITEM (id_item)
);
```

### Tabela `LONGO_ALCANCE`

A tabela `LONGO_ALCANCE` refere-se aos itens de armadura do tipo longo alcance.

```sql
CREATE TABLE LONGO_ALCANCE (
    id_arma INT,
    tipo_projetil VARCHAR(30),
    quantidade_projetil INT,
    descricao TEXT,
    nome_item VARCHAR(100),
    dano_base INT,
    bonus_dano INT,
    custo_item INT,

    CONSTRAINT LONGO_ALCANCE_PK PRIMARY KEY (id_arma),
    CONSTRAINT LONGO_ALCANCE_ARMA_FK FOREIGN KEY (id_arma) REFERENCES ARMA(id_item)
);
```

### Tabela `MAGICA`

A tabela `MAGICA` refere-se aos itens de armadura do tipo magica.

```sql
CREATE TABLE MAGICA (
    id_arma INT,
    tipo_magia VARCHAR(30),
    efeito_magico VARCHAR(30),
    descricao TEXT,
    nome_item VARCHAR(100),
    custo_item INT,
    dano_base INT,
    bonus_dano INT,

    CONSTRAINT MAGICA_PK PRIMARY KEY (id_arma),
    CONSTRAINT MAGICA_ARMA_FK FOREIGN KEY (id_arma) REFERENCES ARMA (id_item)
);
```

---

## Histórico de Versão

|  Versão  |     Data     | Descrição | Autor(es) | Revisor(es) |
| :------: | :----------: | :-----------: | :---------: | :---------: |
| `1.0` | 11/06/2025 | Criação do documento e primeira versão do DDL | [Amanda Cruz](https://github.com/mandicrz), [Felipe Motta](https://github.com/M0tt1nh4), [Ian Costa](https://github.com/iancostag), [Kauã Richard](https://github.com/r1ch4rd1) | [Danilo Naves](https://github.com/DaniloNavesS) |
| `1.1` | 11/06/2025 | Ajustes de formatação e código | [Amanda Cruz](https://github.com/mandicrz), [Felipe Motta](https://github.com/M0tt1nh4), [Ian Costa](https://github.com/iancostag), [Kauã Richard](https://github.com/r1ch4rd1) | [Danilo Naves](https://github.com/DaniloNavesS) |


