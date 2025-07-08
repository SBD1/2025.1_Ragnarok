from db.db_utils import execute_query
from utils.display import limpar_tela, exibir_mensagem


def comprar_item(id_personagem):
    """
    Lista os NPCs vendedores disponíveis na sala atual do personagem,
    permitindo o jogador comprar um item se tiver dinheiro e espaço.
    """
    limpar_tela()
    print("--- 🛒 LOJA DE ITENS ---\n")

    # Mostrar saldo atual do personagem
    query_dinheiro = "SELECT dinheiro FROM PERSONAGEM WHERE id_personagem = %s;"
    saldo = execute_query(query_dinheiro, (id_personagem,), fetch_one=True)
    if saldo:
        print(f"Seu dinheiro atual: 💰 {saldo[0]} zeny\n")

    # Pega sala atual do personagem
    query_sala = "SELECT id_sala FROM PERSONAGEM WHERE id_personagem = %s;"
    sala_result = execute_query(query_sala, (id_personagem,), fetch_one=True)

    if not sala_result:
        exibir_mensagem("Não foi possível identificar a sala atual.", tipo="erro")
        return

    id_sala_atual = sala_result[0]

    # Lista os NPCs vendedores na mesma sala
    query_npcs = """
    SELECT NV.id_npc_vendedor, N.nome, S.nome_sala
    FROM NPC_VENDEDOR NV
    JOIN NPC N ON N.id_npc = NV.id_npc_vendedor
    JOIN SALA S ON S.id_sala = N.id_sala
    WHERE N.id_sala = %s
    ORDER BY N.nome;
    """
    npcs = execute_query(query_npcs, (id_sala_atual,), fetch_all=True)

    if not npcs:
        exibir_mensagem("Não há vendedores nesta sala.", tipo="erro")
        return

    print("Vendedores nesta sala:")
    for npc in npcs:
        print(f"  {npc[0]}. {npc[1]} (local: {npc[2]})")

    try:
        id_npc = int(input("\nDigite o ID do vendedor com quem deseja negociar: "))
    except ValueError:
        exibir_mensagem("Entrada inválida.", tipo="erro")
        return

    # Listar os itens vendidos pelo NPC
    query_itens = """
    SELECT I.id_item,
           COALESCE(A.nome_item, PO.nome_item, PE.nome_item, CO.nome_item, 
                    CA.nome_item, BO.nome_item, AC.nome_item, CAPA.nome_item, ES.nome_item, PEIT.nome_item) AS nome_item,
           COALESCE(A.custo_item, PO.custo_item, PE.custo_item, CO.custo_item, 
                    CA.custo_item, BO.custo_item, AC.custo_item, CAPA.custo_item, ES.custo_item, PEIT.custo_item) AS preco
    FROM NPC_VENDEDOR NV
    JOIN VENDE_ESTOQUE_ITEM VEI ON VEI.id_estoque = NV.id_estoque
    JOIN ITEM I ON I.id_item = VEI.id_item
    LEFT JOIN ARMA A ON A.id_item = I.id_item
    LEFT JOIN POCAO PO ON PO.id_consumivel = I.id_item
    LEFT JOIN PERGAMINHO PE ON PE.id_consumivel = I.id_item
    LEFT JOIN COMIDA CO ON CO.id_consumivel = I.id_item
    LEFT JOIN CAPACETE CA ON CA.id_armadura = I.id_item
    LEFT JOIN BOTA BO ON BO.id_armadura = I.id_item
    LEFT JOIN ACESSORIO AC ON AC.id_armadura = I.id_item
    LEFT JOIN CAPA CAPA ON CAPA.id_armadura = I.id_item
    LEFT JOIN ESCUDO ES ON ES.id_armadura = I.id_item
    LEFT JOIN PEITORAL PEIT ON PEIT.id_armadura = I.id_item
    WHERE NV.id_npc_vendedor = %s;
    """

    itens = execute_query(query_itens, (id_npc,), fetch_all=True)

    if not itens:
        exibir_mensagem("Esse vendedor não possui itens.", tipo="erro")
        return

    print("\nItens à venda:")
    for item in itens:
        print(f"  {item[0]}. {item[1]} - 💰 {item[2]} zeny")

    try:
        id_item = int(input("\nDigite o ID do item que deseja comprar: "))
    except ValueError:
        exibir_mensagem("Entrada inválida.", tipo="erro")
        return

    # Executa a compra via stored procedure
    result = execute_query("SELECT comprar_item(%s, %s, %s);", (id_personagem, id_item, id_npc), fetch_one=True, commit=True)

    if result:
        mensagem = result[0]
        if "sucesso" in mensagem.lower():
            exibir_mensagem(mensagem, tipo="sucesso")
        else:
            exibir_mensagem(mensagem, tipo="erro")
    else:
        exibir_mensagem("Erro ao tentar comprar o item.", tipo="erro")
