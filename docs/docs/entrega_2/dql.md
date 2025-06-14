---

---

# DQL - Data Query Language

A DQL, Data Query Language, é uma das partes da SQL voltada especificamente para a consulta de dados. Seu papel é ajudar na leitura das informações que já estão guardadas no banco de dados. O comando mais utilizado nesse contexto é o SELECT, que serve para extrair dados de tabelas conforme os filtros aplicados. Ele pode ser combinado com outras cláusulas, como WHERE, ORDER BY e GROUP BY, para refinar ainda mais os resultados obtidos.

## Consultas de tabelas

### Listar todas as salas e descrições

```sql
SELECT S.nome_sala, S.descricao_sala 
FROM SALA S 
ORDER BY S.nome_sala;
```

### Selecionar todos personagens que pertencem a um jogador

```sql
SELECT P.nome FROM PERSONAGEM P 
INNER JOIN JOGADOR J ON P.id_jogador = J.id_jogador
WHERE J.id_jogador = $(id_jogador); -- Exemplo: Jogador de ID = 2
```

- Exibe os personagens pertencentes ao jogador com o ID fornecido.

### Listar as habilidades que o personagem possui 

```sql
SELECT H.nome_habilidade from HABILIDADE H
INNER JOIN CLASSE C on H.id_classe = C.id_classe 
INNER JOIN pertence_PERSONAGEM_CLASSE PC on PC.id_classe = C.id_classe
INNER JOIN PERSONAGEM P on PC.id_personagem  = P.id_personagem
WHERE H.nivel_requerido <= P.nivel AND P.id_personagem = ${id_personagem}; -- Exemplo: Personagem de ID = 3
```

- Exibe as habilidades do personagem com o ID fornecido.

### Ver para quais salas o personagem pode ir

```sql
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
```
- Adicionando o código abaixo, exibe as salas possíveis que um personagem com o ID fornecido pode ir:

    ```sql
    WHERE P.id_personagem = $(id_personagem); -- Exemplo: Personagem de ID = 4
    ```

### Mostrar o objetivo da missão atual do personagem

```sql
SELECT M.objetivo FROM MISSAO M
INNER JOIN PERSONAGEM P ON P.id_missao  = M.id_missao 
WHERE P.id_personagem = $(id_personagem) -- Exemplo: Personagem de ID = 5
```
- Exibe o objetivo da missão atual do personagem com o ID fornecido.
- Lembrando que: um personagem só pode ter uma missão por vez

### Mostrar qual NPC dá uma missão específica

```sql
SELECT NPC.nome FROM NPC
INNER JOIN MISSAO M ON M.id_npc = NPC.id_npc
WHERE M.id_missao = $(id_missao) -- Exemplo: Missão de ID = 6
```

- Exibe o nome do NPC que dá a missão com o ID fornecido.

### Ver a descrição completa de uma missão

```sql
SELECT M.descricao AS "Descrição", M.objetivo AS "Objetivo da Missão", NPC.nome AS "Requisitante" FROM MISSAO m
INNER JOIN NPC ON NPC.id_npc = M.id_npc
INNER JOIN PERSONAGEM P ON P.id_missao = M.id_missao 
WHERE P.id_personagem = $(id_personagem) -- Exemplo: Personagem de ID = 7
```

- Exibe a descrição, objetivo e nome do NPC requisitante da missão de um jogador com o ID fornecido.

### Listar os jogadores cadastrados

```sql
SELECT id_jogador, usuario, email FROM JOGADOR ORDER BY id_jogador;
```

- Exibe os dados (id, usuário e e-mail) de todos os jogadores cadastrados no sistema.

### Listar NPCs em uma sala

```sql
SELECT N.id_npc, N.nome, N.descricao 
FROM NPC N 
WHERE N.id_sala = $(id_sala) -- Exemplo: Sala de ID = 8
ORDER BY N.nome;
```

- Mostra o id, nome e descrição de todos os NPCs em uma sala com o ID fornecido.

### Detectar inimigos vivos na sala atual do personagem 

```sql
SELECT N.id_npc, N.nome, NC.ataque, NC.defesa, NC.hp 
FROM PERSONAGEM P JOIN SALA S ON S.id_sala = P.id_sala 
JOIN NPC N ON N.id_sala = S.id_sala 
JOIN NPC_COMBATENTE NC ON NC.id_npc_combatente = N.id_npc 
WHERE P.id_personagem = $(id_personagem) AND NC.hp > 0 -- Exemplo: Personagem de ID = 9
ORDER BY NC.ataque DESC;
```

- Mostra o nome e os atributos de combate dos NPCs combatentes vivos na sala em que o personagem com o ID fornecido está.

### Ver o catálogo de um NPC vendedor 

```sql
SELECT NV.id_npc_vendedor, I.id_item, I.nome, I.tipo, I.custo 
FROM NPC_VENDEDOR NV 
JOIN VENDE_ESTOQUE_ITEM VEI ON VEI.id_estoque = NV.id_estoque 
JOIN ITEM I ON I.id_item = VEI.id_item 
WHERE NV.id_npc_vendedor = $(id_npc_vendedor) -- Exemplo: NPC vendedor de ID = 10
ORDER BY I.nome;
```

- Exibe os itens que um NPC vendedor com o ID fornecido oferece.

### Listar salas com maior concentração de NPCs combatentes

```sql
SELECT S.id_sala, S.nome_sala, COUNT(NC.id_npc_combatente) AS total_combatentes 
FROM SALA S 
LEFT JOIN NPC N ON N.id_sala = S.id_sala 
LEFT JOIN NPC_COMBATENTE NC ON NC.id_npc_combatente = N.id_npc 
GROUP BY S.id_sala, S.nome_sala 
ORDER BY total_combatentes DESC;
```

- Exibe as salas com maior quantidade de NPCs combatentes.

### Listar os 5 NPCs combatentes mais perigosos 

```sql
SELECT NC.id_npc_combatente, N.nome, (NC.ataque + NC.defesa) AS poder_total, NC.hp 
FROM NPC_COMBATENTE NC 
JOIN NPC N ON N.id_npc = NC.id_npc_combatente 
ORDER BY poder_total DESC, NC.hp DESC LIMIT 5;
```

- Exibe os dados de 5 NPCs combatentes ordenados com base no maior ataque e defesa.

### Listar as missões oferecidas por um NPC

```sql
SELECT M.id_missao, M.descricao, M.objetivo, M.xp_base, M.dinheiro 
FROM MISSAO M 
WHERE M.id_npc = $(id_npc) -- Exemplo: NPC de ID = 11
ORDER BY M.requisito_level;
```

- Lista todas as missões oferecidas por um NPC com o ID fornecido.

### Listar as missões disponíveis na sala do personagem e adequadas ao nível

```sql
SELECT M.id_missao, M.objetivo, M.xp_base, M.dinheiro 
FROM PERSONAGEM P 
JOIN NPC N ON N.id_sala = P.id_sala 
JOIN MISSAO M ON M.id_npc = N.id_npc 
WHERE P.id_personagem = $(id_personagem) AND M.requisito_level <= P.nivel; -- Exemplo: Personagem de ID = 12
```

- Exibe as missões disponíveis e elegíveis na sala do personagem com o ID fornecido.

### Listar as missões elegíveis para o personagem 

```sql
SELECT M.id_missao, M.descricao, M.objetivo, M.xp_base, M.dinheiro 
FROM MISSAO M, PERSONAGEM P
WHERE
    P.id_personagem = $(id_personagem) AND M.requisito_level <= P.nivel AND (P.id_missao IS NULL OR P.id_missao <> M.id_missao) -- Exemplo: Personagem de ID = 13
ORDER BY M.requisito_level DESC, M.xp_base DESC;
```

- Exibe as missões elegíveis de acordo com o nível do personagem com o ID fornecido.

### Listar o inventário completo do personagem  

```sql
SELECT II.id_instancia_item, I.nome, I.tipo, I.descricao 
FROM INVENTARIO INV 
JOIN INSTANCIA_ITEM II ON II.id_inventario = INV.id_inventario 
JOIN ITEM I ON I.id_item = II.id_item 
WHERE INV.id_personagem = $(id_personagem) -- Exemplo: Personagem de ID = 14
ORDER BY I.nome;
```

- Exibe o inventário, com itens ordenados por nome, de um personagem com o ID fornecido.

### Listar itens duplicados no inventário de um personagem (empilháveis ou repetidos)

```sql
SELECT IT.nome, COUNT(*) AS quantidade 
FROM INVENTARIO INV 
JOIN INSTANCIA_ITEM II ON II.id_inventario = INV.id_inventario 
JOIN ITEM IT ON IT.id_item = II.id_item 
WHERE INV.id_personagem = $(id_personagem) -- Exemplo: Personagem de ID = 15
GROUP BY IT.nome HAVING COUNT(*) > 1 ORDER BY quantidade DESC;
```

- Exibe e agrupa itens com o mesmo nome.

### Listar habilidades que o personagem poderá aprender no próximo nível (considera a(s) classe(s) atual(is))

```sql
SELECT H.id_habilidade, H.nome_habilidade, H.nivel_requerido 
FROM PERTENCE_PERSONAGEM_CLASSE PC 
JOIN HABILIDADE h ON H.id_classe = PC.id_classe 
JOIN PERSONAGEM p ON P.id_personagem = PC.id_personagem 
WHERE PC.id_personagem = $(id_personagem) AND H.nivel_requerido = P.nivel + 1 -- Exemplo: Personagem de ID = 16
ORDER BY H.nome_habilidade;
```

- Exibe as habilidades possíveis de serem aprendidas de um personagem com um ID fornceido.

### Mostrar itens “no chão” de uma sala (instâncias sem inventário)

```sql
SELECT II.id_instancia_item, IT.nome, IT.tipo, IT.descricao 
FROM INSTANCIA_ITEM II 
JOIN ITEM IT ON IT.id_item = II.id_item 
WHERE II.id_sala = $(id_sala) AND II.id_inventario IS NULL ORDER BY it.nome; -- Exemplo: Sala de ID = 17
```

- Exibe os itens que estão no chão de uma sala com ID fornecido.

## Histórico de Versão

|  Versão  |     Data     | Descrição | Autor(es) | Revisor(es) |
| :------: | :----------: | :-----------: | :---------: | :---------: |
| `1.0` | 12/06/2025 | Criação do documento e primeira versão do DQL | [Ian Costa](https://github.com/iancostag), [Cauã Araujo](https://github.com/caua08) | [Danilo Naves](https://github.com/DaniloNavesS) |
| `1.1` | 13/06/2025 | Ajustes de formatação markdown e correção de código | [Amanda Cruz](https://github.com/mandicrz), [Felipe Motta](https://github.com/M0tt1nh4) | [Ian Costa](https://github.com/iancostag) |


