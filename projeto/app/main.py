import sys
from db.db_utils import connect_to_db, close_db_connection, execute_query
from game.world import iniciar_jogo
from game.player import create_character, get_characters_by_player_id
from utils.display import limpar_tela, exibir_mensagem, animate_logo

# --- ASCII Art para a logo do jogo com cores ANSI ---
# Códigos de cores ANSI:
# \033[91m = Vermelho Claro
# \033[93m = Amarelo Claro
# \033[94m = Azul Claro
# \033[95m = Magenta Claro
# \033[96m = Ciano Claro
# \033[0m  = Reseta a cor para o padrão do terminal

GAME_LOGO = """
██████   █████   ██████  ███    ██  █████  ██████   ██████  ██   ██ 
██   ██ ██   ██ ██       ████   ██ ██   ██ ██   ██ ██    ██ ██  ██  
██████  ███████ ██   ███ ██ ██  ██ ███████ ██████  ██    ██ █████   
██   ██ ██   ██ ██    ██ ██  ██ ██ ██   ██ ██   ██ ██    ██ ██  ██  
██   ██ ██   ██  ██████  ██   ████ ██   ██ ██   ██  ██████  ██   ██ 
                                                                                                                                           
"""

def registrar_jogador():
    """Função para registrar um novo jogador no banco de dados."""
    limpar_tela()
    print("--- Novo Registro ---")

    while True:
        usuario = input("Digite seu nome de usuário (ex: Player1): ").strip()
        if usuario:
            break
        exibir_mensagem("Nome de usuário não pode ser vazio.", tipo="erro")
    
    while True:
        email = input("Digite seu e-mail: ").strip().lower()
        if not email:
            exibir_mensagem("E-mail não pode ser vazio.", tipo="erro")
            continue
        
        if execute_query("SELECT id_jogador FROM JOGADOR WHERE email = %s;", (email,), fetch_one=True):
            exibir_mensagem("Este e-mail já está registrado. Tente outro.", tipo="erro")
        else:
            break

    while True:
        senha = input("Digite sua senha: ").strip()
        if not senha:
            exibir_mensagem("Senha não pode ser vazia.", tipo="erro")
            continue
        if len(senha) < 6: # Exemplo de validação de senha
            exibir_mensagem("A senha deve ter no mínimo 6 caracteres.", tipo="erro")
        else:
            break

    if execute_query("INSERT INTO JOGADOR (usuario, email, senha) VALUES (%s, %s, %s);", (usuario, email, senha), commit=True):
        exibir_mensagem(f"Jogador '{usuario}' registrado com sucesso!", tipo="sucesso")
    else:
        exibir_mensagem("Erro ao registrar jogador.", tipo="erro")


def exibir_menu_personagens(id_jogador):
    """Exibe o menu de seleção/criação de personagens para um jogador."""
    while True:
        limpar_tela()
        print("--- Seleção de Personagem ---")
        personagens = get_characters_by_player_id(id_jogador)

        if personagens:
            print("\nSeus Personagens:")
            for i, p in enumerate(personagens): 
                # p[0] é id_personagem, p[1] é nome, p[2] é nivel, p[3] é id_sala
                print(f"  {i+1}. {p[1]} (Nível {p[2]}, Mapa Atual: {p[3]})")
            print("-----------------------------")
        else:
            print("\nVocê ainda não tem personagens.")
        
        print("\nOpções:")
        print("  C. Criar novo personagem")
        if personagens: # Só mostra a opção de selecionar se houver personagens
            print("  [Número]. Selecionar personagem existente")
        print("  V. Voltar ao menu principal")

        escolha = input("Escolha uma opção: ").strip().upper()

        if escolha == 'C':
            limpar_tela()
            nome_personagem = input("Digite o nome do novo personagem (máx. 20 caracteres): ").strip()
            if not nome_personagem or len(nome_personagem) > 20:
                exibir_mensagem("Nome inválido ou muito longo (máximo 20 caracteres). Tente novamente.", tipo="erro")
                continue
            
            # Opcional: Verificar se o nome do personagem já existe para ESTE jogador
            existing_names_for_player = execute_query("SELECT nome FROM PERSONAGEM WHERE id_jogador = %s AND nome = %s;", (id_jogador, nome_personagem), fetch_one=True)
            if existing_names_for_player:
                exibir_mensagem("Você já tem um personagem com esse nome. Escolha outro.", tipo="erro")
                continue

            id_personagem_criado = create_character(id_jogador, nome_personagem)
            if id_personagem_criado:
                exibir_mensagem(f"Personagem '{nome_personagem}' criado! Entrando no mundo de Rune-Midgard...", tipo="sucesso")
                iniciar_jogo(id_personagem_criado)
                # Se o jogo terminar (ex: jogador digitou 'S' no loop do jogo),
                # ele retorna para este menu de seleção de personagem.
            
        elif personagens and escolha.isdigit():
            try:
                idx = int(escolha) - 1
                if 0 <= idx < len(personagens):
                    id_personagem_selecionado = personagens[idx][0] # id_personagem está na posição 0
                    exibir_mensagem(f"Personagem '{personagens[idx][1]}' selecionado! Entrando no mundo de Rune-Midgard...", tipo="sucesso")
                    iniciar_jogo(id_personagem_selecionado)
                    # Semelhante ao 'C', retorna para este menu.
                else:
                    exibir_mensagem("Seleção de personagem inválida.", tipo="erro")
            except ValueError:
                exibir_mensagem("Entrada inválida. Digite um número ou uma opção de menu.", tipo="erro")
        
        elif escolha == 'V':
            break # Volta ao menu de login
        else:
            exibir_mensagem("Opção inválida. Por favor, escolha novamente.", tipo="erro")


def fazer_login():
    """Função para o jogador fazer login, autenticando com o banco de dados."""
    limpar_tela()
    print("--- Login ---")

    email = input("Digite seu e-mail: ").strip().lower()
    senha = input("Digite sua senha: ").strip()

    jogador_data = execute_query("SELECT id_jogador, usuario, senha FROM JOGADOR WHERE email = %s;", (email,), fetch_one=True)

    if jogador_data: # Verifica se a consulta retornou uma linha (usuário encontrado)
        id_jogador_logado, usuario_db, senha_db = jogador_data
        if senha_db == senha: # Lembre-se de usar hash de senha em um projeto real!
            exibir_mensagem(f"Bem-vindo, {usuario_db}! Login realizado com sucesso.", tipo="sucesso")
            exibir_menu_personagens(id_jogador_logado) # Chama o menu de seleção de personagens
            return True
        else:
            exibir_mensagem("Senha incorreta.", tipo="erro")
    else:
        # Se jogador_data for None, significa que o e-mail não foi encontrado.
        # Se for False, significa que houve um erro de banco de dados na execute_query.
        if jogador_data is False:
             exibir_mensagem("Ocorreu um erro no banco de dados ao tentar buscar o usuário.", tipo="erro")
        else: # jogador_data é None
            exibir_mensagem("E-mail não encontrado. Por favor, registre-se primeiro.", tipo="erro")
    return False

def exibir_menu_inicial():
    """Exibe o menu principal do jogo (login/registro)."""
    
    if not connect_to_db():
        exibir_mensagem("Não foi possível iniciar o jogo sem conexão com o banco de dados.", tipo="erro")
        sys.exit()

    exibir_mensagem("Conectado ao PostgreSQL com sucesso!", tipo="sucesso")

    animate_logo(GAME_LOGO) # Anima a logo apenas uma vez na inicialização

    while True:
        limpar_tela() # Limpa a tela antes de exibir o menu principal
        
        print("\n" + "+" + "-" * 38 + "+")
        print("|        Bem-vindo a Rune-Midgard        |")
        print("+" + "-" * 38 + "+")
        print("|                                        |")
        print("|  1. Entrar (Login)                     |")
        print("|  2. Criar Conta (Registro)             |")
        print("|  3. Sair do Jogo                       |")
        print("|                                        |")
        print("+" + "-" * 38 + "+")

        escolha = input("Escolha uma opção: ").strip()

        if escolha == '1':
            fazer_login()
        elif escolha == '2':
            registrar_jogador()
        elif escolha == '3':
            exibir_mensagem("Obrigado por jogar! Até a próxima aventura!", tipo="info")
            close_db_connection()
            sys.exit()
        else:
            exibir_mensagem("Opção inválida. Por favor, escolha novamente.", tipo="erro")

# Ponto de entrada do jogo
if __name__ == "__main__":
    exibir_menu_inicial()