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
(3, 'Médio', 'Lobo', 'Lobo selvagem que ataca qualquer intruso', 17, 3, 5, 2, 70, 60);

-- 6. Inserindo Instâncias de NPCs Combatentes
INSERT INTO INSTANCIA_NPC_COMBATENTE (id_npc_combatente, vida_atual, status_npc, agressivo) VALUES
(3, 30, 'VIVO', TRUE);

-- 7. Inserindo Estoque para vendedores
INSERT INTO ESTOQUE (id_estoque) VALUES (1), (2);

-- 8. Inserindo NPCs Vendedores
INSERT INTO NPC_VENDEDOR (id_npc_vendedor, id_estoque) VALUES
(2, 1),  -- Ferreiro
(5, 2);  -- Mago Arcanjo

-- Primeiro inserimos os itens básicos
INSERT INTO ITEM (tipo_item) VALUES 
('ARMA'),  -- id_item = 5 (Espada de Ferro)
('ARMA'),  -- id_item = 6 (Cajado do Aprendiz)
('ARMA'),  -- id_item = 7 (Arco Curto)
('CONSUMIVEL'),  -- id_item = 8 (Poção de Cura)
('CONSUMIVEL'),  -- id_item = 9 (Pergaminho de Fogo)
('CONSUMIVEL');  -- id_item = 10 (Garra de Lobo)

-- 11. Inserindo Armas 
INSERT INTO ARMA (id_item, tipo_arma, dano_base, bonus_dano, descricao, nome_item, custo_item) VALUES
(5, 'CORPO_A_CORPO', 15, 5, 'Uma espada básica de ferro', 'Espada de Ferro', 100),
(6, 'MAGICA', 10, 3, 'Cajado básico para magos iniciantes', 'Cajado do Aprendiz', 80),
(7, 'LONGO_ALCANCE', 12, 4, 'Arco simples para treinamento', 'Arco Curto', 90);

-- Detalhes das armas específicas
INSERT INTO LONGO_ALCANCE (id_arma, tipo_projetil, quantidade_projetil, descricao, nome_item, dano_base, bonus_dano, custo_item) VALUES
(7, 'FLECHA', 20, 'Arco simples para treinamento', 'Arco Curto', 12, 4, 90);

INSERT INTO MAGICA (id_arma, tipo_magia, efeito_magico, descricao, nome_item, custo_item, dano_base, bonus_dano) VALUES
(6, 'ELEMENTAL', 'FOGO', 'Cajado básico para magos iniciantes', 'Cajado do Aprendiz', 80, 10, 3);

-- 12. Inserindo Consumíveis
INSERT INTO CONSUMIVEL (id_item, tipo_consumivel) VALUES
(8, 'POCAO'),
(9, 'PERGAMINHO'),
(10, 'COMIDA');

-- Detalhes da Poção
INSERT INTO POCAO (id_consumivel, tipo_bonus_atributo, recupera_vida, recupera_mana, nome_item, descricao, custo_item) VALUES
(8, 'VIDA', 50, 0, 'Poção de Cura', 'Restaura 50 pontos de vida', 30);

-- Detalhes do Pergaminho
INSERT INTO PERGAMINHO (id_consumivel, tipo_buff, duracao_buff, nome_item, descricao, custo_item) VALUES
(9, 'ATAQUE DE FOGO', 3, 'Pergaminho de Fogo', 'Ataques causam dano adicional de fogo por 3 turnos', 50);

-- Detalhes da Comida
INSERT INTO COMIDA (id_consumivel, tipo_bonus_atributo, bonus_atributo, bonus_atributo_duracao, nome_item, descricao, custo_item) VALUES
(10, 'FORCA', 5, 10, 'Garra de Lobo', 'Aumenta força por 10 minutos', 15);

-- 13. Associando itens aos estoques dos vendedores
INSERT INTO VENDE_ESTOQUE_ITEM (id_estoque, id_item) VALUES
(1, 5), -- Ferreiro vende Espada de Ferro
(2, 6), -- Mago vende Cajado do Aprendiz
(2, 8), -- Mago vende Poção de Cura
(2, 9); -- Mago vende Pergaminho de Fogo

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
(2, 1, NULL, 'Patolino, O Mago', 100, 150, 5, 15, 6, 8, 7, 10, 8, 25, 65, 50, 8, 20, 5, 6, 1, 150),
(3, 1, NULL, 'igris', 60, 180, 8, 7, 12, 10, 12, 8, 18, 8, 80, 70, 12, 12, 15, 10, 1, 180);

-- 17. Associando classes aos personagens
INSERT INTO PERTENCE_PERSONAGEM_CLASSE (id_personagem, id_classe) VALUES
(1, 3), -- kamishiro é Arqueiro
(2, 2), -- Patolino é Mago
(3, 1); -- Igris é Espadachim

-- 19. Inserindo Instâncias de Itens nos Inventários
INSERT INTO INSTANCIA_ITEM (id_item, id_inventario) VALUES
(7, 1), -- kamishiro tem Arco Curto
(6, 2), -- Patolino tem Cajado do Aprendiz
(5, 3), -- Igris tem Espada de Ferro
(5, 3), -- Igris tem Espada de Ferro
(8, 3);