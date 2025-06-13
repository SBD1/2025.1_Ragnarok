from db.db_utils import execute_query
from utils.display import limpar_tela, exibir_mensagem

def create_character(id_jogador, nome):
    """
    Cria um novo personagem para um jogador no banco de dados.
    Define valores padrão para sala (1) e missao (NULL), e stats básicos.
    """
    vitalidade = 10
    inteligencia = 10
    agilidade = 10
    sorte = 10
    destreza = 10
    forca = 10
    ataque = 10
    ataque_magico = 10
    precisao = 10
    esquiva = 10
    defesa = 10
    defesa_magica = 10
    critico = 5
    velocidade = 5

    query = """
    INSERT INTO PERSONAGEM (
        id_jogador, id_sala, id_missao, nome, mana, vida, vitalidade, inteligencia,
        agilidade, sorte, destreza, forca, ataque, ataque_magico, precisao, esquiva,
        defesa, defesa_magica, critico, velocidade, nivel, dinheiro
    ) VALUES (
        %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
    ) RETURNING id_personagem;
    """
    params = (
        id_jogador, 1, None, nome, 10, 300, vitalidade, inteligencia,
        agilidade, sorte, destreza, forca, ataque, ataque_magico, precisao, esquiva,
        defesa, defesa_magica, critico, velocidade, 1, 100
    )

    result = execute_query(query, params, fetch_one=True, commit=True)
    if result:
        exibir_mensagem(f"Personagem '{nome}' criado com sucesso! ID: {result[0]}", tipo="sucesso")
        return result[0] # Retorna o id_personagem recém-criado
    else:
        exibir_mensagem(f"Erro ao criar personagem '{nome}'.", tipo="erro")
        return None

def get_characters_by_player_id(id_jogador):
    """Retorna uma lista de personagens de um jogador."""
    query = "SELECT id_personagem, nome, nivel, id_sala FROM PERSONAGEM WHERE id_jogador = %s ORDER BY nome;"
    return execute_query(query, (id_jogador,), fetch_one=False)

def get_character_details(id_personagem):
    """Retorna todos os detalhes de um personagem específico."""
    query = """
    SELECT
        id_personagem, id_jogador, id_sala, id_missao, nome, mana, vida,
        vitalidade, inteligencia, agilidade, sorte, destreza, forca,
        ataque, ataque_magico, precisao, esquiva, defesa, defesa_magica,
        critico, velocidade, nivel, dinheiro
    FROM PERSONAGEM WHERE id_personagem = %s;
    """
    result = execute_query(query, (id_personagem,), fetch_one=True)
    if result:
        # Mapeia as colunas para um dicionário para fácil acesso
        columns = [
            "id_personagem", "id_jogador", "id_sala", "id_missao", "nome", "mana", "vida",
            "vitalidade", "inteligencia", "agilidade", "sorte", "destreza", "forca",
            "ataque", "ataque_magico", "precisao", "esquiva", "defesa", "defesa_magica",
            "critico", "velocidade", "nivel", "dinheiro"
        ]
        return dict(zip(columns, result))
    return None

def update_character_room(id_personagem, new_id_sala):
    """Atualiza a sala atual de um personagem."""
    query = "UPDATE PERSONAGEM SET id_sala = %s WHERE id_personagem = %s;"
    if execute_query(query, (new_id_sala, id_personagem), commit=True):
        return True
    return False