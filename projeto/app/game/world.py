from db.db_utils import execute_query
from utils.display import limpar_tela, exibir_mensagem
from game.player import get_character_details, update_character_room # Importa as funções do player

def get_room_details(room_id):
    """Busca os detalhes de uma sala no banco de dados."""
    query = "SELECT id_sala, id_direita, id_esquerda, id_baixo, id_cima, nome_sala, descricao_sala FROM SALA WHERE id_sala = %s;"
    room_data = execute_query(query, (room_id,), fetch_one=True)
    
    if room_data:
        return {
            "id_sala": room_data[0],
            "id_direita": room_data[1],
            "id_esquerda": room_data[2],
            "id_baixo": room_data[3],
            "id_cima": room_data[4],
            "nome_sala": room_data[5],
            "descricao_sala": room_data[6]
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
    print("\n--- Saídas Disponíveis ---")

    saidas = []
    if room_data['id_cima']:
        saidas.append("Cima (C)")
    if room_data['id_baixo']:
        saidas.append("Baixo (B)")
    if room_data['id_esquerda']:
        saidas.append("Esquerda (E)")
    if room_data['id_direita']:
        saidas.append("Direita (D)")
    
    if saidas:
        print(", ".join(saidas))
    else:
        print("Nenhuma saída aparente desta sala.")
    print("-" * 50)

def iniciar_jogo(id_personagem_selecionado):
    """Inicia o loop principal do jogo para o personagem selecionado."""
    
    character_data = get_character_details(id_personagem_selecionado)
    if not character_data:
        exibir_mensagem("Erro: Não foi possível carregar os detalhes do personagem.", tipo="erro")
        return # Volta ao menu de seleção de personagem

    current_room_id = character_data['id_sala']
    character_name = character_data['nome']
    
    while True:
        room_data = get_room_details(current_room_id)
        if not room_data:
            exibir_mensagem("Não foi possível carregar a sala atual. Voltando ao menu principal.", tipo="erro")
            break

        display_room(room_data, character_name)

        print("\nO que você quer fazer?")
        print("Mover (Cima/C, Baixo/B, Esquerda/E, Direita/D) | Sair do Jogo (S)")
        
        escolha = input("> ").strip().upper()

        nova_sala_id = None
        if escolha == 'C' and room_data['id_cima']:
            nova_sala_id = room_data['id_cima']
        elif escolha == 'B' and room_data['id_baixo']:
            nova_sala_id = room_data['id_baixo']
        elif escolha == 'E' and room_data['id_esquerda']:
            nova_sala_id = room_data['id_esquerda']
        elif escolha == 'D' and room_data['id_direita']:
            nova_sala_id = room_data['id_direita']
        elif escolha == 'S':
            exibir_mensagem("Saindo do jogo atual e voltando ao menu inicial.", tipo="info")
            break
        else:
            exibir_mensagem("Comando ou direção inválida.", tipo="erro")
        
        if nova_sala_id:
            if get_room_details(nova_sala_id):
                if update_character_room(id_personagem_selecionado, nova_sala_id):
                    current_room_id = nova_sala_id
                   
                    exibir_mensagem(f"Você se moveu para {get_room_details(nova_sala_id)['nome_sala']}.", tipo="sucesso")
                else:
                    exibir_mensagem("Erro ao atualizar a sala do personagem no banco de dados.", tipo="erro")
            else:
                exibir_mensagem("Não foi possível ir para essa direção. Caminho bloqueado ou sala inexistente.", tipo="erro")