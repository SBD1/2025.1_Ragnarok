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
