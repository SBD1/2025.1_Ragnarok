import random
from utils.display import exibir_mensagem, limpar_tela
from db.db_utils import execute_query

# --- Funções Auxiliares para Cálculo de Combate ---

def calcular_dano(atacante, defensor):
    """
    Calcula o dano baseado em ataque, defesa, precisão, esquiva e crítico.
    atacante e defensor devem ser dicionários/objetos com os atributos relevantes.
    """
    dano_base = atacante['ataque']
    defesa_alvo = defensor['defesa']
    
    
    chance_acerto = max(10, min(90, atacante['precisao'] - defensor['esquiva'] + 50)) 
    if random.randint(1, 100) > chance_acerto:
        exibir_mensagem(f"{atacante['nome']} errou o ataque em {defensor['nome']}!", tipo="info")
        return 0

    
    dano_critico = 0
    chance_critico = atacante.get('critico', 0)
    if random.randint(1, 100) <= chance_critico:
        dano_critico = dano_base * 0.5 
        exibir_mensagem(f"ATAQUE CRÍTICO de {atacante['nome']}!", tipo="alerta")

    dano_final = max(1, dano_base - defesa_alvo) + dano_critico 

    return int(dano_final)

def calcular_dano_habilidade(habilidade, atacante, defensor):
    """
    Calcula o dano de uma habilidade, considerando ataque mágico e defesa mágica.
    """
    dano_base_habilidade = habilidade['dano']
    ataque_magico_atacante = atacante.get('ataque_magico', 0)
    defesa_magica_alvo = defensor.get('defesa_magica', 0)

    dano_final = max(1, dano_base_habilidade + ataque_magico_atacante - defesa_magica_alvo)
    return int(dano_final)

# --- Funções para Interação com o Banco de Dados ---

def carregar_personagem_combate(id_personagem):
    """Carrega todos os atributos necessários do personagem para o combate."""
    query = """
        SELECT
            p.id_personagem, p.nome, p.vida, p.mana, p.ataque, p.defesa,
            p.precisao, p.esquiva, p.critico, p.velocidade, p.nivel, p.dinheiro,
            p.ataque_magico, p.id_sala,
            p.vitalidade, -- ADICIONADO: vitalidade
            p.inteligencia -- ADICIONADO: inteligencia
        FROM PERSONAGEM p
        WHERE p.id_personagem = %s
    """
    personagem_data = execute_query(query, (id_personagem,), fetch_one=True)
    if not personagem_data:
        return None
    
    personagem = {
        'id': personagem_data[0],
        'nome': personagem_data[1],
        'vida': personagem_data[2],
        'mana': personagem_data[3],
        'ataque': personagem_data[4],
        'defesa': personagem_data[5],
        'precisao': personagem_data[6],
        'esquiva': personagem_data[7],
        'critico': personagem_data[8],
        'velocidade': personagem_data[9],
        'nivel': personagem_data[10],
        'dinheiro': personagem_data[11],
        'ataque_magico': personagem_data[12],
        'id_sala': personagem_data[13],
        'vitalidade': personagem_data[14],
        'inteligencia': personagem_data[15]
    }
    return personagem

def carregar_inimigos_sala(id_sala):
    """Carrega todas as instâncias de NPCs combatentes VIVOS na sala."""
    query = """
        SELECT
            inc.id_instancia, n.nome, inc.vida_atual, nc.ataque, nc.defesa,
            nc.nivel, nc.precisao, nc.esquiva, nc.defesa_magica, nc.tamanho,
            nc.raca
            -- Removido 'nc.velocidade' daqui, já que não existe na tabela
        FROM INSTANCIA_NPC_COMBATENTE inc
        JOIN NPC_COMBATENTE nc ON inc.id_npc_combatente = nc.id_npc_combatente
        JOIN NPC n ON nc.id_npc_combatente = n.id_npc
        WHERE inc.status_npc = 'VIVO' AND n.id_sala = %s
    """
    inimigos_data = execute_query(query, (id_sala,), fetch_all=True)
    
    inimigos = []
    for inimigo_tuple in inimigos_data:
        
        velocidade_padrao_npc = 10 
        
        inimigos.append({
            'id_instancia': inimigo_tuple[0],
            'nome': inimigo_tuple[1],
            'vida_atual': inimigo_tuple[2],
            'ataque': inimigo_tuple[3],
            'defesa': inimigo_tuple[4],
            'nivel': inimigo_tuple[5],
            'precisao': inimigo_tuple[6],
            'esquiva': inimigo_tuple[7],
            'defesa_magica': inimigo_tuple[8],
            'tamanho': inimigo_tuple[9],
            'raca': inimigo_tuple[10],
            'velocidade': velocidade_padrao_npc,
            'tipo': 'NPC_COMBATENTE' 
        })
    return inimigos

def carregar_habilidades_personagem(id_personagem, nivel_personagem):
    """
    Carrega as habilidades do personagem baseadas na sua classe
    e nível mínimo requerido.
    """
    query = """
        SELECT
            h.id_habilidade, h.nome_habilidade, h.descricao, h.custo_mana, h.dano
        FROM HABILIDADE h
        JOIN PERTENCE_PERSONAGEM_CLASSE ppc ON h.id_classe = ppc.id_classe
        WHERE ppc.id_personagem = %s AND h.nivel_requerido <= %s
        ORDER BY h.nivel_requerido, h.nome_habilidade;
    """
    habilidades_data = execute_query(query, (id_personagem, nivel_personagem), fetch_all=True)
    
    habilidades = []
    for hab_tuple in habilidades_data:
        habilidades.append({
            'id_habilidade': hab_tuple[0],
            'nome': hab_tuple[1],
            'descricao': hab_tuple[2],
            'custo_mana': hab_tuple[3],
            'dano': hab_tuple[4]
        })
    return habilidades

def atualizar_vida_personagem(id_personagem, nova_vida):
    """Atualiza a vida do personagem no banco de dados."""
    execute_query("""
        UPDATE PERSONAGEM
        SET vida = %s
        WHERE id_personagem = %s
    """, (max(0, nova_vida), id_personagem), commit=True)

def atualizar_mana_personagem(id_personagem, nova_mana):
    """Atualiza a mana do personagem no banco de dados."""
    execute_query("""
        UPDATE PERSONAGEM
        SET mana = %s
        WHERE id_personagem = %s
    """, (max(0, nova_mana), id_personagem), commit=True)

def atualizar_vida_inimigo(id_instancia_inimigo, nova_vida):
    """Atualiza a vida de uma instância de NPC combatente no banco de dados."""
    execute_query("""
        UPDATE INSTANCIA_NPC_COMBATENTE
        SET vida_atual = %s
        WHERE id_instancia = %s
    """, (max(0, nova_vida), id_instancia_inimigo), commit=True)

def marcar_inimigo_morto(id_instancia_inimigo):
    """Marca uma instância de NPC combatente como 'MORTO'."""
    execute_query("""
        UPDATE INSTANCIA_NPC_COMBATENTE
        SET status_npc = 'MORTO', vida_atual = 0
        WHERE id_instancia = %s
    """, (id_instancia_inimigo,), commit=True)

def conceder_recompensa(personagem, inimigo_nivel):
    """Calcula e concede XP e dinheiro ao personagem."""
    xp_ganho = inimigo_nivel * 10 + random.randint(5, 15) 
    dinheiro_ganho = inimigo_nivel * 5 + random.randint(1, 10) 

    exibir_mensagem(f"Você ganhou {xp_ganho} de experiência e {dinheiro_ganho} de dinheiro!", tipo="sucesso")
    
    execute_query("UPDATE PERSONAGEM SET dinheiro = dinheiro + %s WHERE id_personagem = %s",
                  (dinheiro_ganho, personagem['id']), commit=True)
    personagem['dinheiro'] += dinheiro_ganho

# --- Lógica Principal de Combate ---

def iniciar_combate(id_personagem):
    """Lógica principal de combate contra NPCs combatentes da sala atual."""
    
    personagem = carregar_personagem_combate(id_personagem)
    if not personagem:
        exibir_mensagem("Personagem não encontrado.", tipo="erro")
        return

    while True: 
        inimigos_vivos = carregar_inimigos_sala(personagem['id_sala'])
        
        if not inimigos_vivos:
            exibir_mensagem("Não há mais inimigos para combater nesta sala.", tipo="info")
            break 

        exibir_mensagem("\n--- INIMIGOS NA SALA ---", tipo="titulo")
        for i, inimigo in enumerate(inimigos_vivos):
            exibir_mensagem(f"{i + 1}. {inimigo['nome']} (Nível {inimigo['nivel']}) - Vida: {inimigo['vida_atual']}", tipo="info")

        escolha_alvo = input("\nEscolha o número do inimigo para atacar (ou 'F' para tentar fugir): ").strip().upper()

        if escolha_alvo == 'F':
            exibir_mensagem("Tentando fugir...", tipo="info")
           
            if random.randint(1, 100) > 50:
                exibir_mensagem("Você conseguiu fugir!", tipo="sucesso")
                return 
            else:
                exibir_mensagem("A fuga falhou! O inimigo te alcançou.", tipo="erro")
                

        try:
            indice_alvo = int(escolha_alvo) - 1
            if not (0 <= indice_alvo < len(inimigos_vivos)):
                raise ValueError
            inimigo_alvo = inimigos_vivos[indice_alvo]
        except ValueError:
            exibir_mensagem("Escolha de inimigo inválida.", tipo="erro")
            continue

        exibir_mensagem(f"\nCOMBATE: {personagem['nome']} (Vida: {personagem['vida']}, Mana: {personagem['mana']}) vs. {inimigo_alvo['nome']} (Vida: {inimigo_alvo['vida_atual']})", tipo="alerta")

       
        while personagem['vida'] > 0 and inimigo_alvo['vida_atual'] > 0:
           
            if personagem['velocidade'] >= inimigo_alvo['velocidade']: 
                turno_jogador(personagem, inimigo_alvo)
                if inimigo_alvo['vida_atual'] <= 0:
                    break
                turno_inimigo(personagem, inimigo_alvo)
            else:
                turno_inimigo(personagem, inimigo_alvo)
                if personagem['vida'] <= 0:
                    break
                turno_jogador(personagem, inimigo_alvo)
            
           
            input("\nPressione Enter para o próximo turno...")
            limpar_tela() 

       
        if personagem['vida'] <= 0:
            exibir_mensagem("Você foi derrotado! Recuperando no hospital da cidade...", tipo="erro")
            execute_query("""
                UPDATE PERSONAGEM
                SET vida = 100, mana = 10, id_sala = 1
                WHERE id_personagem = %s
            """, (personagem['id'],), commit=True)
            return
        
        elif inimigo_alvo['vida_atual'] <= 0:
            exibir_mensagem(f"Você derrotou o {inimigo_alvo['nome']}!", tipo="sucesso")
            marcar_inimigo_morto(inimigo_alvo['id_instancia'])
            conceder_recompensa(personagem, inimigo_alvo['nivel'])
            
            atualizar_vida_personagem(personagem['id'], personagem['vida'])
            atualizar_mana_personagem(personagem['id'], personagem['mana'])
            
            
def turno_jogador(personagem, inimigo):
    """Gerencia as ações do jogador em seu turno."""
    exibir_mensagem(f"\n--- SEU TURNO ({personagem['nome']}) ---", tipo="info")
    exibir_mensagem(f"Sua Vida: {personagem['vida']}/{personagem['vitalidade']*10} | Mana: {personagem['mana']}/{personagem['inteligencia']*5}", tipo="info")
    exibir_mensagem(f"Vida do {inimigo['nome']}: {inimigo['vida_atual']}", tipo="info")

    print("\nEscolha sua ação:")
    print("1. Atacar")
    print("2. Habilidades")

    escolha_acao = input("> ").strip()

    if escolha_acao == '1':
        dano = calcular_dano(personagem, inimigo)
        inimigo['vida_atual'] -= dano
        atualizar_vida_inimigo(inimigo['id_instancia'], inimigo['vida_atual'])
        exibir_mensagem(f"Você ataca o {inimigo['nome']} e causa {dano} de dano. Vida do {inimigo['nome']}: {max(0, inimigo['vida_atual'])}", tipo="sucesso")
    
    elif escolha_acao == '2':
        habilidades = carregar_habilidades_personagem(personagem['id'], personagem['nivel'])
        if not habilidades:
            exibir_mensagem("Você não tem habilidades disponíveis ou mana suficiente para usá-las.", tipo="aviso")
            return
        
        exibir_mensagem("\n--- SUAS HABILIDADES ---", tipo="titulo")
        for i, hab in enumerate(habilidades):
            print(f"{i+1}. {hab['nome']} (Custo: {hab['custo_mana']} Mana) - {hab['descricao']}")
        
        escolha_habilidade = input("Escolha o número da habilidade: ").strip()
        try:
            indice_habilidade = int(escolha_habilidade) - 1
            if not (0 <= indice_habilidade < len(habilidades)):
                raise ValueError
            habilidade_selecionada = habilidades[indice_habilidade]
        except ValueError:
            exibir_mensagem("Escolha de habilidade inválida.", tipo="erro")
            return

        if personagem['mana'] >= habilidade_selecionada['custo_mana']:
            dano_habilidade = calcular_dano_habilidade(habilidade_selecionada, personagem, inimigo)
            personagem['mana'] -= habilidade_selecionada['custo_mana']
            inimigo['vida_atual'] -= dano_habilidade
            atualizar_mana_personagem(personagem['id'], personagem['mana'])
            atualizar_vida_inimigo(inimigo['id_instancia'], inimigo['vida_atual'])
            exibir_mensagem(f"Você usa {habilidade_selecionada['nome']} em {inimigo['nome']} e causa {dano_habilidade} de dano. Vida do {inimigo['nome']}: {max(0, inimigo['vida_atual'])}", tipo="sucesso")
        else:
            exibir_mensagem("Mana insuficiente para usar esta habilidade!", tipo="aviso")
    else:
        exibir_mensagem("Ação inválida. Você perdeu o turno.", tipo="erro")


def turno_inimigo(personagem, inimigo):
    """Gerencia as ações do inimigo em seu turno."""
    if inimigo['vida_atual'] <= 0:
        return
        
    exibir_mensagem(f"\n--- TURNO DO INIMIGO ({inimigo['nome']}) ---", tipo="info")
    dano = calcular_dano(inimigo, personagem)
    personagem['vida'] -= dano
    atualizar_vida_personagem(personagem['id'], personagem['vida'])
    exibir_mensagem(f"O {inimigo['nome']} ataca você e causa {dano} de dano. Sua vida: {max(0, personagem['vida'])}", tipo="perigo")