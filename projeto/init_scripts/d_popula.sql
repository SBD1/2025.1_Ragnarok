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

INSERT INTO NPC (id_sala, nome, descricao, dialogo) VALUES
(1, 'Aldeão', 'Um simples morador da cidade', 'Bem-vindo a nossa cidade, aventureiro! Cuidado com os lobos na floresta.'),
(1, 'Ferreiro', 'Um robusto ferreiro da cidade', 'Precisa de equipamentos? Tenho os melhores da região!'),
(6, 'Velho Sábio', 'Um ancião cheio de conhecimento', 'Dizem que há um tesouro escondido nas profundezas desta caverna...'),
(7, 'Mago Arcanjo', 'Um poderoso mago', 'Interessado em aprender magias poderosas?');

-- 7. Inserindo Estoques
INSERT INTO ESTOQUE (id_estoque) VALUES (1), (2);

INSERT INTO NPC_VENDEDOR (id_npc_vendedor, id_estoque) VALUES
(2, 1),  -- Ferreiro
(4, 2);  -- Mago Arcanjo

-- 9. Associando itens aos estoques
INSERT INTO VENDE_ESTOQUE_ITEM (id_estoque, id_item) VALUES
(1, 29),
(1, 30),
(2, 6),
(2, 35),
(2, 36),
(2, 11),
(2, 12);

-- 10. Inserindo Jogadores
INSERT INTO JOGADOR (usuario, email, senha) VALUES
('iancostag', 'iancostag@gmail.com', '123'),
('danilo', 'danilonaves@gmail.com', '456'),
('igris', 'richard@gmail.com', '789');

-- 11. Inserindo Missões
INSERT INTO MISSAO (id_npc, requisito_level, xp_base, xp_classe, descricao, objetivo, dinheiro) VALUES
(2, 1, 100, 50, 'Derrote 5 lobos na floresta', 'Matar 5 lobos', 50),
(3, 3, 200, 100, 'Encontre o tesouro perdido na caverna', 'Explorar a caverna', 100),
(4, 5, 300, 150, 'Aprenda uma magia avançada', 'Falar com o mago', 150);

-- 12. Inserindo Personagens
INSERT INTO PERSONAGEM (id_jogador, id_sala, id_missao, nome, mana, vida, vitalidade, inteligencia, agilidade, sorte, destreza, forca, ataque, ataque_magico, precisao, esquiva, defesa, defesa_magica, critico, velocidade, nivel, dinheiro) VALUES
(1, 1, 1, 'kamishiro', 50, 200, 10, 5, 8, 7, 9, 12, 20, 5, 70, 60, 15, 10, 10, 8, 1, 200),
(2, 1, NULL, 'Patolino, O Mago', 100, 150, 5, 15, 6, 8, 7, 10, 8, 25, 65, 50, 8, 20, 5, 6, 1, 150),
(3, 1, NULL, 'igris', 60, 180, 8, 7, 12, 10, 12, 8, 18, 8, 80, 70, 12, 12, 15, 10, 1, 180);

-- 13. Associando Classes aos Personagens
INSERT INTO PERTENCE_PERSONAGEM_CLASSE (id_personagem, id_classe) VALUES
(1, 3),
(2, 2),
(3, 1);

-- 14. Inserindo Instâncias de Itens nos Inventários
INSERT INTO INSTANCIA_ITEM (id_item, id_inventario) VALUES
(41, 1), -- kamishiro tem Arco Curto
(35, 2), -- Patolino tem Cajado do Aprendiz
(31, 3), -- Igris tem Espada de Ferro
(31, 3), -- Igris tem Espada de Ferro
(11, 3), -- Igris tem Poção de cura
(11, 3); -- Igris tem Poção de cura


--  Lobo 
DO $$
DECLARE
    _id_lobo INT;
BEGIN
    _id_lobo := add_npc_combatente(
        _id_sala := 5,
        _nome := 'Lobo',
        _descricao := 'Um lobo selvagem e agressivo',
        _dialogo := 'Grrrrrrr! rosna',
        _tamanho := 'Médio',
        _raca := 'Lobo',
        _desc_combatente := 'Lobo selvagem que ataca qualquer intruso',
        _vida := 100,
        _ataque := 17,
        _defesa := 3,
        _defesa_magica := 5,
        _nivel := 2,
        _precisao := 70,
        _esquiva := 60
    );
    PERFORM add_instancia_npc_combatente(_id_lobo);
    PERFORM add_instancia_npc_combatente(_id_lobo);
    PERFORM add_instancia_npc_combatente(_id_lobo);
    PERFORM add_instancia_npc_combatente(_id_lobo);
    PERFORM add_instancia_npc_combatente(_id_lobo);
END;
$$;

--  Poring 
DO $$
DECLARE
    _id_poring INT;
BEGIN
    _id_poring := add_npc_combatente(
        _id_sala := 1,
        _nome := 'Poring',
        _descricao := 'Uma geleia rosa saltitante e inofensiva.',
        _dialogo := 'Puuuu~',
        _tamanho := 'Pequeno',
        _raca := 'Slime',
        _desc_combatente := 'Criatura gelatinosa fraca, mas comum.',
        _vida := 40,
        _ataque := 5,
        _defesa := 1,                                   
        _defesa_magica := 2,
        _nivel := 1,
        _precisao := 40,
        _esquiva := 10
    );
    PERFORM add_instancia_npc_combatente(_id_poring);
    PERFORM add_instancia_npc_combatente(_id_poring);
    PERFORM add_instancia_npc_combatente(_id_poring);
    PERFORM add_instancia_npc_combatente(_id_poring);
    PERFORM add_instancia_npc_combatente(_id_poring);
END;
$$;

--  Lunático 
DO $$
DECLARE                                 
    _id_lunatico INT;
BEGIN
    _id_lunatico := add_npc_combatente(
        _id_sala := 1,
        _nome := 'Lunático',
        _descricao := 'Um coelho com olhos vermelhos e comportamento estranho.',
        _dialogo := 'Squeek!',
        _tamanho := 'Pequeno',
        _raca := 'Coelho',
        _desc_combatente := 'Coelho agressivo que vive nos campos.',
        _vida := 50,
        _ataque := 6,
        _defesa := 2,
        _defesa_magica := 1,
        _nivel := 1,
        _precisao := 45,
        _esquiva := 15
    );
    PERFORM add_instancia_npc_combatente(_id_lunatico);
    PERFORM add_instancia_npc_combatente(_id_lunatico);
    PERFORM add_instancia_npc_combatente(_id_lunatico);
END;
$$;

--  Fabre 
DO $$
DECLARE
    _id_fabre INT;
BEGIN
    _id_fabre := add_npc_combatente(
        _id_sala := 2,
        _nome := 'Fabre',
        _descricao := 'Uma larva de inseto com casco duro.',
        _dialogo := 'clack clack',
        _tamanho := 'Pequeno',
        _raca := 'Inseto',
        _desc_combatente := 'Inseto que ataca quem chega perto.',
        _vida := 60,
        _ataque := 7,
        _defesa := 3,
        _defesa_magica := 2,
        _nivel := 2,
        _precisao := 50,
        _esquiva := 10
    );
    PERFORM add_instancia_npc_combatente(_id_fabre);
    PERFORM add_instancia_npc_combatente(_id_fabre);
    PERFORM add_instancia_npc_combatente(_id_fabre);
END;
$$;

-- Aranha da Floresta 
DO $$
DECLARE
    _id_aranha INT;
BEGIN
    _id_aranha := add_npc_combatente(
        _id_sala := 6,
        _nome := 'Aranha da Floresta',
        _descricao := 'Uma aranha gigante que patrulha a floresta.',
        _dialogo := '*chiado sinistro*',
        _tamanho := 'Médio',
        _raca := 'Aracnídeo',
        _desc_combatente := 'Predador silencioso das árvores.',
        _vida := 120,
        _ataque := 18,
        _defesa := 6,
        _defesa_magica := 4,
        _nivel := 4,
        _precisao := 60,
        _esquiva := 20
    );
    PERFORM add_instancia_npc_combatente(_id_aranha);
    PERFORM add_instancia_npc_combatente(_id_aranha);
END;
$$;

--  Esqueleto de Payon 
DO $$
DECLARE
    _id_esqueleto INT;
BEGIN
    _id_esqueleto := add_npc_combatente(
        _id_sala := 7,
        _nome := 'Esqueleto de Payon',
        _descricao := 'Um guerreiro morto-vivo com espada enferrujada.',
        _dialogo := '... *ossos estalam* ...',
        _tamanho := 'Médio',
        _raca := 'Morto-vivo',
        _desc_combatente := 'Criatura ressuscitada por magia sombria.',
        _vida := 150,
        _ataque := 22,
        _defesa := 10,
        _defesa_magica := 8,
        _nivel := 5,
        _precisao := 70,
        _esquiva := 15
    );
    PERFORM add_instancia_npc_combatente(_id_esqueleto);
    PERFORM add_instancia_npc_combatente(_id_esqueleto);
END;
$$;
