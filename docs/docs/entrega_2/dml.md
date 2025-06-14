---

---

# DML - Data Manipulation Language

DML (Data Manipulation Language) é um subconjunto da linguagem SQL utilizado para inserir, consultar, atualizar e excluir dados nas tabelas de um banco de dados relacional. Ao contrário dos comandos DDL, que modificam a estrutura do banco, os comandos DML atuam somente sobre os dados existentes.

Este DML serve apenas para podermos observar que o DDL está funcional, todas as tabelas se conectam como deveriam, por meio do DQL demonstraremos como as consultas deverão funcionar.

## Tabelas e Dados

### Tabela `CLASSE`

```sql
-- 1. Inserindo Classes
INSERT INTO public.classe (nome_classe, descricao) VALUES
('Guerreiro', 'Especialista em combate corpo a corpo com alta defesa'),
('Mago', 'Utiliza magias poderosas para atacar à distância'),
('Arqueiro', 'Especialista em ataques à distância com arcos');
```

### Tabela `HABILIDADE`

```sql
-- 2. Inserindo Habilidades
INSERT INTO public.habilidade (id_classe, nome_habilidade, descricao, custo_mana, dano, nivel_requerido) VALUES
(7, 'Espadada', 'Ataque básico com espada', 5, 15, 1),
(7, 'Golpe Fulminante', 'Ataque forte que causa dano adicional', 15, 30, 3),
(8, 'Lança de Fogo', 'Conjura lanças de fogo para queimar o inimigo', 20, 25, 1),
(8, 'Lança de Gelo', 'Invoca lanças de gelo que perfuram o inimigo', 35, 40, 5),
(9, 'Flecha Rápida', 'Dispara duas flechas com velocidade aumentada', 10, 20, 1),
(9, 'Chuva de Flechas', 'Dispara múltiplas flechas contra vários inimigos que estejam próximos', 25, 35, 4);
```

### Tabela `SALA`

```sql
-- 3. Inserindo Salas (criando um pequeno mapa)
-- Primeiro inserimos a sala inicial sem referências
INSERT INTO public.sala (nome_sala, descricao_sala) VALUES
('Praça Central de Prontera', 'Uma grande praça no centro da cidade, com muitos comerciantes e aventureiros');

-- Agora atualizamos a sala inicial para referenciar a si mesma (necessário para as constraints)
UPDATE public.sala SET id_direita = 1, id_esquerda = 1, id_baixo = 1, id_cima = 1 WHERE id_sala = 1;

-- Inserindo mais salas
INSERT INTO public.sala (nome_sala, descricao_sala, id_direita, id_esquerda, id_baixo, id_cima) VALUES
('Floresta dos Lobos', 'Uma densa floresta habitada por lobos selvagens', 1, 1, 1,1),
('Caverna do Tesouro', 'Uma caverna escura com lendas sobre tesouros escondidos', 1, 1, 1, 1),
('Torre do Mago', 'Uma alta torre onde um poderoso mago realiza seus experimentos', 1, 1, 1, 1);

-- Atualizando as referências da sala inicial para apontar para as outras salas
UPDATE public.sala SET 
    id_direita = 5, 
    id_esquerda = 6, 
    id_baixo = 7, 
    id_cima = 1 
WHERE id_sala = 1;
```

### Tabela `NPC`

```sql
-- 4. Inserindo NPCs
INSERT INTO public.npc (id_sala, nome, descricao, dialogo) VALUES
(1, 'Aldeão', 'Um simples morador da cidade', 'Bem-vindo a nossa cidade, aventureiro! Cuidado com os lobos na floresta.'),
(1, 'Ferreiro', 'Um robusto ferreiro da cidade', 'Precisa de equipamentos? Tenho os melhores da região!'),
(5, 'Lobo', 'Um lobo selvagem e agressivo', 'Grrrrrrr! rosna'),
(6, 'Velho Sábio', 'Um ancião cheio de conhecimento', 'Dizem que há um tesouro escondido nas profundezas desta caverna...'),
(7, 'Mago Arcanjo', 'Um poderoso mago', 'Interessado em aprender magias poderosas?');
```

### Tabela `NPC_COMBATENTE`

```sql
-- 5. Inserindo NPCs Combatentes
INSERT INTO public.npc_combatente (id_npc_combatente, tamanho, raca, descricao, ataque, defesa, defesa_magica, nivel, precisao, esquiva) VALUES
(3, 'Médio', 'Lobo', 'Lobo selvagem que ataca qualquer intruso', 20, 10, 5, 2, 70, 60);
```

### Tabela `ESTOQUE`

```sql
-- 6. Inserindo Estoque para vendedores
INSERT INTO public.estoque DEFAULT VALUES;
INSERT INTO public.estoque DEFAULT VALUES;
```

### Tabela `NPC_VENDEDOR`

```sql
-- 7. Inserindo NPCs Vendedores
INSERT INTO public.npc_vendedor (id_npc_vendedor, id_estoque) VALUES
(2, 1),
(5, 2);
```

### Tabela `ITEM`

```sql
-- 8. Inserindo Itens
INSERT INTO public.item (nome, tipo, descricao, atributos_bonus, custo, id_npc_combatente) VALUES
('Espada de Ferro', 'ARMA', 'Uma espada básica de ferro', 5, 100, NULL),
('Cajado do Aprendiz', 'ARMA', 'Cajado básico para magos iniciantes', 3, 80, NULL),
('Arco Curto', 'ARMA', 'Arco simples para treinamento', 4, 90, NULL),
('Poção de Cura', 'CONSUMIVEL', 'Restaura 50 pontos de vida', 50, 30, NULL),
('Pergaminho de Fogo', 'CONSUMIVEL', 'Libera uma explosão de fogo ao ser usado', 25, 50, NULL),
('Peitoral de Couro', 'ARMADURA', 'Armadura básica de couro', 10, 120, NULL),
('Garra de Lobo', 'CONSUMIVEL', 'Item dropado por lobos', NULL, 15, 3);

```

### Tabela `vende_ESTOQUE_ITEM`

```sql
-- 9. Inserindo Itens no estoque dos vendedores
INSERT INTO public.vende_estoque_item (id_estoque, id_item) VALUES
(1, 1), -- Ferreiro vende Espada de Ferro
(1, 6), -- Ferreiro vende Peitoral de Couro
(2, 2), -- Mago vende Cajado do Aprendiz
(2, 4), -- Mago vende Poção de Cura
(2, 5); -- Mago vende Pergaminho de Fogo
```

### Tabela `ARMADURA`

```sql
-- 10. Inserindo Armaduras
INSERT INTO public.armadura (id_item, tipo_armadura) VALUES
(6, 'PEITORAL');
```

### Tabela `PEITORAL`

```sql
-- Inserindo detalhes do Peitoral
INSERT INTO public.peitoral (id_armadura, nome_item, descricao, custo_item, defesa, defesa_magica, bonus_vida, bonus_defesa) VALUES
(6, 'Peitoral de Couro', 'Proteção básica para o torso', 120, 15, 5, 20, 5);
```

### Tabela `CONSUMIVEL`

```sql
-- 11. Inserindo Consumíveis
INSERT INTO public.consumivel (id_item, tipo_consumivel) VALUES
(4, 'POCAO'),
(5, 'PERGAMINHO'),
(7, 'COMIDA');
```

### Tabela `POCAO`

```sql
-- Inserindo detalhes da Poção
INSERT INTO public.pocao (id_consumivel, tipo_bonus_atributo, bonus_atributo, bonus_atributo_duracao, nome_item, descricao, custo_iem) VALUES
(4, 'VIDA', 50, 0, 'Poção de Cura', 'Restaura 50 pontos de vida', 30);
```

### Tabela `PERGAMINHO`

```sql
-- Inserindo detalhes do Pergaminho
INSERT INTO public.pergaminho (id_pergaminho, tipo_buff, duracao_buff, nome_item, descricao, custo_item) VALUES
(5, 'ATAQUE DE FOGO', 3, 'Pergaminho de Fogo', 'Ataques causam dano adicional de fogo por 3 turnos', 50);
```

### Tabela `COMIDA`

```sql
-- Inserindo detalhes da Comida
INSERT INTO public.comida (id_comida, tipo_bonus_atributo, bonus_atributo, bonus_atributo_duracao, nome_item, descricao, custo_item) VALUES
(7, 'FORCA', 5, 10, 'Garra de Lobo', 'Aumenta força por 10 minutos', 15);
```
### Tabela `JOGADOR`

```sql
-- 12. Inserindo Jogador
INSERT INTO public.jogador (usuario, email, senha) VALUES
('iancostag', 'iancostag@gmail.com', '123'),
('danilo', 'danilonaves@gmail.com', '456'),
('igris', 'richard@gmail.com', '789');
```

### Tabela `PERSONAGEM`

```sql
-- 13. Inserindo Personagens
INSERT INTO public.personagem (id_jogador, id_sala, nome, mana, vida, vitalidade, inteligencia, agilidade, sorte, destreza, forca, ataque, ataque_magico, precisao, esquiva, defesa, defesa_magica, critico, velocidade, nivel, dinheiro) VALUES
(1, 1, 'kamishiro', 50, 200, 10, 5, 8, 7, 9, 12, 20, 5, 70, 60, 15, 10, 10, 8, 1, 200),
(2, 1, 'Patolino, O Mago', 100, 150, 5, 15, 6, 8, 7, 5, 8, 25, 65, 50, 8, 20, 5, 6, 1, 150),
(3, 1, 'igris', 60, 180, 8, 7, 12, 10, 12, 8, 18, 8, 80, 70, 12, 12, 15, 10, 1, 180);
```

### Tabela `CLASSE`

```sql
-- 14. Inserindo Classes dos Personagens
INSERT INTO public.pertence_personagem_classe (id_personagem, id_classe) VALUES
(1, 9), -- kamishiro é Arqueiro
(2, 8), -- Patolino é Mago
(3, 7); -- Igris é guerreiro
```

### Tabela `INVENTARIO`

```sql
-- 15. Inserindo Inventários
INSERT INTO public.inventario (id_personagem) VALUES
(1),
(2),
(3);
```

### Tabela `INSTANCIA_ITEM`

```sql
-- 16. Inserindo Instâncias de Itens nos Inventários
INSERT INTO public.instancia_item (id_item, id_inventario) VALUES
(3, 1), -- kamishiro tem Arco Curto
(2, 2), -- Patolino tem Cajado do Aprendiz
(1, 3); -- Igris tem Espada de Ferro
```

### Tabela `MISSAO`

```sql
-- 17. Inserindo Missões
INSERT INTO public.missao (id_npc, requisito_level, xp_base, xp_classe, descricao, objetivo, dinheiro) VALUES
(3, 1, 100, 50, 'Derrote 5 lobos na floresta', 'Matar 5 lobos', 50),
(4, 3, 200, 100, 'Encontre o tesouro perdido na caverna', 'Explorar a caverna', 100),
(5, 5, 300, 150, 'Aprenda uma magia avançada', 'Falar com o mago', 150);
```

---

## Histórico de Versão

|  Versão  |     Data     | Descrição | Autor(es) | Revisor(es) |
| :------: | :----------: | :-----------: | :---------: | :---------: |
| `1.0` | 12/06/2025 | Criação do documento e primeira versão do DML | [Ian Costa](https://github.com/iancostag) | [Danilo Naves](https://github.com/DaniloNavesS) |
| `1.1` | 13/06/2025 | Ajustes de formatação markdown e código | [Amanda Cruz](https://github.com/mandicrz), [Felipe Motta](https://github.com/M0tt1nh4) | [Ian Costa](https://github.com/iancostag) |


