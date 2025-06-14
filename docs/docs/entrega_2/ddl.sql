CREATE TABLE JOGADOR (
    id_jogador SERIAL,
    usuario VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL,
    senha VARCHAR(50) NOT NULL,

    CONSTRAINT JOGADOR_PK PRIMARY KEY (id_jogador),
    CONSTRAINT JOGADOR_email_UK UNIQUE KEY (email)
);

CREATE TABLE CLASSE (
    id_classe SERIAL,
    nome_classe VARCHAR(100) NOT NULL,
    descricao TEXT,

    CONSTRAINT CLASSE_PK PRIMARY KEY (id_classe)
);

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

CREATE TABLE NPC (
    id_npc SERIAL,
    id_sala INT,
    nome VARCHAR(20) NOT NULL,
    descricao TEXT,
    dialogo TEXT,

    CONSTRAINT NPC_PK PRIMARY KEY (id_npc),
    CONSTRAINT NPC_SALA_FK FOREIGN KEY (id_sala) REFERENCES SALA (id_sala)
);

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

CREATE TABLE INSTANCIA_NPC_COMBATENTE (
    id_instancia SERIAL,
    id_npc_combatente INT,
    vida_atual INT NOT NULL DEFAULT 100,
    status_npc VARCHAR(15) NOT NULL,
    agressivo BOOLEAN NOT NULL,

    CONSTRAINT INSTANCIA_NPC_COMBATENTE_PK PRIMARY KEY (id_instancia),
    CONSTRAINT INSTANCIA_NPC_COMBATENTE_NPC_COMBATENTE_FK FOREIGN KEY (id_npc_combatente) REFERENCES NPC_COMBATENTE (id_npc_combatente)
);

CREATE TABLE ITEM (
    id_item SERIAL,
    id_npc_combatente INT,
    tipo_item VARCHAR(15) NOT NULL,

    CONSTRAINT ITEM_PK PRIMARY KEY (id_item),
    CONSTRAINT ITEM_NPC_COMBATENTE FOREIGN KEY (id_npc_combatente) REFERENCES NPC_COMBATENTE (id_npc_combatente),
    CONSTRAINT ITEM_tipo_CK CHECK (tipo IN ('CONSUMIVEL', 'ARMADURA', 'ARMA'))
);

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

CREATE TABLE vende_ESTOQUE_ITEM (
    id_estoque INT,
    id_item INT,

    CONSTRAINT vende_ESTOQUE_ITEM_PK PRIMARY KEY (id_estoque, id_item),
    CONSTRAINT vende_ESTOQUE_ITEM_ESTOQUE_FK FOREIGN KEY (id_estoque) REFERENCES ESTOQUE (id_estoque),
    CONSTRAINT vende_ESTOQUE_ITEM_ITEM_FK FOREIGN KEY (id_item) REFERENCES ITEM (id_item)
);

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

CREATE TABLE INVENTARIO (
    id_inventario SERIAL,
    id_personagem INT,
    
    CONSTRAINT INVENTARIO_PK PRIMARY KEY (id_inventario),
    CONSTRAINT INVENTARIO_PERSONAGEM_FK FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM (id_personagem)
);

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

CREATE TABLE pertence_PERSONAGEM_CLASSE (
    id_personagem INT NOT NULL,
    id_classe INT NOT NULL,

    CONSTRAINT pertence_PERSONAGEM_CLASSE_PK PRIMARY KEY (id_personagem, id_classe),
    CONSTRAINT pertence_PERSONAGEM_CLASSE_CLASSE_FK FOREIGN KEY (id_classe) REFERENCES CLASSE (id_classe),
    CONSTRAINT pertence_PERSONAGEM_CLASSE_PERSONAGEM_FK FOREIGN KEY (id_personagem) REFERENCES PERSONAGEM (id_personagem)
);

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


CREATE TABLE CONSUMIVEL (
    id_item INT,
    tipo_consumivel CHAR(10),

    CONSTRAINT CONSUMIVEL_PK PRIMARY KEY (id_item),
    CONSTRAINT CONSUMIVEL_ITEM_FK FOREIGN KEY (id_item) REFERENCES ITEM (id_item),
    CONSTRAINT tipo_consumivel_CK CHECK (tipo_consumivel IN ('POCAO', 'PERGAMINHO', 'COMIDA'))
);

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

CREATE TABLE ARMADURA (
    id_item INT,
    tipo_armadura VARCHAR(20) NOT NULL,

    CONSTRAINT ARMADURA_PK (id_item),
    CONSTRAINT ARMADURA_ITEM_FK FOREIGN KEY (id_item) REFERENCES ITEM (id_item),
    CONSTRAINT tipo_armadura_CK CHECK (tipo_armadura IN ('CAPACETE', 'BOTA', 'ACESSORIO', 'CAPA', 'ESCUDO', 'PEITORAL'))
);

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

CREATE TABLE ARMA(
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

CREATE TABLE LONGO_ALCANCE(
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

CREATE TABLE MAGICA(
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