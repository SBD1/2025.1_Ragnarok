
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
    dialogo TEXT,

    FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
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
    tipo_item CHAR(15) NOT NULL,

    FOREIGN KEY (id_npc_combatente) REFERENCES NPC_COMBATENTE(id_npc_combatente),
    CONSTRAINT tipo_ck CHECK (tipo_item IN ('CONSUMIVEL', 'ARMADURA', 'ARMA'))
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
    tipo_bonus_atributo VARCHAR(20),
    recupera_vida INT,
    recupera_mana INT,
    nome_item VARCHAR(100),
    descricao TEXT,
    custo_item INT,

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
    tipo_bonus_atributo VARCHAR(20),
    bonus_atributo INT,
    bonus_atributo_duracao INT,
    nome_item VARCHAR(100),
    descricao TEXT,
    custo_item INT,

    FOREIGN KEY (id_comida) REFERENCES CONSUMIVEL(id_item)
);

CREATE TABLE ARMADURA (
    id_item INT PRIMARY KEY,
    tipo_armadura CHAR(20) NOT NULL,
    
    FOREIGN KEY (id_item) REFERENCES ITEM(id_item),
    CONSTRAINT tipo_armadura_ck CHECK (tipo_armadura IN ('CAPACETE', 'BOTA', 'ACESSORIO', 'CAPA', 'ESCUDO', 'PEITORAL'))
);

CREATE TABLE CAPACETE (
    id_armadura INT PRIMARY KEY,
    nome_item VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    custo_item INT NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT ,
    bonus_vida INT ,
    
    FOREIGN KEY (id_armadura) REFERENCES ARMADURA(id_item)
);

CREATE TABLE BOTA (
    id_armadura INT PRIMARY KEY,
    nome_item VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    custo_item INT NOT NULL,
    defesa INT NOT NULL,
    defesa_magica INT,
    bonus_velocidade INT ,
    
    FOREIGN KEY (id_armadura) REFERENCES ARMADURA(id_item)
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
    
    FOREIGN KEY (id_armadura) REFERENCES ARMADURA(id_item)
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
    
    FOREIGN KEY (id_armadura) REFERENCES ARMADURA(id_item)
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
    
    FOREIGN KEY (id_armadura) REFERENCES ARMADURA(id_item)
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
    
    FOREIGN KEY (id_armadura) REFERENCES ARMADURA(id_item)
);

CREATE TABLE ARMA(
    id_item INT PRIMARY KEY,
    tipo_arma VARCHAR(15),
    dano_base INT,
    bonus_danos INT,
    descricao TEXT,
    nome_item VARCHAR(100) NOT NULL,
    custo_item INT,

    FOREIGN KEY (id_item) REFERENCES ITEM(id_item)
);

CREATE TABLE LONGO_ALCANCE(
    id_arma INT PRIMARY KEY,
    tipo_projetil VARCHAR(30),
    quantidade_projetil INT,
    descricao TEXT,
    nome_item VARCHAR(100),
    dano_base INT,
    bonus_dano INT,
    custo_item INT,

    FOREIGN KEY (id_arma) REFERENCES ARMA(id_item)
);

CREATE TABLE MAGICA(
    id_arma INT PRIMARY KEY,
    tipo_magia VARCHAR(30),
    efeito_magico VARCHAR(30),
    descricao TEXT,
    nome_item VARCHAR(100),
    custo_item INT,
    dano_base INT,
    bonus_dano INT,

    FOREIGN KEY(id_arma) REFERENCES ARMA(id_item)
);

-- 1. Inserindo Classes 
INSERT INTO CLASSE (id_classe, nome_classe, descricao) VALUES
(1, 'Espadachim', 'Especialista em combate corpo a corpo com alta defesa'),
(2, 'Mago', 'Utiliza magias poderosas para atacar à distância'),
(3, 'Arqueiro', 'Especialista em ataques à distância com arcos');

-- 2. Inserindo Habilidades 
INSERT INTO HABILIDADE (id_classe, nome_habilidade, descricao, custo_mana, dano, nivel_requerido) VALUES
(1, 'Espadada', 'Ataque básico com espada', 5, 15, 1),
(1, 'Golpe Fulminante', 'Ataque forte que causa dano adicional', 15, 30, 3),
(2, 'Lança de Fogo', 'Conjura lanças de fogo para queimar o inimigo', 20, 25, 1),
(2, 'Lança de Gelo', 'Invoca lanças de gelo que perfuram o inimigo', 35, 40, 5),
(3, 'Flecha Rápida', 'Dispara duas flechas com velocidade aumentada', 10, 20, 1),
(3, 'Chuva de Flechas', 'Dispara múltiplas flechas contra vários inimigos que estejam próximos', 25, 35, 4);

-- 3. Inserindo Salas 
INSERT INTO SALA (id_sala, nome_sala, descricao_sala, id_direita, id_esquerda, id_baixo, id_cima) VALUES
(1, 'Campo de Prontera', 'Um vasto campo verde nos arredores da capital, com suaves colinas e o canto dos Poring.', NULL, 9, 2, NULL),
(2, 'Cidade de Prontera', 'A movimentada capital de Rune-Midgard. Lojas, aventureiros e a Ordem dos Cavaleiros te esperam.', NULL, NULL, 3, 1),
(3, 'Caminho para Payon', 'Uma estrada poeirenta que leva à cidade arqueira de Payon.', NULL, NULL, 5, 2),
(4, 'Guilda dos Aventureiros', 'Onde novos aventureiros se registram e buscam missões. Um cheiro de café e papel antigo paira no ar.', NULL, NULL, NULL, 2),
(5, 'Cidade de Payon', 'Conhecida por seus arqueiros habilidosos e templos serenos. Flechas voam em campos de treinamento próximos.', NULL, 6, NULL, 3),
(6, 'Floresta de Payon', 'Uma floresta densa e mística, lar de criaturas curiosas e rumores de tesouros ocultos.', NULL, 7, 5, NULL),
(7, 'Entrada da Caverna de Payon', 'Uma abertura escura na montanha, de onde emana um ar úmido e um som distante de gotejamento.', 6, NULL, NULL, 8),
(8, 'Caverna de Payon - Nível 1', 'O primeiro nível da caverna. Estalactites e estalagmites pontiagudas formam o ambiente. Cuidado com os Zumbis!', NULL, NULL, 7, NULL),
(9, 'Campo de Geffen', 'Um campo tranquilo, mas com a grande Torre de Geffen no horizonte, emanando magia.', 1, NULL, NULL, NULL);

-- 4. Inserindo NPCs
INSERT INTO NPC (id_sala, nome, descricao, dialogo) VALUES
(1, 'Aldeão', 'Um simples morador da cidade', 'Bem-vindo a nossa cidade, aventureiro! Cuidado com os lobos na floresta.'),
(1, 'Ferreiro', 'Um robusto ferreiro da cidade', 'Precisa de equipamentos? Tenho os melhores da região!'),
(5, 'Lobo', 'Um lobo selvagem e agressivo', 'Grrrrrrr! rosna'),
(6, 'Velho Sábio', 'Um ancião cheio de conhecimento', 'Dizem que há um tesouro escondido nas profundezas desta caverna...'),
(7, 'Mago Arcanjo', 'Um poderoso mago', 'Interessado em aprender magias poderosas?');

-- 5. Inserindo NPCs Combatentes
INSERT INTO NPC_COMBATENTE (id_npc_combatente, tamanho, raca, descricao, ataque, defesa, defesa_magica, nivel, precisao, esquiva) VALUES
(3, 'Médio', 'Lobo', 'Lobo selvagem que ataca qualquer intruso', 20, 10, 5, 2, 70, 60);

-- 6. Inserindo Instâncias de NPCs Combatentes
INSERT INTO INSTANCIA_NPC_COMBATENTE (id_npc_combatente, vida_atual, status_npc, agressivo) VALUES
(3, 100, 'VIVO', TRUE);

-- 7. Inserindo Estoque para vendedores
INSERT INTO ESTOQUE (id_estoque) VALUES (1), (2);

-- 8. Inserindo NPCs Vendedores
INSERT INTO NPC_VENDEDOR (id_npc_vendedor, id_estoque) VALUES
(2, 1),  -- Ferreiro
(5, 2);  -- Mago Arcanjo

-- 9. Inserindo Itens 
-- Cria o ITEM e devolve o id gerado
CREATE OR REPLACE FUNCTION create_item(
    _tipo_item  ITEM.tipo_item%TYPE
) RETURNS INTEGER AS $$
DECLARE
    _new_id ITEM.id_item%TYPE;
BEGIN
    INSERT INTO ITEM (tipo_item)
    VALUES (_tipo_item)
    RETURNING id_item INTO _new_id;
    RETURN _new_id;
END;
$$ LANGUAGE plpgsql;


-- procedure do peitoral
CREATE OR REPLACE FUNCTION add_armadura_peitoral (
    _nome_item          TEXT,
    _descricao          TEXT,
    _custo_item         INTEGER,
    _defesa             INTEGER,
    _defesa_magica      INTEGER,
    _bonus_vida         INTEGER,
    _bonus_defesa       INTEGER
) RETURNS INTEGER AS $$
DECLARE
    _id_item   INTEGER;
BEGIN
    -- 1) ITEM (tipo = 'ARMADURA')
    _id_item := create_item('ARMADURA');

    -- 2) ARMADURA (tipo_armadura = 'PEITORAL')
    INSERT INTO ARMADURA (id_item, tipo_armadura)
    VALUES (_id_item, 'PEITORAL');

    -- 3) PEITORAL (detalhes)
    INSERT INTO PEITORAL (
        id_armadura,  nome_item, descricao, custo_item,
        defesa, defesa_magica, bonus_vida, bonus_defesa
    ) VALUES (
        _id_item, _nome_item, _descricao, _custo_item,
        _defesa, _defesa_magica, _bonus_vida, _bonus_defesa
    );

    RETURN _id_item;
END;
$$ LANGUAGE plpgsql;


SELECT add_armadura_peitoral(
    _nome_item      := 'Malha das Asas da Luz',
    _descricao      := 'Vestimenta decorada com plumas brancas.',
    _custo_item     := 2000,
    _defesa         := 45,
    _defesa_magica  := 5,
    _bonus_vida     := 300,
    _bonus_defesa   := 200
);
-- → devolve o novo id_item
SELECT add_armadura_peitoral(
    _nome_item := 'Peitoral de Couro',
    _descricao := 'Peitoral feito de couro de animais silvestres comuns.',
    _custo_item := 150,
    _defesa := 5,
    _defesa_magica := 0,
    _bonus_vida := 20,
    _bonus_defesa := 5

)

-- Primeiro inserimos os itens básicos
INSERT INTO ITEM (tipo_item) VALUES 
('ARMA'),  -- id_item = 1 (Espada de Ferro)
('ARMA'),  -- id_item = 2 (Cajado do Aprendiz)
('ARMA'),  -- id_item = 3 (Arco Curto)
('CONSUMIVEL'),  -- id_item = 4 (Poção de Cura)
('CONSUMIVEL'),  -- id_item = 5 (Pergaminho de Fogo)
('CONSUMIVEL');  -- id_item = 7 (Garra de Lobo)

-- 11. Inserindo Armas 
INSERT INTO ARMA (id_item, tipo_arma, dano_base, bonus_danos, descricao, nome_item, custo_item) VALUES
(1, 'CORPO_A_CORPO', 15, 5, 'Uma espada básica de ferro', 'Espada de Ferro', 100),
(2, 'MAGICA', 10, 3, 'Cajado básico para magos iniciantes', 'Cajado do Aprendiz', 80),
(3, 'LONGO_ALCANCE', 12, 4, 'Arco simples para treinamento', 'Arco Curto', 90);

-- Detalhes das armas específicas
INSERT INTO LONGO_ALCANCE (id_arma, tipo_projetil, quantidade_projetil, descricao, nome_item, dano_base, bonus_dano, custo_item) VALUES
(3, 'FLECHA', 20, 'Arco simples para treinamento', 'Arco Curto', 12, 4, 90);

INSERT INTO MAGICA (id_arma, tipo_magia, efeito_magico, descricao, nome_item, custo_item, dano_base, bonus_dano) VALUES
(2, 'ELEMENTAL', 'FOGO', 'Cajado básico para magos iniciantes', 'Cajado do Aprendiz', 80, 10, 3);

-- 12. Inserindo Consumíveis
INSERT INTO CONSUMIVEL (id_item, tipo_consumivel) VALUES
(4, 'POCAO'),
(5, 'PERGAMINHO'),
(7, 'COMIDA');

-- Detalhes da Poção
INSERT INTO POCAO (id_consumivel, tipo_bonus_atributo, recupera_vida, recupera_mana, nome_item, descricao, custo_item) VALUES
(4, 'VIDA', 50, 0, 'Poção de Cura', 'Restaura 50 pontos de vida', 30);

-- Detalhes do Pergaminho
INSERT INTO PERGAMINHO (id_pergaminho, tipo_buff, duracao_buff, nome_item, descricao, custo_item) VALUES
(5, 'ATAQUE DE FOGO', 3, 'Pergaminho de Fogo', 'Ataques causam dano adicional de fogo por 3 turnos', 50);

-- Detalhes da Comida
INSERT INTO COMIDA (id_comida, tipo_bonus_atributo, bonus_atributo, bonus_atributo_duracao, nome_item, descricao, custo_item) VALUES
(7, 'FORCA', 5, 10, 'Garra de Lobo', 'Aumenta força por 10 minutos', 15);

-- 13. Associando itens aos estoques dos vendedores
INSERT INTO VENDE_ESTOQUE_ITEM (id_estoque, id_item) VALUES
(1, 1), -- Ferreiro vende Espada de Ferro
(2, 2), -- Mago vende Cajado do Aprendiz
(2, 4), -- Mago vende Poção de Cura
(2, 5); -- Mago vende Pergaminho de Fogo

-- 14. Inserindo Jogadores
INSERT INTO JOGADOR (usuario, email, senha) VALUES
('iancostag', 'iancostag@gmail.com', '123'),
('danilo', 'danilonaves@gmail.com', '456'),
('igris', 'richard@gmail.com', '789');

-- 15. Inserindo Missões
INSERT INTO MISSAO (id_npc, requisito_level, xp_base, xp_classe, descricao, objetivo, dinheiro) VALUES
(3, 1, 100, 50, 'Derrote 5 lobos na floresta', 'Matar 5 lobos', 50),
(4, 3, 200, 100, 'Encontre o tesouro perdido na caverna', 'Explorar a caverna', 100),
(5, 5, 300, 150, 'Aprenda uma magia avançada', 'Falar com o mago', 150);

-- 16. Inserindo Personagens
INSERT INTO PERSONAGEM (id_jogador, id_sala, id_missao, nome, mana, vida, vitalidade, inteligencia, agilidade, sorte, destreza, forca, ataque, ataque_magico, precisao, esquiva, defesa, defesa_magica, critico, velocidade, nivel, dinheiro) VALUES
(1, 1, 1, 'kamishiro', 50, 200, 10, 5, 8, 7, 9, 12, 20, 5, 70, 60, 15, 10, 10, 8, 1, 200),
(2, 1, NULL, 'Patolino, O Mago', 100, 150, 5, 15, 6, 8, 7, 5, 8, 25, 65, 50, 8, 20, 5, 6, 1, 150),
(3, 1, NULL, 'igris', 60, 180, 8, 7, 12, 10, 12, 8, 18, 8, 80, 70, 12, 12, 15, 10, 1, 180);

-- 17. Associando classes aos personagens
INSERT INTO PERTENCE_PERSONAGEM_CLASSE (id_personagem, id_classe) VALUES
(1, 3), -- kamishiro é Arqueiro
(2, 2), -- Patolino é Mago
(3, 1); -- Igris é Espadachim

-- 18. Inserindo Inventários
INSERT INTO INVENTARIO (id_personagem) VALUES
(1),
(2),
(3);

-- 19. Inserindo Instâncias de Itens nos Inventários
INSERT INTO INSTANCIA_ITEM (id_item, id_inventario) VALUES
(3, 1), -- kamishiro tem Arco Curto
(2, 2), -- Patolino tem Cajado do Aprendiz
(1, 3); -- Igris tem Espada de Ferro