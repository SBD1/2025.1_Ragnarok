from db.db_utils import execute_query
from utils.display import limpar_tela, exibir_mensagem
from game.player import get_character_details, update_character_room
from game.map import gerar_mapa_local_opcao2
from game.combat import iniciar_combate

def get_room_details(room_id):
    """Busca os detalhes de uma sala no banco de dados."""
    query = """
    SELECT 
        S.id_sala,
        S.id_direita,
        S.id_esquerda,
        S.id_baixo,
        S.id_cima,
        S.nome_sala,
        S.descricao_sala,
        SD.nome_sala AS nome_direita,
        SE.nome_sala AS nome_esquerda,
        SB.nome_sala AS nome_baixo,
        SC.nome_sala AS nome_cima
    FROM 
        SALA S
    LEFT JOIN SALA SD ON S.id_direita = SD.id_sala
    LEFT JOIN SALA SE ON S.id_esquerda = SE.id_sala
    LEFT JOIN SALA SB ON S.id_baixo = SB.id_sala
    LEFT JOIN SALA SC ON S.id_cima = SC.id_sala
    WHERE S.id_sala = %s
    """
    room_data = execute_query(query, (room_id,), fetch_one=True)
    
    if room_data:
        return {
            "id_sala": room_data[0],
            "id_direita": room_data[1],
            "id_esquerda": room_data[2],
            "id_baixo": room_data[3],
            "id_cima": room_data[4],
            "nome_sala": room_data[5],
            "descricao_sala": room_data[6],
            "nome_direita": room_data[7],
            "nome_esquerda": room_data[8],
            "nome_baixo": room_data[9],
            "nome_cima": room_data[10],
        }
    else:
        exibir_mensagem(f"Sala com ID {room_id} não encontrada no banco de dados.", tipo="erro")
        return None

def display_room(room_data, character_name):
    """Exibe o nome e a descrição da sala atual, e as saídas disponíveis, com o nome do personagem."""
    limpar_tela()
    if not room_data:
        print("Erro: Dados da sala não disponíveis.")
        return

    print("+" + "=" * 48 + "+")
    print(f"| {room_data['nome_sala'].center(46)} |")
    print("+" + "=" * 48 + "+")
    print(f"\nVocê é {character_name}.") 
    print("\n" + room_data['descricao_sala'])

   
    print("\n--- Mapa Local ---")
   
    mapa = gerar_mapa_local_opcao2(room_data['id_sala']) 
    print(mapa)

    print("\n--- Locais Disponíveis ---")
    saidas = []
    if room_data['id_cima']:
        saidas.append(f"Insira 1 - {room_data['nome_cima']}")
    if room_data['id_baixo']:
        saidas.append(f"Insira 2 - {room_data['nome_baixo']}")
    if room_data['id_esquerda']:
        saidas.append(f"Insira 3 - {room_data['nome_esquerda']}")
    if room_data['id_direita']:
        saidas.append(f"Insira 4 - {room_data['nome_direita']}")

    if saidas:
        print("\n".join(saidas))
    else:
        print("Nenhuma saída aparente desta sala.")
    print("-" * 50)

def iniciar_jogo(id_personagem_selecionado):
    """Inicia o loop principal do jogo para o personagem selecionado."""
    character_data = get_character_details(id_personagem_selecionado)
    if not character_data:
        exibir_mensagem("Erro: Não foi possível carregar os detalhes do personagem.", tipo="erro")
        return

    current_room_id = character_data['id_sala']
    character_name = character_data['nome']
    
    while True:
        room_data = get_room_details(current_room_id)
        if not room_data:
            exibir_mensagem("Não foi possível carregar a sala atual. Voltando ao menu principal.", tipo="erro")
            break

        display_room(room_data, character_name)

       
        inimigos_presentes = execute_query("""
            SELECT 1 FROM INSTANCIA_NPC_COMBATENTE i
            JOIN NPC n ON i.id_npc_combatente = n.id_npc
            WHERE i.status_npc = 'VIVO' AND n.id_sala = %s
            LIMIT 1;
        """, (current_room_id,), fetch_one=True)

        print("\nO que você quer fazer?")
        print("Mover (1, 2, 3, 4) | Sair do Jogo (S)")
        if inimigos_presentes:
            print("Combater (C)")
        
        escolha = input("> ").strip().upper()

        nova_sala_id = None
        if escolha == '1' and room_data['id_cima']:
            nova_sala_id = room_data['id_cima']
        elif escolha == '2' and room_data['id_baixo']:
            nova_sala_id = room_data['id_baixo']
        elif escolha == '3' and room_data['id_esquerda']:
            nova_sala_id = room_data['id_esquerda']
        elif escolha == '4' and room_data['id_direita']:
            nova_sala_id = room_data['id_direita']
        elif escolha == 'C' and inimigos_presentes: 
            iniciar_combate(id_personagem_selecionado)
        
            character_data = get_character_details(id_personagem_selecionado)
            if not character_data: 
                exibir_mensagem("Seu personagem foi redefinido após a derrota. Retornando ao menu.", tipo="info")
                break 
            current_room_id = character_data['id_sala'] 
            continue 
        elif escolha == 'S':
            exibir_mensagem("Saindo do jogo atual e voltando ao menu inicial.", tipo="info")
            break
        else:
            exibir_mensagem("Comando ou direção inválida.", tipo="erro")
        
        if nova_sala_id:
            
            if get_room_details(nova_sala_id): 
                if update_character_room(id_personagem_selecionado, nova_sala_id):
                    current_room_id = nova_sala_id
                    nova_sala = get_room_details(nova_sala_id)
                    exibir_mensagem(f"Você se moveu para {nova_sala['nome_sala']}.", tipo="sucesso")
                else:
                    exibir_mensagem("Erro ao atualizar a sala do personagem no banco de dados.", tipo="erro")
            else:
                exibir_mensagem("Não foi possível ir para essa direção. Caminho bloqueado ou sala inexistente.", tipo="erro")