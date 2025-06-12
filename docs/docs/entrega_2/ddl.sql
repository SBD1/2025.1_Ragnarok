CREATE DATABASE IF NOT EXISTS ragnarok;
USE ragnarok;

CREATE TABLE JOGADOR (
    id_jogador SERIAL PRIMARY KEY,
    usuario VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    senha VARCHAR(10) NOT NULL,

    CONSTRAINT jogador_uk UNIQUE (email)
);

CREATE TABLE CLASSE (
    id_classe SERIAL PRIMARY KEY,
    nome_classe VARCHAR(100) NOT NULL,
    descricao TEXT
);

CREATE TABLE SALA (
    id_sala SERIAL PRIMARY KEY,
    id_direita INT,
    id_esquerda INT,
    id_baixo INT,
    id_cima INT,
    nome_sala VARCHAR(30),
    descricao_sala VARCHAR(100) NOT NULL,

    FOREIGN KEY (id_direita) REFERENCES SALA(id_sala),
    FOREIGN KEY (id_esquerda) REFERENCES SALA(id_sala),
    FOREIGN KEY (id_baixo) REFERENCES SALA(id_sala),
    FOREIGN KEY (id_cima) REFERENCES SALA(id_sala)
);

CREATE TABLE NPC (
    id_npc SERIAL PRIMARY KEY,
    id_sala INT,
    nome VARCHAR(20) NOT NULL,
    descricao VARCHAR(30),
    dialogo VARCHAR(1000),

    FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
);

CREATE TABLE NPC_QUEST (
    id_npc INT PRIMARY KEY,

    FOREIGN KEY (id_npc) REFERENCES NPC(id_npc)
);

CREATE TABLE NPC_COMBATENTE (
    id_npc_combatente SERIAL PRIMARY KEY,
    tamanho VARCHAR(15) NOT NULL,
    raca VARCHAR(15) NOT NULL,
    descricao VARCHAR(300) NOT NULL,
    ataque INT NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT NOT NULL,
    nivel INT NOT NULL DEFAULT 1,
    precisao INT NOT NULL,
    esquiva INT NOT NULL,

    FOREIGN KEY (id_npc_combatente) REFERENCES NPC(id_npc)
);

CREATE TABLE INSTANCIA_NPC_COMBATENTE (
    id_instancia SERIAL PRIMARY KEY,
    id_npc_combatente INT,
    vida_atual INT NOT NULL DEFAULT 100,
    status_npc VARCHAR(15) NOT NULL,
    agressivo BOOLEAN NOT NULL,

    FOREIGN KEY (id_npc_combatente) REFERENCES NPC_COMBATENTE(id_npc_combatente)
);

CREATE TABLE ITEM (
    id_item SERIAL PRIMARY KEY,
    id_npc_combatente INT,
    nome VARCHAR(20) NOT NULL,
    tipo VARCHAR(15) NOT NULL,
    descricao VARCHAR(150) NOT NULL,
    atributos_bonus INT,
    custo DECIMAL NOT NULL,

    FOREIGN KEY (id_npc_combatente) REFERENCES NPC_COMBATENTE(id_npc_combatente),
    CONSTRAINT item_nome_uk UNIQUE (nome),
    CONSTRAINT tipo_ck CHECK (tipo IN ('CONSUMIVEL', 'ARMADURA', 'ARMA'))
);

CREATE TABLE ESTOQUE (
    id_estoque SERIAL PRIMARY KEY
);

CREATE TABLE NPC_VENDEDOR (
    id_npc_vendedor SERIAL PRIMARY KEY,
    id_estoque INT,

    FOREIGN KEY (id_estoque) REFERENCES ESTOQUE(id_estoque),
    FOREIGN KEY (id_npc_vendedor) REFERENCES NPC(id_npc)
);

CREATE TABLE VENDE_ESTOQUE_ITEM (
    id_estoque INT,
    id_item INT,

    PRIMARY KEY (id_estoque, id_item),
    FOREIGN KEY (id_estoque) REFERENCES ESTOQUE(id_estoque),
    FOREIGN KEY (id_item) REFERENCES ITEM(id_item)
);

CREATE TABLE MISSAO (
    id_missao SERIAL PRIMARY KEY,
    id_npc INT,
    requisito_level INT DEFAULT 1,
    xp_base INT NOT NULL,
    xp_classe INT NOT NULL,
    descricao VARCHAR(500),
    objetivo VARCHAR(100),
    dinheiro DECIMAL NOT NULL,

    FOREIGN KEY (id_npc) REFERENCES NPC(id_npc)
);

CREATE TABLE PERSONAGEM (
    id_personagem SERIAL PRIMARY KEY,
    id_jogador INT,
    id_classe INT,
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
    FOREIGN KEY (id_classe) REFERENCES CLASSE(id_classe),
    FOREIGN KEY (id_sala) REFERENCES SALA(id_sala),
    FOREIGN KEY (id_missao) REFERENCES MISSAO(id_missao)
);

CREATE TABLE INSTANCIA_ITEM (
    id_instancia INT,
    id_item INT,
    id_sala INT,
    id_inventario INT,
    PRIMARY KEY (id_instancia, id_item),

    FOREIGN KEY (id_item) REFERENCES ITEM(id_item),
    FOREIGN KEY (id_sala) REFERENCES SALA(id_sala),
    FOREIGN KEY (id_inventario) REFERENCES INVENTARIO(id_inventario)
);

CREATE TABLE PERTENCE_PERSONAGEM_CLASSE (
    id_personagem INT NOT NULL,
    id_classe INT NOT NULL,
    PRIMARY KEY (id_personagem, id_classe),
    FOREIGN KEY (id_classe) REFERENCES CLASSE(id_classe),
    FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM(id_personagem)
);

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
