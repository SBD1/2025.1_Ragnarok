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

def execute_query(query, params=None, fetch_one=False, fetch_all=False, commit=False):
    """
    Executa uma query no banco de dados PostgreSQL.
    
    :param query: String da query SQL com placeholders %s.
    :param params: Tupla de parâmetros a serem passados para a query.
    :param fetch_one: Se True, retorna apenas uma linha do resultado.
    :param fetch_all: Se True, retorna todas as linhas do resultado.
    :param commit: Se True, realiza o commit da transação.
    :return: Resultado(s) da consulta SELECT, ou True/False em comandos DML.
    """
    global conn, cursor
    if not conn or not cursor:
        exibir_mensagem("Não há conexão ativa com o banco de dados.", tipo="erro")
        return False
    try:
        cursor.execute(query, params)

        if commit:
            conn.commit()

        if fetch_one:
            return cursor.fetchone()
        elif fetch_all:
            return cursor.fetchall()
        elif query.strip().upper().startswith("SELECT"):
            return cursor.fetchall()  # Retorno padrão para SELECT se nenhum flag for passado
        else:
            return True  # Para INSERT, UPDATE, DELETE sem retorno

    except Error as e:
        if commit:
            conn.rollback()
        exibir_mensagem(f"Erro ao executar query: {e}", tipo="erro")
        return False