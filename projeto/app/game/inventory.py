from db.db_utils import execute_query
from utils.display import exibir_mensagem, limpar_tela 

def listar_inventario(id_personagem):
	while True:
		""" Listar itens do inventário do personagem """
		query = """
SELECT I.id_item, I.tipo_item,
  COALESCE(
  	MAX(A.nome_item),
    MAX(PO.nome_item), MAX(PE.nome_item), MAX(CO.nome_item),
    MAX(CA.nome_item), MAX(BO.nome_item), MAX(AC.nome_item),
    MAX(CAPA.nome_item), MAX(ES.nome_item), MAX(PEIT.nome_item)
  ) AS nome_item,
	MAX(A.tipo_arma),
	MAX(A.dano_base),
	MAX(A.bonus_dano),
	MAX(C.tipo_consumivel),
	MAX(PO.tipo_bonus_atributo),
	MAX(PO.recupera_vida),
	MAX(PO.recupera_mana),
	MAX(AR.tipo_armadura),
  COALESCE(
  	MAX(A.descricao),
    MAX(PO.descricao), MAX(PE.descricao), MAX(CO.descricao),
    MAX(CA.descricao), MAX(BO.descricao), MAX(AC.descricao),
    MAX(CAPA.descricao), MAX(ES.descricao), MAX(PEIT.descricao)
  ) AS descricao,
  COUNT(*) AS qtd,
  MAX(INV.capacidade_slots),
  MAX(INV.slots_usados)
FROM   INVENTARIO      INV
JOIN   INSTANCIA_ITEM  II  ON II.id_inventario  = INV.id_inventario
JOIN   ITEM            I   ON I.id_item         = II.id_item
LEFT  JOIN ARMA        A   ON A.id_item         = I.id_item
LEFT  JOIN CONSUMIVEL  C   ON C.id_item         = I.id_item
LEFT  JOIN POCAO       PO  ON PO.id_consumivel  = C.id_item
LEFT  JOIN PERGAMINHO  PE  ON PE.id_consumivel  = C.id_item
LEFT  JOIN COMIDA      CO  ON CO.id_consumivel  = C.id_item
LEFT  JOIN ARMADURA    AR  ON AR.id_item        = I.id_item
LEFT  JOIN CAPACETE    CA  ON CA.id_armadura    = AR.id_item
LEFT  JOIN BOTA        BO  ON BO.id_armadura    = AR.id_item
LEFT  JOIN ACESSORIO   AC  ON AC.id_armadura    = AR.id_item
LEFT  JOIN CAPA        CAPA ON CAPA.id_armadura = AR.id_item
LEFT  JOIN ESCUDO      ES  ON ES.id_armadura    = AR.id_item
LEFT  JOIN PEITORAL    PEIT ON PEIT.id_armadura = AR.id_item
WHERE  INV.id_personagem = %s
GROUP  BY I.id_item, I.tipo_item;

"""
	
		result = execute_query(query, (id_personagem,), fetch_all=True)
		armas = []
		consumiveis = []
		armaduras = []
		
		if result:

			for item in result:
				if "ARMA" in item[1]:
					armas.append({"id": item[0], "tipo_item": item[1], "nome": item[2], "tipo": item[3], "qtd": item[12], "dano": f"{item[4]}-{item[4]+item[5]}", "descricao": item[11]})
				elif "CONSUMIVEL" in item[1]:
					efeito = (f"Cura: {item[8]}" if "VIDA" in item[7] else f"Mana: {item[9]}") if "POCAO" in item[6] else None
					consumiveis.append({"id": item[0], "tipo_item": item[1], "nome": item[2], "tipo": item[6], "qtd": item[12], "efeito": efeito, "descricao": item[11]})
				elif "ARMADURA" in item[1]:
					armaduras.append({"id": item[0], "tipo_item": item[1], "nome": item[2], "tipo": item[10], "qtd": item[12], "descricao": item[11]})
			
			limpar_tela()
			print("╔═══════════════════════╗")
			print("║     🧭 INVENTÁRIO     ║")
			print("╚═══════════════════════╝\n")

			print("🗡️ ARMAS:")
			if len(armas) == 0:
				print()
				print("  Você não possui armas 😅")
			else:
				for item in armas:
					print(f"  {item['id']}. {item['nome']:<18} x{item['qtd']}  | Dano: {item['dano']}")
			print()

			print("🧪 CONSUMÍVEIS:")
			if len(consumiveis) == 0:
				print()
				print("  Você não possui consumíveis 😅")
			else:
				for item in consumiveis:
					print(f"  {item['id']}. {item['nome']:<18} x{item['qtd']}  | {item['efeito']}")
			print()

			print("🛡️ ARMADURAS:")
			if len(armaduras) == 0:
				print()
				print("  Você não possui armaduras 😅")
			else:
				for item in armaduras:
					print(f"  {item['id']}. {item['nome']:<18} x{item['qtd']}  | ")
			print()

			result = execute_query(
						"SELECT slots_usados, capacidade_slots FROM INVENTARIO WHERE id_personagem = %s",
						(id_personagem,),
						fetch_one=True
					)
			if result:
				print(f"Capacidade do inventário: {result[0]}/{result[1]}\n")

			print("--> O que você quer fazer? <--")
			print("\n  C [número]. Usar o consumível selecionado")
			print("  [número]. Ver detalhes do item selecionado")
			print("\n  S. Sair do inventário")

			opcao = input("\n> ").strip().upper()
			if opcao.startswith('C'):
				numero = opcao.split(' ')
				achou = False
				for i in numero:
					if i.isdigit():
						for item in consumiveis:
							if item['id'] == int(i):
								achou = True
								consumir_item(id_personagem, item)
								break
				if not achou:
					print("\nOpção não implementada ainda.")
					print("Pressione ENTER para continuar...")
					input()
			elif opcao.isdigit():
				item = None

				for i in armas:
					if str(i['id']) == opcao:
						item = i
				for i in consumiveis:
					if str(i['id']) == opcao:
						item = i
				for i in armaduras:
					if str(i['id']) == opcao:
						item = i

				if not item:
					print("\nOpção inválida! Aperte ENTER para continuar...")
					input()
				else:
					mostrar_descricao_item(item)
			elif opcao == 'S':
				break
			else:
				print("\nOpção inválida! Aperte ENTER para continuar...")
				input()
		else:
			exibir_mensagem(f"Erro ao listar o inventário do personagem.", tipo="erro")

def mostrar_descricao_item(item):
	"""
	Imprime um cartão com as características do item.
	Espera um dicionário com: nome, emoji, tipo, raridade,
	atributos (dano/defesa/etc), peso e descrição.
	"""
	BORDER_COLOR = "\033[33m"   # amarelo
	TITLE_COLOR  = "\033[36m"   # ciano
	RESET        = "\033[0m"
	LINE         = "═" * 32
	emoji = "🗡️" if "ARMA" in item['tipo_item'] else ("🧪" if "CONSUMIVEL" in item['tipo_item'] else "🛡️")
 
	limpar_tela()

	# cabeçalho
	titulo = f"{emoji}  {item['nome'].upper()}"
	print(f"{BORDER_COLOR}║{RESET} {TITLE_COLOR}{titulo}{RESET}")
	print(f"{BORDER_COLOR}║{RESET}")

	# atributos principais
	print(f"{BORDER_COLOR}║{RESET} Tipo        : {item['tipo'].replace('_', ' ').lower()}")
	print(f"{BORDER_COLOR}║{RESET} Quantidade  : {item['qtd']}")

	if "ARMA" in item['tipo_item']:
		print(f"{BORDER_COLOR}║{RESET} Dano        : {item['dano']}")

	if "POCAO" in item['tipo']:
		print(f"{BORDER_COLOR}║{RESET} {item['efeito'].replace(':', '        :')}")

	# rodapé
	print(f"\n📜 Descrição:\n\n  {item['descricao']}\n")
	input("Pressione ENTER para continuar...")

def consumir_item(id_personagem, item):
	consumir = """
WITH alvo AS (
    SELECT ii.id_instancia_item
    FROM   INSTANCIA_ITEM  AS ii
    JOIN   INVENTARIO      AS inv
           ON inv.id_inventario = ii.id_inventario
    WHERE  inv.id_personagem = %s
      AND  ii.id_item        = %s
    ORDER BY ii.id_instancia_item
    LIMIT 1
)
DELETE FROM INSTANCIA_ITEM
WHERE id_instancia_item IN (SELECT id_instancia_item FROM alvo);
"""

	print(f"\nDeseja mesmo consumir um(a) {item['nome']}? (S/n)")

	escolha = input("> ").strip().upper()

	if escolha == 'N':
		return
	elif escolha != 'S':
		print("\nOpção inválida! Pressione ENTER para continuar...")
		input()
		return
	
	if 'POCAO' in item['tipo']:
		if 'Cura' in item['efeito']:
			query = """
UPDATE PERSONAGEM
	SET vida = vida + %s
WHERE id_personagem = %s
"""
			vida = str(item['efeito']).split(' ')
			for i in vida:
				if i.isdigit():
					vida = int(i)
					break
			execute_query(query, (vida, id_personagem,))
			execute_query(consumir, (id_personagem, int(item['id']),))
			print(f"Curado {vida} de vida com sucesso!")
			input("Pressione ENTER para continuar...")
		elif 'Mana' in item['efeito']:
			query = """
UPDATE PERSONAGEM
	SET mana = mana + %s
WHERE id_personagem = %s
"""
			mana = str(item['efeito']).split(' ')
			for i in mana:
				if i.isdigit():
					mana = int(i)
					break
			execute_query(query, (mana, id_personagem))
			execute_query(consumir, (id_personagem, int(item['id']),))
			print(f"Recuperada {mana} de mana com sucesso!")
			input("Pressione ENTER para continuar...")
	else:
		print("Somente possível consumir poções por enquanto!")
		input("Pressione ENTER para continuar...")
		

