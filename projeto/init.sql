
CREATE TABLE JOGADOR (
    id_jogador SERIAL PRIMARY KEY,
    usuario VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    senha VARCHAR(50) NOT NULL,

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
    descricao_sala TEXT NOT NULL,

    FOREIGN KEY (id_direita) REFERENCES SALA(id_sala),
    FOREIGN KEY (id_esquerda) REFERENCES SALA(id_sala),
    FOREIGN KEY (id_baixo) REFERENCES SALA(id_sala),
    FOREIGN KEY (id_cima) REFERENCES SALA(id_sala)
);

CREATE TABLE NPC (
    id_npc SERIAL PRIMARY KEY,
    id_sala INT,
    nome VARCHAR(20) NOT NULL,
    descricao TEXT,
    dialogo VARCHAR(1000),

    FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
);

CREATE TABLE NPC_QUEST (
    id_npc INT PRIMARY KEY,

    FOREIGN KEY (id_npc) REFERENCES NPC(id_npc)
);

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
    descricao TEXT NOT NULL,
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
    descricao TEXT,
    objetivo VARCHAR(100),
    dinheiro DECIMAL NOT NULL,

    FOREIGN KEY (id_npc) REFERENCES NPC(id_npc)
);

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

CREATE TABLE INVENTARIO(
    id_inventario SERIAL PRIMARY KEY,
    id_personagem INT,

    FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM(id_personagem)

);
CREATE TABLE INSTANCIA_ITEM (
    id_instancia_item SERIAL ,
    id_item INT,
    id_sala INT,
    id_inventario INT,
    PRIMARY KEY (id_instancia_item, id_item),

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


CREATE TABLE CONSUMIVEL(
    id_item INT PRIMARY KEY,
    tipo_consumivel char(10),


    FOREIGN KEY (id_item) REFERENCES ITEM(id_item),
    CONSTRAINT tipo_consumivel_ck CHECK (tipo_consumivel IN ('POCAO', 'PERGAMINHO', 'COMIDA'))
);

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

CREATE TABLE PERGAMINHO(
    id_pergaminho INT PRIMARY KEY,
    tipo_buff VARCHAR(50),
    duracao_buff INT,
    nome_item VARCHAR(100),
    descricao TEXT,
    custo_item INT,

    FOREIGN KEY (id_pergaminho) REFERENCES CONSUMIVEL(id_item)

);

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

CREATE TABLE ARMADURA (
    id_item INT PRIMARY KEY,
    tipo_armadura VARCHAR(20) NOT NULL,
    
    FOREIGN KEY (id_item) REFERENCES ITEM(id_item),
    CONSTRAINT tipo_armadura_ck CHECK (tipo_armadura IN ('CAPACETE', 'BOTA', 'ACESSORIO', 'CAPA', 'ESCUDO', 'PEITORAL'))
);

CREATE TABLE CAPACETE (
    id_armadura INT PRIMARY KEY,
    nome_item VARCHAR(20) NOT NULL,
    descricao TEXT NOT NULL,
    custo_item INT NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT ,
    bonus_vida INT ,
    
    FOREIGN KEY (id_armadura) REFERENCES ARMADURA(id_item)
);

CREATE TABLE BOTA (
    id_armadura INT PRIMARY KEY,
    nome_item VARCHAR(20) NOT NULL,
    descricao TEXT NOT NULL,
    custo_item INT NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT,
    bonus_velocidade INT ,
    
    FOREIGN KEY (id_armadura) REFERENCES ARMADURA(id_item)
);

CREATE TABLE ACESSORIO (
    id_armadura INT PRIMARY KEY,
    nome_item VARCHAR(20) NOT NULL,
    descricao TEXT NOT NULL,
    custo_item DECIMAL NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT,
    bonus_vida INT ,
    bonus_esquiva INT ,
    bonus_mana INT ,
    
    FOREIGN KEY (id_armadura) REFERENCES ARMADURA(id_item)
);

CREATE TABLE CAPA (
    id_armadura INT PRIMARY KEY,
    nome_item VARCHAR(20) NOT NULL,
    descricao TEXT NOT NULL,
    custo_item DECIMAL NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT ,
    bonus_critico INT ,
    bonus_vida INT ,
    
    FOREIGN KEY (id_armadura) REFERENCES ARMADURA(id_item)
);

CREATE TABLE ESCUDO (
    id_armadura INT PRIMARY KEY,
    nome_item VARCHAR(20) NOT NULL,
    descricao TEXT NOT NULL,
    custo_item DECIMAL NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT ,
    bonus_vida INT ,
    bonus_defesa INT ,
    
    FOREIGN KEY (id_armadura) REFERENCES ARMADURA(id_item)
);

CREATE TABLE PEITORAL (
    id_armadura INT PRIMARY KEY,
    nome_item VARCHAR(20) NOT NULL,
    descricao TEXT,
    custo_item INT NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT ,
    bonus_vida INT ,
    bonus_defesa INT ,
    
    FOREIGN KEY (id_armadura) REFERENCES ARMADURA(id_item)
);

INSERT INTO SALA (id_sala, nome_sala, descricao_sala, id_direita, id_esquerda, id_baixo, id_cima) VALUES
(1, 'Campo de Prontera', 'Um vasto campo verde nos arredores da capital, com suaves colinas e o canto dos Poring.', NULL, 9, 2, NULL),
(2, 'Cidade de Prontera', 'A movimentada capital de Rune-Midgard. Lojas, aventureiros e a Ordem dos Cavaleiros te esperam.', NULL, NULL, 3, 1),
(3, 'Caminho para Payon', 'Uma estrada poeirenta que leva à cidade arqueira de Payon.', NULL, NULL, NULL, 2),
(4, 'Guilda dos Aventureiros', 'Onde novos aventureiros se registram e buscam missões. Um cheiro de café e papel antigo paira no ar.', NULL, NULL, NULL, 2), -- NOME CORRIGIDO AQUI
(5, 'Cidade de Payon', 'Conhecida por seus arqueiros habilidosos e templos serenos. Flechas voam em campos de treinamento próximos.', NULL, NULL, NULL, 3),
(6, 'Floresta de Payon', 'Uma floresta densa e mística, lar de criaturas curiosas e rumores de tesouros ocultos.', NULL, 7, 5, NULL),
(7, 'Entrada da Caverna de Payon', 'Uma abertura escura na montanha, de onde emana um ar úmido e um som distante de gotejamento.', 6, NULL, NULL, 8),
(8, 'Caverna de Payon - Nível 1', 'O primeiro nível da caverna. Estalactites e estalagmites pontiagudas formam o ambiente. Cuidado com os Zumbis!', NULL, NULL, 7, NULL),
(9, 'Campo de Geffen', 'Um campo tranquilo, mas com a grande Torre de Geffen no horizonte, emanando magia.', 1, NULL, NULL, NULL);