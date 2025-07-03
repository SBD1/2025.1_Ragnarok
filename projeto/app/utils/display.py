import os
import time 
import sys 

def limpar_tela():
    """Limpa o console."""
    os.system('cls' if os.name == 'nt' else 'clear')

def exibir_mensagem(mensagem, tipo="info"):
    """Exibe mensagens formatadas no console."""
    cores = {
        "info": "\033[94m",    # Azul
        "sucesso": "\033[92m", # Verde
        "erro": "\033[91m",    # Vermelho
        "aviso": "\033[93m",   # Amarelo
        "titulo": "\033[95m",  # Magenta
        "perigo": "\033[91m",  # Vermelho
        "reset": "\033[0m"     # Reseta a cor
    }
    
    print(f"{cores.get(tipo, cores['reset'])}{mensagem}{cores['reset']}")
    time.sleep(1.5) 

def animate_logo(logo_string, delay_per_line=0.08):
    """
    Anima a exibição da logo no terminal, linha por linha.
    :param logo_string: A string da logo ASCII Art completa.
    :param delay_per_line: O atraso em segundos entre a exibição de cada linha.
    """
    limpar_tela() 
    lines = logo_string.split('\n')
    for line in lines:
        print(line)
        sys.stdout.flush()
        time.sleep(delay_per_line)
    time.sleep(1.5) 