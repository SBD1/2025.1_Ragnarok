---

---

# Ragnarok MUD - Dicionário de Dados

## Entidade: JOGADOR
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| idJogador | inteiro | Identificador do jogador.  | 1-100                  | Não                      | Sim. Chave primária | -                   |
| usuario | string | Nome de usuário do jogador.  | A-Z, a-z                  | Não                      | Não | -                   |
| email | string | Email do jogador.  | A-Z, a-z, @, ., 0 - 9                  | Não                      | Não | -                   |
| senha | string | Senha do jogador.  | A-Z, a-z, @                  | Não                      | Não | -                   |

## Entidade: PERSONAGEM
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| idPersonagem | inteiro | Identificador do personagem  | 0–9                  | Não                      | Sim. Chave primária | -                   |
| nome         | string  | Nome do personagem           | a–z, A–Z             | Não                      | Não                 | -                   |
| vida         | inteiro | Pontos de vida               | ≥ 0                  | Não                      | Não                 | -                   |
| mana         | inteiro | Pontos de mana               | ≥ 0                  | Não                      | Não                 | -                   |
| vitalidade   | inteiro | Atributo: Vitalidade         | ≥ 0                  | Não                      | Não                 | -                   |
| inteligencia | inteiro | Atributo: Inteligência       | ≥ 0                  | Não                      | Não                 | -                   |
| agilidade    | inteiro | Atributo: Agilidade          | ≥ 0                  | Não                      | Não                 | -                   |
| sorte        | inteiro | Atributo: Sorte              | ≥ 0                  | Não                      | Não                 | -                   |
| destreza     | inteiro | Atributo: Destreza           | ≥ 0                  | Não                      | Não                 | -                   |
| forca        | inteiro | Atributo: Força              | ≥ 0                  | Não                      | Não                 | -                   |
| ataque       | inteiro | Ataque físico                | ≥ 0                  | Não                      | Não                 | -                   |
| ataqueMagico | inteiro | Ataque mágico                | ≥ 0                  | Não                      | Não                 | -                   |
| precisao     | inteiro | Precisão                     | ≥ 0                  | Não                      | Não                 | -                   |
| esquiva      | inteiro | Esquiva                      | ≥ 0                  | Não                      | Não                 | -                   |
| defesa       | inteiro | Defesa física                | ≥ 0                  | Não                      | Não                 | -                   |
| defesaMagica | inteiro | Defesa mágica                | ≥ 0                  | Não                      | Não                 | -                   |
| critico      | float   | Chance de crítico            | 0.0–1.0              | Não                      | Não                 | -                   |
| velocidade   | float   | Velocidade de movimento/ação | ≥ 0                  | Não                      | Não                 | -                   |
| nivel        | inteiro | Nível do personagem          | ≥ 0                  | Não                      | Não                 | -                   |
| dinheiro     | float   | Quantidade de dinheiro       | ≥ 0                  | Não                      | Não                 | -                   |

## Entidade: CLASSE
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| idClasse | inteiro | Identificador de classe.  | 1-100                  | Não                      | Sim. Chave primária | -                   |
| nomeClasse         | string  | Nome da classe.           | a–z, A–Z             | Não                      | Não                 | -                   |
| descricao         | string  | Breve descrição da classe.           | a–z, A–Z             | Não                      | Não                 | -                   |

## Entidade: HABILIDADE
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| idHabilidade         | int  | Identificador de habilidade.           | 1 - 100             | Não                      | Sim. Chave Primária.               |          -         |
| nomeHabilidade         | string  | Nome da habilidade.           | a–z, A–Z             | Não                      | Não                 | -                   |
| descricao         | string  | Breve descrição da habilidade.           | a–z, A–Z             | Não                      | Não                 | -                   |
| custoMana         | int  | Valor de custo da mana.           | 1 - 1000             | Não                      | Não                 | -                   |
| nivelRequerido         | int  | Nível requerido para a habilidade.           | 1 - 100             | Não                      | Não                 | -                   |

## Entidade: SALA
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| idSala         | int  | Identificador de sala.           | 1 - 100             | Não                      | Sim. Chave Primária.               |          -         |
| idCima         | int  | Identificador de localização de cima.           | 1 - 100             | Não                      | Não                 | -                   |
| idBaixo         | int  | Identificador de localização de baixo.           | 1 - 100             | Não                      | Não                 | -                   |
| idEsquerda         | int  | Identificador de localização de esquerda.           | 1 - 100             | Não                      | Não                 | -                   |
| idDireita         | int  | Identificador de localização de direita.           | 1 - 100             | Não                      | Não                 | -                   |
| tipoSala         | string  | Breve descrição do tipo da sala.           | a–z, A–Z             | Não                      | Não                 | -                   |
| nomeSala         | string  | Nome da sala.          | a–z, A–Z             | Não                      | Não                 | -                   |
| descricaoSala         | string  | Breve descrição da sala.           | a–z, A–Z             | Não                      | Não                 | -                   |

## Entidade: INVENTARIO
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| idInventario         | int  | Identificador do inventário.           | 1 - 100             | Não                      | Sim. Chave Primária.               |          -         |
| idPersonagem         | int  | Identificador do personagem.           | 1 - 100             | Não                      | Sim. Chave estrangeira.               |          -         |
| idInstanciaItem         | int  | Identificador do item.           | 1 - 100             | Não                      | Sim. Chave estrangeira.               |          -         |
| capacidadeSlots         | int  | Quantidade da capacidade do slot.           | 0 - 100              | Sim                      | Não                 | -                   |
| slotsUsados         | int  | Quantidade de slots utilizados.           | 1 - 100              | Não                      | Não                 | -                   |

## Entidade: ITEM
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| idItem         | int  | 	Identificador único do item.           | 1 - 100             | Não                      | Sim. Chave Primária.               |          -         |
| nomeItem         | string  | 	Nome que identifica o item.           | a–z, A–Z              | Não                      | Não                 | -                   |
| tipoItem         | string  | Tipo geral do item (ex: arma, poção).           | a–z, A–Z              | Não                      | Não                 | -                   |
| descricao         | string  | Texto explicativo sobre o item.           | a–z, A–Z              | Não                      | Não                 | -                   |
| atributosBonus         | string  | Bônus concedidos ao personagem.           | a–z, A–Z              | Não                      | Não                 | -                   |

## Entidade: ARMA
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| velocidadeAtaque         | int  |	Velocidade com que a arma realiza ataques           | 1 - 100             | Não                      | Não               |          -         |
| tipoDano         | string  | Tipo de dano causado (ex: físico, mágico)           | a–z, A–Z              | Não                      | Não                 | -                   |
| danoBase         | string  | Valor base do dano causado pela arma           | a–z, A–Z              | Não                      | Não                 | -                   |
| alcance         | string  | Distância de uso da arma (curto, médio, longo)           | a–z, A–Z              | Não                      | Não                 | -                   |

## Entidade: CURTO_ALCANCE
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| categoriaArma         | string  | Categoria da arma.           | a–z, A–Z             | Não                      | Não               |          -         |

## Entidade: LONGO_ALCANCE
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| tipoProjetil         | string  | Tipo de projétil utilizado (ex: flecha, bala)           | a–z, A–Z             | Não                      | Não               |          -         |
| quantidadeProjetil         | int  | Quantidade de projéteis disponíveis ou carregados           | 0 - 100             | Sim                      | Não               |          -         |

## Entidade: MAGICA
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| tipoMagia         | string  | Tipo de magia associada ao item ou personagem           | a–z, A–Z             | Não                      | Não               |          -         |
| efeitoMagico         | string  | 	Efeito causado pela magia ao ser utilizada          | a–z, A–Z             | Não                      | Não               |          -         |

## Entidade: DROP
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| taxaDrop         | int  | Chance do item dropar.           | 1 - 100             | Não                      | Não               |          -         |

## Entidade: ARMADURA
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| tipoArmadura         | string  | Tipo da armadura.           | a–z, A–Z             | Não                      | Não               |          -         |
| defesa         | int  | 	Quantidade de defesa adicional.           | 1 - 100             | Não                      | Não               |          -         |
| defesaMagica         | int  | 	Quantidade de defesa mágica adicional.           | 1 - 100             | Não                      | Não               |          -         |

## Entidade: PEITORAL
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| resistenciaStatus         | string  | Tipo de status negativo ao qual o peitoral oferece resistência.           | a–z, A–Z             | Não                      | Não               |          -         |
| bonusVida         | int  | Bônus adicional de pontos de vida concedido pelo peitoral.           | 1 - 100             | Não                      | Não               |          -         |
| bonusDefesa         | int  | 	Bônus adicional de defesa concedido pelo peitoral.           | 1 - 100             | Não                      | Não               |          -         |

## Entidade: CAPACETE
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| bonusMana         | int  | 	Bônus adicional de mana concedido pelo capacete.           | 1 - 100             | Não                      | Não               |          -         |


## Entidade: BOTA
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| resistenciaStatus         | string  | 	Tipo de status negativo ao qual a bota oferece resistência.           | a–z, A–Z            | Não                      | Não               |          -         |
| bonusDefesa         | int  | Bônus adicional de defesa concedido pela bota.           | 1 - 100             | Não                      | Não               |          -         |
| bonusCritico         | int  | 	Bônus adicional na chance de acerto crítico.           | 1 - 100             | Não                      | Não               |          -         |

## Entidade: ESCUDO
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| resistenciaStatus         | string  | Resistência a um status negativo específico.           | 1 - 100             | Não                      | Não               |          -         |

## Entidade: CAPA
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| resistenciaStatus         | string  | 	Tipo de status ao qual a capa oferece resistência.           | a–z, A–Z             | Não                      | Não               |          -         |
| bonusVida         | int  | Bônus adicional de pontos de vida concedido pela capa.           | 1 - 100             | Não                      | Não               |          -         |

## Entidade: ACESSORIO
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| bonusMana         | int  | Bônus adicional de pontos de mana.           | 1 - 100             | Não                      | Não               |          -         |
| bonusVida         | int  | Bônus adicional de pontos de vida.           | 1 - 100             | Não                      | Não               |          -         |
| bonusEsquiva         | int  | 	Bônus na chance de esquivar de ataques.           | 1 - 100             | Não                      | Não               |          -         |

## Entidade: CONSUMIVEL
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| tipoConsumivel         | string  | 	Aumento temporário em algum atributo do personagem.           | a–z, A–Z             | Não                      | Não               |          -         |

## Entidade: COMIDA
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| bonusAtributo         | int  | 	Aumento temporário em algum atributo do personagem.           | 1 - 100             | Não                      | Não               |          -         |
| bonusAtributoDuracao         | int  | Tempo de duração do bônus fornecido pela comida (em turnos/segundos).           | 1 - 100             | Não                      | Não               |          -         |

## Entidade: POCAO
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| recuperaVida         | int  | Quantidade de pontos de vida restaurados.           | 1 - 100             | Não                      | Não               |          -         |
| recuperaMana         | int  | Quantidade de pontos de mana restaurados           | 1 - 100             | Não                      | Não               |          -         |

## Entidade: PERGAMINHO
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| tipoBuff         | string  | Tipo de melhoria temporária concedida.           | a–z, A–Z             | Não                      | Não               |          -         |
| duracaoBuff         | int  | 	Duração do efeito do buff em turnos ou segundos.           | 1 - 100             | Não                      | Não               |          -         |

## Entidade: INSTANCIA_ITEM
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| idInstanciaItem         | int  | 	Identificador único da instância de item.           | 1 - 100             | Não                      | Sim. Chave primária.               |          -         |

## Entidade: NPC
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| idNpc         | int  |Identificador único do NPC.           | 1 - 100             | Não                      | Sim. Chave primária.               |          -         |
| nome         | string  | Nome do NPC.           | a–z, A–Z             | Não                      | Não               |          -         |
| descricao         | string  |	Descrição textual do NPC.           | a–z, A–Z             | Não                      | Não               |          -         |
| tipoNpc         | string  | Tipo do NPC (ex: vendedor, combatente).           | a–z, A–Z             | Não                      | Não               |          -         |

## Entidade: NPC_COMBATENTE
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| tamanho         | string  | Tamanho físico do NPC (ex: pequeno, médio, grande).           | a–z, A–Z             | Não                      | Não               |          -         |
| raca         | string  | Raça ou tipo da criatura do NPC.           | a–z, A–Z             | Não                      | Não               |          -         |
| descricao         | string  | Descrição do NPC combatente.           | a–z, A–Z             | Não                      | Não               |          -         |
| ataque         | int  | 	Valor de ataque base do NPC.           | 1 - 100             | Não                      | Não               |          -         |
| defesa         | int  | Valor de defesa física do NPC.           | 1 - 100             | Não                      | Não               |          -         |
| defesaMagica         | int  | Valor de defesa mágica do NPC.           | 1 - 100             | Não                      | Não               |          -         |
| nivel         | int  | 	Nível geral do NPC.           | 1 - 100             | Não                      | Não               |          -         |
| precisao         | int  | Capacidade de acerto em ataques.           | 1 - 100             | Não                      | Não               |          -         |
| esquiva         | int  | Capacidade de evitar ataques.           | 1 - 100             | Não                      | Não               |          -         |

## Entidade: INSTANCIA_NPC_COMBATENTE
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| idInstanciaNpcCombatente         | int  | 	Identificador único da instância de NPC combatente           | 1 - 100            | Sim. Chave primária.                      | Não               |          -         |
| idNpcCombatente         | int  |	Referência ao NPC combatente base.           | 1 - 100             | Sim. Chave estrangeira.                      | Não               |          -         |
| vidaAtual         | int  | Pontos de vida atuais da instância.           | 1 - 1000             | Não                      | Não               |          -         |
| status         | string  | Estado atual do NPC (ex: ativo, envenenado)e.           | a–z, A–Z              | Não                      | Não               |          -         |
| agressivo         | boolean  | 	Indica se o NPC é agressivo (true/false).           | true - false              | Não                      | Não               |          -         |

## Entidade: NPC_QUEST
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| dialogoFalha         | string  | Texto exibido ao jogador ao falhar na missão.           | a–z, A–Z              | Não                      | Não               |          -         |
| dialogSucesso         | string  | Texto exibido ao jogador ao concluir a missão.           | a–z, A–Z              | Não                      | Não               |          -         |

## Entidade: NPC_VENDEDOR
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| tipoLoja         | string  | Tipo de loja operada pelo NPC vendedor.           | a–z, A–Z              | Não                      | Não               |          -         |

## Entidade: INSTANCIA_NPC_VENDEDOR
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| idInstanciaVendedor         | int  |	Identificador único da instância de NPC vendedor.           | 1 - 100              | Sim. Chave primária.                      | Não               |          -         |
| idNpcVendedor         | int  | Referência ao NPC vendedor base.           | 1 - 100              | Sim. Chave estrangeira.                      | Não               |          -         |

## Entidade: MISSAO
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| idMissao         | int  | 	Identificador único da missão.           | 1 - 100              | Sim. Chave primária.                      | Não               |          -         |
| idNpcQuest         | int  | Referência ao NPC que fornece a missão.           | 1 - 100              | Sim. Chave estrangeira.                      | Não               |          -         |
| idItem         | int  |Referência ao item necessário ou recompensado.           | 1 - 100              | Sim. Chave estrangeira.                      | Não               |          -         |
| requisitoLevel         | int  | Nível mínimo do jogador para aceitar a missão.           | 1 - 100              | Não                      | Não               |          -         |
| xpBase         | int  | 	Experiência geral recebida pela missão.           | 1 - 100              | Não                      | Não               |          -         |
| xpClasse         | int  | Experiência atribuída à classe do personagem.           | 1 - 100              | Não                      | Não               |          -         |
| descricao         | string  |Texto descritivo com detalhes da missão.           | a–z, A–Z              | Não                      | Não               |          -         |
| objetivo         | string  | Objetivo principal da missão (ex: derrotar, entregar).           | a–z, A–Z              | Não                      | Não               |          -         |
| dinheiroMissao         | int  | Quantia de dinheiro recebida ao concluir a missão.           | 1 - 1000              | Não                      | Não               |          -         |

## Entidade: ESTOQUE
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| idEstoque         | int  | 	Identificador único do estoque.           | 1 - 100              | Não                      | Sim. Chave primária               |          -         |
| idNpcVendedor         | int  |	Referência ao NPC responsável pelo estoque.           | 1 - 100              | Não                      | Sim. Chave estrangeira               |          -         |

# Atributos de Relacionamentos
## Entidade: possui_ESTOQUE_ITEM
| Variável     | Tipo    | Descrição                    | Valores permitidos   | Permite valores nulos?   | É chave?            | Outras restrições   |
|:-------------|:--------|:-----------------------------|:---------------------|:-------------------------|:--------------------|:--------------------|
| idEstoque         | int  | 	Referência ao estoque onde o item está armazenado.           | 1 - 100              | Não                      | Sim. Chave primária               |          -         |
| idItem         | int  | 	Referência ao item armazenado.           | 1 - 100              | Não                      | Sim. Chave estrangeira               |          -         |
| custoItem         | int  | 	Custo do item no estoque em unidades monetárias.           | 1 - 1000              | Não                      | Não               |          -         |

## Histórico de Versão

|  Versão  |     Data     | Descrição | Autor(es) | Revisor(es) |
| :------: | :----------: | :-----------: | :---------: | :---------: |
| `1.0` | 02/05/2025 | Criação de documento e primeira versão do DD | [Cauã Araujo](https://github.com/caua08) | [Ian Costa](https://github.com/DaniloNavesS) |

