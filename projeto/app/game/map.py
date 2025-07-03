from db.db_utils import execute_query

def carregar_sala_com_vizinhos(id_sala):
    """Carrega a sala atual e suas conexões imediatas."""
    query = """
        SELECT
            S.id_sala, S.nome_sala,
            C.id_sala, C.nome_sala,
            B.id_sala, B.nome_sala,
            E.id_sala, E.nome_sala,
            D.id_sala, D.nome_sala
        FROM SALA S
        LEFT JOIN SALA C ON S.id_cima = C.id_sala
        LEFT JOIN SALA B ON S.id_baixo = B.id_sala
        LEFT JOIN SALA E ON S.id_esquerda = E.id_sala
        LEFT JOIN SALA D ON S.id_direita = D.id_sala
        WHERE S.id_sala = %s
    """
    resultado = execute_query(query, (id_sala,), fetch_one=True)
    if not resultado:
        return None

    # Ajustando o retorno para lidar com casos onde vizinhos podem ser nulos
    # A verificação 'len(resultado) > X' é mais robusta para garantir que o índice existe
    return {
        "atual": (resultado[0], resultado[1]) if resultado and len(resultado) > 1 else (None, None),
        "cima": (resultado[2], resultado[3]) if resultado and len(resultado) > 3 and resultado[2] else (None, None),
        "baixo": (resultado[4], resultado[5]) if resultado and len(resultado) > 5 and resultado[4] else (None, None),
        "esquerda": (resultado[6], resultado[7]) if resultado and len(resultado) > 7 and resultado[6] else (None, None),
        "direita": (resultado[8], resultado[9]) if resultado and len(resultado) > 9 and resultado[8] else (None, None),
    }

def ajustar_nome(nome, largura=20):
    """Centraliza e corta nomes longos com '...' no final se necessário."""
    if not nome:
        return " " * largura
    nome = nome.strip()
    if len(nome) > largura:
        nome = nome[:largura - 3] + "..."
    return f"{nome:^{largura}}"

def construir_mapa_local_opcao2_ajustada(sala_data):
    """Constrói o mini mapa ASCII com a sala atual e suas conexões diretas (Layout com Moldura e Setas Detalhadas) - AJUSTADO."""
    largura_celula = 20
    largura_total_celula = largura_celula + 2 # Considerando bordas | e +

    def celula_borda():
        return f"+{'-' * largura_celula}+"

    def celula_conteudo(nome_sala):
        nome_ajustado = ajustar_nome(nome_sala, largura_celula)
        return f"|{nome_ajustado}|"
    
    # Nomes das salas
    cima_nome = sala_data.get("cima") and sala_data["cima"][1]
    baixo_nome = sala_data.get("baixo") and sala_data["baixo"][1]
    esquerda_nome = sala_data.get("esquerda") and sala_data["esquerda"][1]
    direita_nome = sala_data.get("direita") and sala_data["direita"][1]
    atual_nome = sala_data["atual"][1]

    mapa = []

    # --- Parte de CIMA (Sala Cima) ---
    mapa.append(f"{' ' * largura_total_celula}{celula_borda()}{' ' * largura_total_celula}")
    mapa.append(f"{' ' * largura_total_celula}{celula_conteudo(cima_nome)}{' ' * largura_total_celula}")
    mapa.append(f"{' ' * largura_total_celula}{celula_borda()}{' ' * largura_total_celula}")
    
    # Conector vertical para Cima
    mapa.append(f"{' ' * largura_total_celula}{'|'.center(largura_total_celula)}{' ' * largura_total_celula}")
    mapa.append(f"{' ' * largura_total_celula}{'↑'.center(largura_total_celula)}{' ' * largura_total_celula}")
    mapa.append(f"{' ' * largura_total_celula}{'|'.center(largura_total_celula)}{' ' * largura_total_celula}")

    # --- Parte do MEIO (Esquerda - Atual - Direita) ---
    # Linha da borda superior das celulas laterais e central
    mapa.append(f"{celula_borda()}---{celula_borda()}---{celula_borda()}")
    
    # Conteúdo das celulas laterais e central com setas
    mapa.append(f"{celula_conteudo(esquerda_nome)}<--{celula_conteudo(atual_nome)}-->{celula_conteudo(direita_nome)}")
    
    # Linha da borda inferior das celulas laterais e central
    mapa.append(f"{celula_borda()}---{celula_borda()}---{celula_borda()}")

    # --- Parte de BAIXO (Sala Baixo) ---
    # Conector vertical para Baixo
    mapa.append(f"{' ' * largura_total_celula}{'|'.center(largura_total_celula)}{' ' * largura_total_celula}")
    mapa.append(f"{' ' * largura_total_celula}{'↓'.center(largura_total_celula)}{' ' * largura_total_celula}")
    mapa.append(f"{' ' * largura_total_celula}{'|'.center(largura_total_celula)}{' ' * largura_total_celula}")
    
    mapa.append(f"{' ' * largura_total_celula}{celula_borda()}{' ' * largura_total_celula}")
    mapa.append(f"{' ' * largura_total_celula}{celula_conteudo(baixo_nome)}{' ' * largura_total_celula}")
    mapa.append(f"{' ' * largura_total_celula}{celula_borda()}{' ' * largura_total_celula}")

    return "\n".join(mapa)

def gerar_mapa_local_opcao2(id_sala_atual):
    sala_data = carregar_sala_com_vizinhos(id_sala_atual)
    if not sala_data:
        return "Erro ao carregar o mapa."
    return construir_mapa_local_opcao2_ajustada(sala_data)

# Exemplo de uso:
# Supondo que você tenha uma sala com id=1 e vizinhos configurados:
# print(gerar_mapa_local_opcao2_ajustada(1))