import psycopg2
from psycopg2 import Error
from utils.display import exibir_mensagem

# Variáveis globais para a conexão com o banco de dados
conn = None
cursor = None

def connect_to_db():
    """Tenta conectar ao banco de dados PostgreSQL."""
    global conn, cursor
    try:
        conn = psycopg2.connect(
            host="localhost",
            database="ragnarok",
            user="igris",
            password="igris"
        )
        cursor = conn.cursor()
        return True
    except Error as e:
        exibir_mensagem(f"Erro ao conectar ao PostgreSQL: {e}", tipo="erro")
        return False

def close_db_connection():
    """Fecha a conexão com o banco de dados PostgreSQL."""
    global conn, cursor
    if cursor:
        cursor.close()
    if conn:
        conn.close()
    exibir_mensagem("Conexão com o PostgreSQL fechada.", tipo="info")

def execute_query(query, params=None, fetch_one=False, commit=False):
    """
    Executa uma query no banco de dados.
    :param query: A string da query SQL.
    :param params: Uma tupla de parâmetros para a query (usar %s).
    :param fetch_one: Se True, tenta retornar apenas uma linha.
                      Se False, tenta retornar todas as linhas.
                      Usado para SELECTs e para queries com RETURNING.
    :param commit: Se True, faz commit da transação (para INSERT, UPDATE, DELETE).
    :return: Os resultados da query (se houver e for solicitada a busca) ou True/False para DMLs.
    """
    global conn, cursor
    if not conn or not cursor:
        exibir_mensagem("Não há conexão ativa com o banco de dados.", tipo="erro")
        return False
    try:
        cursor.execute(query, params)
        if commit:
            conn.commit()

            return cursor.fetchone()
        elif query.strip().upper().startswith("SELECT"):
            return cursor.fetchall()
        else:
            return True

    except Error as e:
        if commit:
            conn.rollback()
        exibir_mensagem(f"Erro ao executar query: {e}", tipo="erro")
        return False