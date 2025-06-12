-- Criação da tabela de jogadores
CREATE TABLE IF NOT EXISTS players (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    score INT DEFAULT 0
);

-- Criação da tabela de itens (exemplo)
CREATE TABLE IF NOT EXISTS items (
    item_id SERIAL PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    description TEXT,
    value INT
);

-- Inserindo alguns dados de exemplo (opcional)
INSERT INTO players (username, password_hash, score) VALUES
('jogador1', 'hash_exemplo_123', 100),
('jogador2', 'hash_exemplo_456', 150);