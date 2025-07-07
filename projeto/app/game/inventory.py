from db.db_utils import execute_query
from utils.display import exibir_mensagem, limpar_tela 

def listar_inventario(id_personagem):
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
  COUNT(*) AS qtd
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