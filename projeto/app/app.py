import psycopg2
from psycopg2 import Error

def connect_to_db():
    conn = None
    try:
        conn = psycopg2.connect(
            host="localhost", # Como estamos acessando do host, usamos localhost
            database="ragnarok", # O nome do banco que você configurou
            user="igris",       # O usuário que você configurou
            password="igris"    # A senha que você configurou
        )
        
        cursor = conn.cursor()

        print("Conectado ao PostgreSQL com sucesso!")

        # Exemplo: Consultar jogadores
        cursor.execute("SELECT id, username, score FROM players;")
        players = cursor.fetchall()
        print("\nJogadores:")
        for player in players:
            print(f"ID: {player[0]}, Username: {player[1]}, Score: {player[2]}")

        # Exemplo: Inserir um novo jogador
        new_username = "novo_jogador"
        new_password_hash = "hash_do_novo_jogador"
        try:
            cursor.execute("INSERT INTO players (username, password_hash) VALUES (%s, %s);",
                           (new_username, new_password_hash))
            conn.commit()
            print(f"\nJogador '{new_username}' inserido com sucesso!")
        except psycopg2.errors.UniqueViolation:
            conn.rollback() # Desfaz a transação em caso de erro
            print(f"\nErro: O jogador '{new_username}' já existe.")
        except Error as e:
            conn.rollback()
            print(f"\nErro ao inserir jogador: {e}")

        # Exemplo: Atualizar a pontuação de um jogador
        update_username = "jogador1"
        new_score = 200
        cursor.execute("UPDATE players SET score = %s WHERE username = %s;",
                       (new_score, update_username))
        conn.commit()
        print(f"\nPontuação de '{update_username}' atualizada para {new_score}.")

        # Consultar novamente para ver a atualização
        cursor.execute("SELECT id, username, score FROM players WHERE username = %s;", (update_username,))
        updated_player = cursor.fetchone()
        if updated_player:
            print(f"ID: {updated_player[0]}, Username: {updated_player[1]}, Nova Pontuação: {updated_player[2]}")


    except Error as e:
        print(f"Erro ao conectar ou operar no PostgreSQL: {e}")
    finally:
        if conn:
            cursor.close()
            conn.close()
            print("Conexão com o PostgreSQL fechada.")

if __name__ == "__main__":
    connect_to_db()