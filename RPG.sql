CREATE DATABASE RPG;
USE RPG;

-- Tabela de itens
CREATE TABLE itens (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    poder INT DEFAULT 0,
    elemento VARCHAR(50),
    origem VARCHAR(100)
);

-- Tabela de locais
CREATE TABLE locais (
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    tipo VARCHAR(20),
    perigo VARCHAR(10),
    item_importante VARCHAR(50)
);

-- Tabela de inimigos
CREATE TABLE inimigos (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    tipo VARCHAR(50),
    nivel INT,
    vida INT,
    ataque INT,
    defesa INT,
    experiencia_concedida INT,
    ouro_concedido INT,
    item_drop_id INT,
    localizacao VARCHAR(100),
    FOREIGN KEY (item_drop_id) REFERENCES itens(id)
);

-- Inserção de locais
INSERT INTO locais VALUES
(1, 'Floresta Proibida', 'Floresta', 'Médio', 'Mapa Antigo'),
(2, 'Lago da Lua', 'Lago', 'Alto', 'Tridente Sagrado'),
(3, 'Montanha do Fogo', 'Montanha', 'Extremo', 'Enigma Flamejante'),
(4, 'Templo do Vento', 'Ruína', 'Médio', 'Cristal do Vento'),
(5, 'Castelo das Sombras', 'Castelo', 'Máximo', 'Cristal da Terra');

-- Inserção de itens
INSERT INTO itens VALUES
(1, 'Mapa Antigo', 'Mapa', 0, NULL, 'Floresta Proibida'),
(2, 'Tridente Sagrado', 'Arma', 15, 'Água', 'Lago da Lua'),
(3, 'Enigma Flamejante', 'Pergaminho', 0, 'Fogo', 'Montanha do Fogo'),
(4, 'Cristal do Vento', 'Artefato', 30, 'Vento', 'Templo do Vento'),
(5, 'Cristal da Terra', 'Artefato', 30, 'Terra', 'Castelo das Sombras');

-- Inserção de inimigos
INSERT INTO inimigos VALUES
(1, 'Lobo da Floresta', 'Animal', 3, 50, 8, 3, 60, 15, 1, 'Floresta Central'),
(2, 'Guardião da Água', 'Espírito', 8, 120, 18, 10, 150, 50, 2, 'Templo Submerso'),
(3, 'Golem de Lava', 'Elemental', 12, 200, 25, 20, 300, 80, 3, 'Montanha Vulcânica'),
(4, 'Mestre dos Ventos', 'Humanoide', 15, 180, 30, 25, 400, 100, 4, 'Penhasco Celeste'),
(5, 'Dragão Sombrio', 'Dragão', 25, 400, 50, 40, 1000, 500, 5, 'Covil Sombrio');
