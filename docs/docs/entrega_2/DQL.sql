-- Seleciona Todos Personagens que pertencem a um jogador
select p.nome from personagem p 
inner join jogador j on p.id_jogador = j.id_jogador;

-- Lista as Habilidades que um personagem possui, adicioanndo o WHERE id_personagem = x temos do personagem especifico
select H.nome_habilidade from habilidade H
inner join classe C on h.id_classe  C.id_classe 
inner join pertence_personagem_classe pc on pc.id_classe = c.id_classe
inner join personagem p on pc.id_personagem  = p.id_personagem
where h.nivel_requerido <= p.nivel;

-- lista para que salas um personagem pode ir, adicionando o WHERE obtemos pra onde um personagem especifico pode ir
SELECT 
    s.nome_sala AS sala_atual,
    sd.nome_sala AS sala_direita,
    sb.nome_sala AS sala_baixo,
    sc.nome_sala AS sala_cima,
    se.nome_sala AS sala_esquerda
FROM 
    sala s
INNER JOIN 
    personagem p ON p.id_sala = s.id_sala
LEFT JOIN 
    sala sd ON s.id_direita = sd.id_sala
LEFT JOIN 
    sala sb ON s.id_baixo = sb.id_sala
LEFT JOIN 
    sala sc ON s.id_cima = sc.id_sala
LEFT JOIN 
    sala se ON s.id_esquerda = se.id_sala;
-- WHERE id_personagem = :id_personagem especifico mostrar as opções

--Mostrar o objetivo da missão atual do personagem, lembrando que o personagem só pode ter uma missão
select m.objetivo from missao m
inner join personagem p on p.id_missao  = m.id_missao

--Mostrar que NPC dá a missão
select npc.nome from npc
inner join missao m on m.id_npc = npc.id_npc

--Mostrar para o jogador a descrição Completa da Missão
select m.descricao as "Descrição", m.objetivo as "Objetivo da Missão", npc.nome as "Requisitante"from Missao m
inner join npc on npc.id_npc = m.id_npc
inner join personagem p on p.id_missao  on m.m.id_missao 







