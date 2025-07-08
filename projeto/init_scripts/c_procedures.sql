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

-- devolve o novo id_item
SELECT add_armadura_peitoral(
    _nome_item := 'Peitoral de Couro',
    _descricao := 'Peitoral feito de couro de animais silvestres comuns.',
    _custo_item := 150,
    _defesa := 5,
    _defesa_magica := 0,
    _bonus_vida := 20,
    _bonus_defesa := 5
);

CREATE OR REPLACE FUNCTION add_armadura_capacete(
    _nome_item VARCHAR(100),
    _descricao TEXT,
    _custo_item INT,
    _defesa INT,
    _defesa_magica INT,
    _bonus_vida INT
) RETURNS void AS $$
DECLARE
    _id_item INTEGER;
BEGIN 
    _id_item := create_item('ARMADURA');

    INSERT INTO ARMADURA (id_item,tipo_armadura)
    VALUES(_id_item,'CAPACETE');

    INSERT INTO CAPACETE(id_armadura,nome_item,descricao,custo_item,defesa,defesa_magica,bonus_vida)
    VALUES (_id_item,_nome_item,_descricao,_custo_item,_defesa,_defesa_magica,_bonus_vida);
END;
$$ LANGUAGE plpgsql;

SELECT add_armadura_capacete(
    _nome_item := 'Capacete de Couro',
    _descricao := 'Capacete feito de couro de animais silvestres comuns.',
    _custo_item := 100,
    _defesa := 3,
    _defesa_magica := 0,
    _bonus_vida := 10
);

CREATE OR REPLACE FUNCTION add_armadura_acessorio(
    _nome_item TEXT,
    _descricao TEXT,
    _custo_item INT,
    _defesa INT,
    _defesa_magica INT,
    _bonus_vida INT ,
    _bonus_esquiva INT ,
    _bonus_mana INT 
) RETURNS void AS $$
DECLARE
    _id_item INTEGER;
BEGIN
    _id_item := create_item('ARMADURA');

    INSERT INTO ARMADURA (id_item,tipo_armadura)
    VALUES(_id_item,'ACESSORIO');
    
    INSERT INTO ACESSORIO (id_armadura,nome_item,descricao,custo_item,defesa,defesa_magica,bonus_vida,bonus_esquiva,bonus_mana)
    VALUES(_id_item,_nome_item,_descricao,_custo_item,_defesa,_defesa_magica,_bonus_vida,_bonus_esquiva,_bonus_mana);
END;
$$ LANGUAGE plpgsql;

SELECT add_armadura_acessorio(
    _nome_item := 'Broche das Asas da Luz',
    _descricao := 'Broche decorado com plumas brancas.',
    _custo_item := 0,
    _defesa := 0,
    _defesa_magica := 0,
    _bonus_vida := 0,
    _bonus_esquiva := 20,
    _bonus_mana := 10
    );

CREATE OR REPLACE FUNCTION add_armadura_bota(
    _nome_item TEXT,
    _descricao TEXT,
    _custo_item INT,
    _defesa INT,
    _defesa_magica INT,
    _bonus_velocidade INT
) RETURNS void AS $$
DECLARE
    _id_item INTEGER;
BEGIN
    _id_item := create_item('ARMADURA');

    INSERT INTO ARMADURA (id_item, tipo_armadura)
    VALUES (_id_item, 'BOTA');

    INSERT INTO BOTA (
        id_armadura, nome_item, descricao, custo_item,
        defesa, defesa_magica, bonus_velocidade
    ) VALUES (
        _id_item, _nome_item, _descricao, _custo_item,
        _defesa, _defesa_magica, _bonus_velocidade
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION add_armadura_capa(
    _nome_item TEXT,
    _descricao TEXT,
    _custo_item INT,
    _defesa INT,
    _defesa_magica INT,
    _bonus_critico INT,
    _bonus_vida INT
) RETURNS void AS $$
DECLARE
    _id_item INTEGER;
BEGIN
    _id_item := create_item('ARMADURA');

    INSERT INTO ARMADURA (id_item, tipo_armadura)
    VALUES (_id_item, 'CAPA');

    INSERT INTO CAPA (
        id_armadura, nome_item, descricao, custo_item,
        defesa, defesa_magica, bonus_critico, bonus_vida
    ) VALUES (
        _id_item, _nome_item, _descricao, _custo_item,
        _defesa, _defesa_magica, _bonus_critico, _bonus_vida
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION add_armadura_escudo(
    _nome_item TEXT,
    _descricao TEXT,
    _custo_item INT,
    _defesa INT,
    _defesa_magica INT,
    _bonus_vida INT,
    _bonus_defesa INT
) RETURNS void AS $$
DECLARE
    _id_item INTEGER;
BEGIN
    _id_item := create_item('ARMADURA');

    INSERT INTO ARMADURA (id_item, tipo_armadura)
    VALUES (_id_item, 'ESCUDO');

    INSERT INTO ESCUDO (
        id_armadura, nome_item, descricao, custo_item,
        defesa, defesa_magica, bonus_vida, bonus_defesa
    ) VALUES (
        _id_item, _nome_item, _descricao, _custo_item,
        _defesa, _defesa_magica, _bonus_vida, _bonus_defesa
    );
END;
$$ LANGUAGE plpgsql;

SELECT add_armadura_bota(
    _nome_item := 'Grevas de Aço',
    _descricao := 'Pesadas grevas feitas de aço reforçado. Muito usadas pelos Cavaleiros Reais.',
    _custo_item := 850,
    _defesa := 12,
    _defesa_magica := 3,
    _bonus_velocidade := 5
);

SELECT add_armadura_bota(
    _nome_item := 'Botas de Couro',
    _descricao := 'Botas simples feitas de couro curtido. Leves e confortáveis.',
    _custo_item := 120,
    _defesa := 3,
    _defesa_magica := 0,
    _bonus_velocidade := 2
);


SELECT add_armadura_capa(
    _nome_item := 'Manto da Tempestade',
    _descricao := 'Capa encantada com vento místico. Aumenta a chance de crítico e a resistência mágica.',
    _custo_item := 1300,
    _defesa := 10,
    _defesa_magica := 6,
    _bonus_critico := 15,
    _bonus_vida := 100
);

SELECT add_armadura_capa(
    _nome_item := 'Capa Esfarrapada',
    _descricao := 'Uma capa antiga e desgastada. Ainda protege um pouco contra o frio e arranhões.',
    _custo_item := 90,
    _defesa := 2,
    _defesa_magica := 0,
    _bonus_critico := 0,
    _bonus_vida := 10
);


SELECT add_armadura_escudo(
    _nome_item := 'Escudo Sagrado de Valkyrie',
    _descricao := 'Escudo antigo imbuído com bênçãos divinas das Valquírias. Brilha com luz própria.',
    _custo_item := 2000,
    _defesa := 25,
    _defesa_magica := 15,
    _bonus_vida := 200,
    _bonus_defesa := 30
);

SELECT add_armadura_escudo(
    _nome_item := 'Tampa de Barril',
    _descricao := 'Uma tampa de barril reutilizada como escudo improvisado. Ajuda mais do que parece.',
    _custo_item := 150,
    _defesa := 4,
    _defesa_magica := 0,
    _bonus_vida := 20,
    _bonus_defesa := 5
);


CREATE OR REPLACE FUNCTION add_consumivel_pocao(
    _nome_item TEXT,
    _descricao TEXT,
    _custo_item INT,
    _tipo_bonus_atributo TEXT,
    _recupera_vida INT,
    _recupera_mana INT
) RETURNS INTEGER AS $$
DECLARE
    _id_item INTEGER;
BEGIN
    _id_item := create_item('CONSUMIVEL');

    INSERT INTO CONSUMIVEL(id_item, tipo_consumivel)
    VALUES (_id_item, 'POCAO');

    INSERT INTO POCAO(id_consumivel, tipo_bonus_atributo, recupera_vida, recupera_mana, nome_item, descricao, custo_item)
    VALUES (_id_item, _tipo_bonus_atributo, _recupera_vida, _recupera_mana, _nome_item, _descricao, _custo_item);

    RETURN _id_item;
END;
$$ LANGUAGE plpgsql;



SELECT add_consumivel_pocao('Poção Pequena de Vida', 'Recupera uma pequena quantidade de HP.', 30, 'VIDA', 50, 0);
SELECT add_consumivel_pocao('Poção Pequena de Mana', 'Recupera uma pequena quantidade de MP.', 35, 'MANA', 0, 40);

SELECT add_consumivel_pocao('Poção de Vida Média', 'Restaura uma boa quantidade de vida.', 120, 'VIDA', 150, 0);
SELECT add_consumivel_pocao('Poção de Mana Média', 'Recupera uma quantidade razoável de mana.', 130, 'MANA', 0, 120);

SELECT add_consumivel_pocao('Poção Suprema de Vida', 'Regenera quase toda a vida.', 300, 'VIDA', 400, 0);
SELECT add_consumivel_pocao('Poção Suprema de Mana', 'Regenera quase toda a mana.', 320, 'MANA', 0, 400);


CREATE OR REPLACE FUNCTION add_consumivel_pergaminho(
    _nome_item TEXT,
    _descricao TEXT,
    _custo_item INT,
    _tipo_buff TEXT,
    _duracao_buff INT
) RETURNS INTEGER AS $$
DECLARE
    _id_item INTEGER;
BEGIN
    _id_item := create_item('CONSUMIVEL');

    INSERT INTO CONSUMIVEL(id_item, tipo_consumivel)
    VALUES (_id_item, 'PERGAMINHO');

    INSERT INTO PERGAMINHO(id_consumivel, tipo_buff, duracao_buff, nome_item, descricao, custo_item)
    VALUES (_id_item, _tipo_buff, _duracao_buff, _nome_item, _descricao, _custo_item);

    RETURN _id_item;
END;
$$ LANGUAGE plpgsql;

SELECT add_consumivel_pergaminho('Pergaminho de Fogo I', 'Encanta ataques com dano de fogo.', 50, 'FOGO', 3);
SELECT add_consumivel_pergaminho('Pergaminho de Precisão I', 'Aumenta a chance de acerto.', 40, 'PRECISÃO', 2);

SELECT add_consumivel_pergaminho('Pergaminho de Fogo II', 'Forte encantamento de fogo.', 120, 'FOGO', 5);
SELECT add_consumivel_pergaminho('Pergaminho de Defesa II', 'Aumenta a defesa mágica.', 110, 'DEFESA_MAGICA', 5);

SELECT add_consumivel_pergaminho('Pergaminho de Explosão', 'Concede ataque de fogo devastador.', 250, 'EXPLOSAO_DE_FOGO', 1);
SELECT add_consumivel_pergaminho('Pergaminho de Reflexão', 'Reflete parte do dano recebido.', 240, 'REFLEXAO', 3);


CREATE OR REPLACE FUNCTION add_consumivel_comida(
    _nome_item TEXT,
    _descricao TEXT,
    _custo_item INT,
    _tipo_bonus_atributo TEXT,
    _bonus_atributo INT,
    _bonus_duracao INT
) RETURNS INTEGER AS $$
DECLARE
    _id_item INTEGER;
BEGIN
    _id_item := create_item('CONSUMIVEL');

    INSERT INTO CONSUMIVEL(id_item, tipo_consumivel)
    VALUES (_id_item, 'COMIDA');

    INSERT INTO COMIDA(id_consumivel, tipo_bonus_atributo, bonus_atributo, bonus_atributo_duracao, nome_item, descricao, custo_item)
    VALUES (_id_item, _tipo_bonus_atributo, _bonus_atributo, _bonus_duracao, _nome_item, _descricao, _custo_item);

    RETURN _id_item;
END;
$$ LANGUAGE plpgsql;

SELECT add_consumivel_comida('Maçã Suculenta', 'Aumenta temporariamente a sorte.', 20, 'SORTE', 2, 5);
SELECT add_consumivel_comida('Frango Assado', 'Aumenta temporariamente a força.', 25, 'FORCA', 3, 5);

SELECT add_consumivel_comida('Estufado de Coelho', 'Melhora destreza e precisão.', 100, 'DESTREZA', 5, 10);
SELECT add_consumivel_comida('Ensopado Místico', 'Melhora inteligência.', 110, 'INTELIGENCIA', 6, 10);

SELECT add_consumivel_comida('Banquete Real', 'Aumenta múltiplos atributos.', 220, 'FORCA', 10, 15);
SELECT add_consumivel_comida('Sopa da Deusa', 'Dá poder mágico incomparável.', 250, 'INTELIGENCIA', 12, 20);


CREATE OR REPLACE FUNCTION add_arma_corpo_a_corpo(
    _nome_item TEXT,
    _descricao TEXT,
    _custo_item INT,
    _dano_base INT,
    _bonus_dano INT
) RETURNS INTEGER AS $$
DECLARE
    _id_item INTEGER;
BEGIN
    _id_item := create_item('ARMA');

    INSERT INTO ARMA(id_item, tipo_arma, dano_base, bonus_dano, descricao, nome_item, custo_item)
    VALUES (_id_item, 'CORPO_A_CORPO', _dano_base, _bonus_dano, _descricao, _nome_item, _custo_item);

    RETURN _id_item;
END;
$$ LANGUAGE plpgsql;

SELECT add_arma_corpo_a_corpo('Espada de Madeira', 'Espada simples para treinamento.', 50, 8, 1);
SELECT add_arma_corpo_a_corpo('Adaga Enferrujada', 'Adaga velha, mas ainda afiada.', 60, 10, 2);

SELECT add_arma_corpo_a_corpo('Espada de Aço', 'Espada padrão dos soldados.', 200, 20, 5);
SELECT add_arma_corpo_a_corpo('Lança de Caça', 'Boa contra monstros grandes.', 220, 22, 4);

SELECT add_arma_corpo_a_corpo('Espada de Dragão', 'Feita com presas de dragão.', 600, 40, 10);
SELECT add_arma_corpo_a_corpo('Lâmina Sangrenta', 'Suga vida dos inimigos.', 700, 38, 15);


CREATE OR REPLACE FUNCTION add_arma_magica(
    _nome_item TEXT,
    _descricao TEXT,
    _custo_item INT,
    _dano_base INT,
    _bonus_dano INT,
    _tipo_magia TEXT,
    _efeito_magico TEXT
) RETURNS INTEGER AS $$
DECLARE
    _id_item INTEGER;
BEGIN
    _id_item := create_item('ARMA');

    INSERT INTO ARMA(id_item, tipo_arma, dano_base, bonus_dano, descricao, nome_item, custo_item)
    VALUES (_id_item, 'MAGICA', _dano_base, _bonus_dano, _descricao, _nome_item, _custo_item);

    INSERT INTO MAGICA(id_arma, tipo_magia, efeito_magico, descricao, nome_item, custo_item, dano_base, bonus_dano)
    VALUES (_id_item, _tipo_magia, _efeito_magico, _descricao, _nome_item, _custo_item, _dano_base, _bonus_dano);

    RETURN _id_item;
END;
$$ LANGUAGE plpgsql;

-- Iniciante
SELECT add_arma_magica('Cajado de Aprendiz', 'Cajado básico de mago.', 80, 10, 3, 'ELEMENTAL', 'FOGO');
SELECT add_arma_magica('Varinha Curta', 'Usada por aprendizes.', 90, 12, 2, 'ELEMENTAL', 'GELO');

-- Intermediário
SELECT add_arma_magica('Cajado Místico', 'Conduz magia poderosa.', 250, 25, 6, 'ARCANO', 'ELETRICO');
SELECT add_arma_magica('Cajado de Gelo', 'Especializado em congelar.', 270, 26, 5, 'ELEMENTAL', 'GELO');

-- Avançado
SELECT add_arma_magica('Cajado das Estrelas', 'Contém poder celestial.', 700, 45, 15, 'COSMICO', 'LUZ');
SELECT add_arma_magica('Cetro da Tempestade', 'Canaliza raios mortais.', 750, 48, 18, 'TEMPESTADE', 'RAIO');


CREATE OR REPLACE FUNCTION add_arma_longo_alcance(
    _nome_item TEXT,
    _descricao TEXT,
    _custo_item INT,
    _dano_base INT,
    _bonus_dano INT,
    _tipo_projetil TEXT,
    _quantidade_projetil INT
) RETURNS INTEGER AS $$
DECLARE
    _id_item INTEGER;
BEGIN
    _id_item := create_item('ARMA');

    INSERT INTO ARMA(id_item, tipo_arma, dano_base, bonus_dano, descricao, nome_item, custo_item)
    VALUES (_id_item, 'LONGO_ALCANCE', _dano_base, _bonus_dano, _descricao, _nome_item, _custo_item);

    INSERT INTO LONGO_ALCANCE(id_arma, tipo_projetil, quantidade_projetil, descricao, nome_item, dano_base, bonus_dano, custo_item)
    VALUES (_id_item, _tipo_projetil, _quantidade_projetil, _descricao, _nome_item, _dano_base, _bonus_dano, _custo_item);

    RETURN _id_item;
END;
$$ LANGUAGE plpgsql;

SELECT add_arma_longo_alcance('Arco Curto', 'Ideal para iniciantes.', 90, 12, 4, 'FLECHA', 20);
SELECT add_arma_longo_alcance('Estilingue', 'Improvisado, mas eficaz.', 60, 8, 2, 'PEDRA', 30);

SELECT add_arma_longo_alcance('Arco Recurvo', 'Mais precisão e alcance.', 180, 22, 6, 'FLECHA', 30);
SELECT add_arma_longo_alcance('Bestinha de Mão', 'Disparo rápido e compacto.', 200, 24, 7, 'VIROTE', 25);

SELECT add_arma_longo_alcance('Arco de Elvenor', 'Criado por elfos lendários.', 600, 38, 12, 'FLECHA_MAGICA', 40);
SELECT add_arma_longo_alcance('Arbaleste Real', 'Potente besta real.', 650, 42, 10, 'VIROTE_PESADO', 35);

CREATE OR REPLACE FUNCTION add_npc_combatente(
    _id_sala INT,
    _nome VARCHAR(20),
    _descricao TEXT,
    _dialogo TEXT,
    _tamanho VARCHAR(15),
    _raca VARCHAR(15),
    _desc_combatente TEXT,
    _vida INT,
    _ataque INT,
    _defesa INT,
    _defesa_magica INT,
    _nivel INT,
    _precisao INT,
    _esquiva INT,
    _status_npc VARCHAR(15) DEFAULT 'VIVO',
    _agressivo BOOLEAN DEFAULT TRUE
) RETURNS INTEGER AS $$
DECLARE
    _id_npc INTEGER;
BEGIN
    -- 1. Insere o NPC base
    INSERT INTO NPC(id_sala, nome, descricao, dialogo)
    VALUES (_id_sala, _nome, _descricao, _dialogo)
    RETURNING id_npc INTO _id_npc;

    -- 2. Insere como NPC_COMBATENTE
    INSERT INTO NPC_COMBATENTE (
        id_npc_combatente, tamanho, vida, raca, descricao,
        ataque, defesa, defesa_magica, nivel, precisao, esquiva
    ) VALUES (
        _id_npc, _tamanho, _vida, _raca, _desc_combatente,
        _ataque, _defesa, _defesa_magica, _nivel, _precisao, _esquiva
    );

    -- 3. Cria instância com vida_atual igual à vida base
    INSERT INTO INSTANCIA_NPC_COMBATENTE(
        id_npc_combatente, vida_atual, status_npc, agressivo
    ) VALUES (
        _id_npc, _vida, _status_npc, _agressivo
    );

    RETURN _id_npc;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION add_instancia_npc_combatente(
    _id_npc_combatente INT,
    _vida_atual INT DEFAULT 100,
    _status_npc VARCHAR(15) DEFAULT 'VIVO',
    _agressivo BOOLEAN DEFAULT TRUE
) RETURNS INTEGER AS $$
DECLARE
    _id_instancia INTEGER;
BEGIN
    INSERT INTO INSTANCIA_NPC_COMBATENTE(
        id_npc_combatente,
        vida_atual,
        status_npc,
        agressivo
    ) VALUES (
        _id_npc_combatente,
        _vida_atual,
        _status_npc,
        _agressivo
    )
    RETURNING id_instancia INTO _id_instancia;

    RETURN _id_instancia;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION add_instancia_npc_combatente(
    _id_npc_combatente INT,
    _vida_atual INT DEFAULT NULL,
    _status_npc VARCHAR(15) DEFAULT 'VIVO',
    _agressivo BOOLEAN DEFAULT TRUE
) RETURNS INTEGER AS $$
DECLARE
    _id_instancia INTEGER;
    _vida_base INT;
BEGIN
    SELECT vida INTO _vida_base
    FROM NPC_COMBATENTE
    WHERE id_npc_combatente = _id_npc_combatente;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'NPC_COMBATENTE com id % não encontrado.', _id_npc_combatente;
    END IF;

    IF _vida_atual IS NULL THEN
        _vida_atual := _vida_base;
    END IF;

    INSERT INTO INSTANCIA_NPC_COMBATENTE (
        id_npc_combatente,
        vida_atual,
        status_npc,
        agressivo
    ) VALUES (
        _id_npc_combatente,
        _vida_atual,
        _status_npc,
        _agressivo
    ) RETURNING id_instancia INTO _id_instancia;

    RETURN _id_instancia;
END;
$$ LANGUAGE plpgsql;



-- comprar_item
CREATE OR REPLACE FUNCTION comprar_item(
    _id_personagem INT,
    _id_item INT,
    _id_npc_vendedor INT
) RETURNS TEXT AS $$
DECLARE
    _preco INT;
    _id_inventario INT;
    _id_estoque INT;
    _dinheiro_atual INT;
BEGIN
    SELECT id_estoque INTO _id_estoque
    FROM NPC_VENDEDOR
    WHERE id_npc_vendedor = _id_npc_vendedor;

    IF NOT FOUND THEN
        RETURN 'NPC vendedor inválido.';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM VENDE_ESTOQUE_ITEM
        WHERE id_estoque = _id_estoque AND id_item = _id_item
    ) THEN
        RETURN 'Este NPC não vende esse item.';
    END IF;

    SELECT COALESCE(
        (SELECT custo_item FROM ARMA WHERE id_item = _id_item),
        (SELECT custo_item FROM POCAO WHERE id_consumivel = _id_item),
        (SELECT custo_item FROM PERGAMINHO WHERE id_consumivel = _id_item),
        (SELECT custo_item FROM COMIDA WHERE id_consumivel = _id_item),
        (SELECT custo_item FROM CAPACETE WHERE id_armadura = _id_item),
        (SELECT custo_item FROM BOTA WHERE id_armadura = _id_item),
        (SELECT custo_item FROM ACESSORIO WHERE id_armadura = _id_item),
        (SELECT custo_item FROM CAPA WHERE id_armadura = _id_item),
        (SELECT custo_item FROM ESCUDO WHERE id_armadura = _id_item),
        (SELECT custo_item FROM PEITORAL WHERE id_armadura = _id_item),
        0
    ) INTO _preco;

    IF _preco IS NULL THEN
        RETURN 'Não foi possível determinar o preço do item.';
    END IF;

    SELECT dinheiro INTO _dinheiro_atual
    FROM PERSONAGEM
    WHERE id_personagem = _id_personagem;

    IF _dinheiro_atual < _preco THEN
        RETURN 'Dinheiro insuficiente.';
    END IF;

    SELECT id_inventario INTO _id_inventario
    FROM INVENTARIO
    WHERE id_personagem = _id_personagem;

    INSERT INTO INSTANCIA_ITEM (id_item, id_inventario)
    VALUES (_id_item, _id_inventario);

    UPDATE PERSONAGEM
    SET dinheiro = dinheiro - _preco
    WHERE id_personagem = _id_personagem;

    RETURN 'Compra realizada com sucesso!';
END;
$$ LANGUAGE plpgsql;
