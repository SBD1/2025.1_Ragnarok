-- Seleciona Todos Personagens que pertencem a um jogador
select P.nome from PERSONAGEM P 
inner join JOGADOR J on P.id_jogador = J.id_jogador;

-- Lista as Habilidades que um personagem possui, adicioanndo o WHERE id_personagem = x temos do personagem especifico
select H.nome_habilidade from HABILIDADE H
inner join CLASSE C on H.id_classe  C.id_classe 
inner join pertence_PERSONAGEM_CLASSE PC on PC.id_classe = C.id_classe
inner join PERSONAGEM P on PC.id_personagem  = P.id_personagem
where H.nivel_requerido <= P.nivel;

-- lista para que salas um personagem pode ir, adicionando o WHERE obtemos pra onde um personagem especifico pode ir
SELECT 
    S.nome_sala AS sala_atual,
    SD.nome_sala AS sala_direita,
    SB.nome_sala AS sala_baixo,
    SC.nome_sala AS sala_cima,
    SE.nome_sala AS sala_esquerda
FROM 
    SALA S
INNER JOIN 
    PERSONAGEM P ON P.id_sala = S.id_sala
LEFT JOIN 
    SALA SD ON S.id_direita = SD.id_sala
LEFT JOIN 
    SALA SB ON S.id_baixo = SB.id_sala
LEFT JOIN 
    SALA SC ON S.id_cima = SC.id_sala
LEFT JOIN 
    SALA SE ON S.id_esquerda = SE.id_sala;
-- WHERE id_personagem = :id_personagem especifico mostrar as opções

--Mostrar o objetivo da missão atual do personagem, lembrando que o personagem só pode ter uma missão
SELECT M.objetivo FROM MISSAO M
INNER JOIN PERSONAGEM P ON P.id_missao  = M.id_missao

--Mostrar que NPC dá a missão
SELECT NPC_QUEST.nome FROM NPC_QUEST
INNER JOIN MISSAO M ON M.id_npc = NPC_QUEST.id_npc

--Mostrar para o jogador a descrição Completa da Missão
SELECT M.descricao AS "Descrição", M.objetivo AS "Objetivo da Missão", NPC.nome AS "Requisitante" FROM MISSAO m
INNER JOIN NPC ON NPC.id_npc = M.id_npc
INNER JOIN PERSONAGEM P ON P.id_missao = M.id_missao







