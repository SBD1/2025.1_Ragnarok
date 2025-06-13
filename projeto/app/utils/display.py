import os
import time # Para os atrasos da animação
import sys  # Para forçar a impressão imediata

def limpar_tela():
    """Limpa o console para uma melhor experiência."""
    os.system('cls' if os.name == 'nt' else 'clear')

def exibir_mensagem(mensagem, tipo="info"):
    """Exibe mensagens formatadas para o usuário."""
    if tipo == "sucesso":
        print(f"\n✅ {mensagem}")
    elif tipo == "erro":
        print(f"\n❌ {mensagem}")
    else: # info
        print(f"\nℹ️ {mensagem}")
    input("Pressione Enter para continuar...") # Pausa para o usuário ler a mensagem
    limpar_tela()

def animate_logo(logo_string, delay_per_line=0.08):
    """
    Anima a exibição da logo no terminal, linha por linha.
    :param logo_string: A string da logo ASCII Art completa.
    :param delay_per_line: O atraso em segundos entre a exibição de cada linha.
    """
    limpar_tela() # Limpa a tela antes de começar a animação
    lines = logo_string.split('\n')
    for line in lines:
        print(line)
        sys.stdout.flush() # Garante que a linha seja exibida imediatamente
        time.sleep(delay_per_line) # Espera um pouco antes de imprimir a próxima linha
    time.sleep(0.5) # Um pequeno atraso no final para a logo permanecer visível
    # Não limpa a tela aqui para permitir que o main.py imprima o menu logo em seguida.
    # A limpeza será feita antes de cada interação do menu principal.