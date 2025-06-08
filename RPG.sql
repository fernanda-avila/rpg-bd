CREATE DATABASE RPG;
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
    nome VARCHAR(50) NOT NULL,
    tipo VARCHAR(20),
    nivel INT,
    vida INT,
    fraqueza VARCHAR(20),
    item_drop VARCHAR(50)
);

-- Tabela de itens
CREATE TABLE itens (
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    tipo VARCHAR(20),
    poder INT,
    elemento VARCHAR(20),
    local_encontrado VARCHAR(50)
);

-- Tabela de Continentes
CREATE TABLE continentes (
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    clima VARCHAR(20),
    periculosidade VARCHAR(10)
);

-- Tabela de Reinos
CREATE TABLE reinos (
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    continente_id INT,
    governante VARCHAR(50),
    alinhamento VARCHAR(20),
    FOREIGN KEY (continente_id) REFERENCES continentes(id)
);

-- Tabela de Cidades
CREATE TABLE cidades (
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    reino_id INT,
    populacao INT,
    tipo VARCHAR(20),
    FOREIGN KEY (reino_id) REFERENCES reinos(id)
);

-- Tabela de NPCs (Personagens Não-Jogáveis)
CREATE TABLE npcs (
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    ocupacao VARCHAR(30),
    cidade_id INT,
    importancia VARCHAR(10),
    dialogo TEXT,
    FOREIGN KEY (cidade_id) REFERENCES cidades(id)
);

-- Tabela de Classes de Heróis
CREATE TABLE classes (
    id INT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    tipo VARCHAR(20),
    ataque_base INT,
    defesa_base INT,
    habilidade_unica VARCHAR(50)
);

-- Tabela de Raças
CREATE TABLE racas (
    id INT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    bonus_atributo VARCHAR(30),
    habilidade_racial VARCHAR(50)
);

-- Tabela de Heróis (Jogadores)
CREATE TABLE herois (
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    classe_id INT,
    raca_id INT,
    nivel INT DEFAULT 1,
    experiencia INT DEFAULT 0,
    vida_max INT,
    mana_max INT,
    cidade_natal_id INT,
    FOREIGN KEY (classe_id) REFERENCES classes(id),
    FOREIGN KEY (raca_id) REFERENCES racas(id),
    FOREIGN KEY (cidade_natal_id) REFERENCES cidades(id)
);

-- Tabela de Missões
CREATE TABLE missoes (
    id INT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    tipo VARCHAR(20),
    dificuldade VARCHAR(10),
    nivel_minimo INT,
    cidade_id INT,
    npc_dispensador_id INT,
    recompensa_ouro INT,
    recompensa_exp INT,
    FOREIGN KEY (cidade_id) REFERENCES cidades(id),
    FOREIGN KEY (npc_dispensador_id) REFERENCES npcs(id)
);

-- Tabela de Itens
CREATE TABLE itens (
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    tipo VARCHAR(30),
    raridade VARCHAR(15),
    nivel_requerido INT DEFAULT 1,
    valor INT,
    peso DECIMAL(5,2),
    atributo_principal VARCHAR(20),
    valor_atributo INT
);

-- Tabela de Inventário
CREATE TABLE inventario (
    heroi_id INT,
    item_id INT,
    quantidade INT DEFAULT 1,
    equipado BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (heroi_id, item_id),
    FOREIGN KEY (heroi_id) REFERENCES herois(id),
    FOREIGN KEY (item_id) REFERENCES itens(id)
);

-- Tabela de Inimigos
CREATE TABLE inimigos (
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    tipo VARCHAR(30),
    nivel INT,
    vida INT,
    ataque INT,
    defesa INT,
    experiencia_concedida INT,
    ouro_concedido INT,
    item_drop_id INT,
    localizacao VARCHAR(50),
    FOREIGN KEY (item_drop_id) REFERENCES itens(id)
);

-- Tabela de Habilidades
CREATE TABLE habilidades (
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    tipo VARCHAR(20),
    classe_id INT,
    nivel_requerido INT,
    custo_mana INT,
    dano_base INT,
    descricao TEXT,
    FOREIGN KEY (classe_id) REFERENCES classes(id)
);

-- Tabela de Locais Importantes
CREATE TABLE locais_importantes (
    id INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    tipo VARCHAR(30),
    cidade_id INT,
    descricao TEXT,
    perigo VARCHAR(10),
    FOREIGN KEY (cidade_id) REFERENCES cidades(id)
);

-- Inserção de dados
INSERT INTO locais VALUES
(1, 'Floresta Proibida', 'Floresta', 'Médio', 'Mapa Antigo'),
(2, 'Lago da Lua', 'Lago', 'Alto', 'Tridente Sagrado'),
(3, 'Montanha do Fogo', 'Montanha', 'Extremo', 'Enigma Flamejante'),
(4, 'Templo do Vento', 'Ruína', 'Médio', 'Cristal do Vento'),
(5, 'Castelo das Sombras', 'Castelo', 'Máximo', 'Cristal da Terra');

INSERT INTO inimigos VALUES
(1, 'Lobo da Floresta', 'Animal', 3, 50, 'Fogo', 'Pele de Lobo'),
(2, 'Guardião da Água', 'Espírito', 8, 120, 'Raio', 'Pérola Brilhante'),
(3, 'Golem de Lava', 'Elemental', 12, 200, 'Água', 'Núcleo de Magma'),
(4, 'Mestre dos Ventos', 'Humanoide', 15, 180, 'Terra', 'Asas de Fênix'),
(5, 'Dragão Sombrio', 'Dragão', 25, 400, 'Luz', 'Cristal Elemental');

INSERT INTO itens VALUES
(1, 'Mapa Antigo', 'Mapa', 0, NULL, 'Floresta Proibida'),
(2, 'Tridente Sagrado', 'Arma', 15, 'Água', 'Lago da Lua'),
(3, 'Enigma Flamejante', 'Pergaminho', 0, 'Fogo', 'Montanha do Fogo'),
(4, 'Cristal do Vento', 'Artefato', 30, 'Vento', 'Templo do Vento'),
(5, 'Cristal da Terra', 'Artefato', 30, 'Terra', 'Castelo das Sombras'),
(6, 'Pérola Brilhante', 'Joia', 5, 'Água', 'Guardião da Água'),
(7, 'Núcleo de Magma', 'Mineral', 10, 'Fogo', 'Golem de Lava'),
(8, 'Asas de Fênix', 'Acessório', 20, 'Vento', 'Mestre dos Ventos'),
(9, 'Cristal Elemental', 'Artefato', 50, 'Todos', 'Dragão Sombrio');

-- Continentes
INSERT INTO continentes VALUES
(1, 'Azeroth', 'Temperado', 'Médio'),
(2, 'Nordrassil', 'Frio', 'Alto'),
(3, 'Kalimdor', 'Desértico', 'Extremo'),
(4, 'Pandária', 'Tropical', 'Baixo');

-- Reinos
INSERT INTO reinos VALUES
(1, 'Stormwind', 1, 'Rei Varian', 'Ordem'),
(2, 'Orgrimmar', 3, 'Chefe Guerreiro', 'Caos'),
(3, 'Darnassus', 2, 'Tyrande', 'Neutro'),
(4, 'Vale da Lua', 4, 'Imperador Shaohao', 'Paz');

-- Cidades
INSERT INTO cidades VALUES
(1, 'Ventobravo', 1, 12000, 'Capital'),
(2, 'Vila Noturna', 3, 5000, 'Floresta'),
(3, 'Altamontanha', 2, 8000, 'Montanha'),
(4, 'Templo de Jade', 4, 3000, 'Sagrado');

-- NPCs
INSERT INTO npcs VALUES
(1, 'Archmage Khadgar', 'Mago', 1, 'Alto', 'O tempo está se esgotando, herói...'),
(2, 'Thrall', 'Xamã', 2, 'Alto', 'A Horda é sua família.'),
(3, 'Malfurion', 'Druida', 3, 'Alto', 'A natureza deve ser protegida.'),
(4, 'Chen Stormstout', 'Monge', 4, 'Médio', 'Uma boa cerveja resolve muitos problemas!');

-- Classes
INSERT INTO classes VALUES
(1, 'Guerreiro', 'Físico', 15, 12, 'Grito de Batalha'),
(2, 'Mago', 'Mágico', 20, 8, 'Bola de Fogo'),
(3, 'Ladino', 'Físico', 18, 10, 'Ataque Furtivo'),
(4, 'Druida', 'Híbrido', 14, 14, 'Forma Animal');

-- Raças
INSERT INTO racas VALUES
(1, 'Humano', '+1 Inteligência', 'Diplomacia'),
(2, 'Elfo Noturno', '+1 Agilidade', 'Sombras'),
(3, 'Orc', '+1 Força', 'Fúria Sanguinária'),
(4, 'Pandaren', '+1 Constituição', 'Paz Interior');

-- Heróis (Jogadores)
INSERT INTO herois VALUES
(1, 'Aelric', 1, 1, 5, 2500, 150, NULL, 1),
(2, 'Brienne', 2, 2, 7, 4200, 90, 200, 3),
(3, 'Cedric', 3, 3, 4, 1800, 110, NULL, 2),
(4, 'Darian', 4, 4, 6, 3800, 130, 180, 4);

-- Itens
INSERT INTO itens VALUES
(1, 'Espada de Azeroth', 'Arma', 'Raro', 5, 350, 3.5, 'Força', 3),
(2, 'Cajado do Arquimago', 'Arma', 'Épico', 10, 800, 2.0, 'Inteligência', 5),
(3, 'Armadura de Placas', 'Armadura', 'Incomum', 8, 450, 12.0, 'Defesa', 15),
(4, 'Poção de Cura Superior', 'Consumível', 'Comum', 3, 50, 0.5, 'Cura', 50),
(5, 'Anel da Sombra', 'Acessório', 'Raro', 7, 600, 0.1, 'Destreza', 4),
(6, 'Elmo do Dragão', 'Armadura', 'Lendário', 15, 1200, 5.0, 'Defesa', 25),
(7, 'Adaga Sombria', 'Arma', 'Incomum', 4, 200, 1.0, 'Destreza', 2),
(8, 'Pergaminho de Teleporte', 'Consumível', 'Raro', 5, 300, 0.1, 'Utilidade', NULL);

-- Inimigos
INSERT INTO inimigos VALUES
(1, 'Goblin', 'Humanoide', 3, 50, 8, 50, 10, 4, 'Floresta'),
(2, 'Orc Negro', 'Humanoide', 8, 120, 15, 120, 25, NULL, 'Montanhas'),
(3, 'Dragão Vermelho', 'Dragão', 20, 400, 25, 500, 100, 6, 'Caverna'),
(4, 'Lich Sombrio', 'Morto-Vivo', 15, 250, 18, 300, 75, 2, 'Ruínas'),
(5, 'Aranha Gigante', 'Bestial', 5, 80, 10, 80, 15, 7, 'Floresta');

-- Habilidades
INSERT INTO habilidades VALUES
(1, 'Golpe Poderoso', 'Físico', 1, 1, NULL, 15, 'Ataque básico com arma'),
(2, 'Bola de Fogo', 'Mágico', 2, 3, 20, 30, 'Conjura uma esfera de fogo'),
(3, 'Ataque Furtivo', 'Físico', 3, 2, NULL, 25, 'Ataque pelas costas com dano crítico'),
(4, 'Cura Natural', 'Cura', 4, 5, 15, NULL, 'Restaura vida usando energias naturais');

-- Locais Importantes
INSERT INTO locais_importantes VALUES
(1, 'Torre de Karazhan', 'Torre', 1, 'Antiga torre de magos repleta de segredos', 'Alto'),
(2, 'Cavernas de Nagrand', 'Caverna', 2, 'Reduto de criaturas selvagens', 'Médio'),
(3, 'Templo de Eluna', 'Templo', 3, 'Local sagrado dos elfos noturnos', 'Baixo'),
(4, 'Monastério Tian', 'Monastério', 4, 'Centro de treinamento de monges', 'Médio');

-- Missões
INSERT INTO missoes VALUES
(1, 'Ameaça Goblin', 'Elimine os goblins que atacam as caravanas', 'Caça', 'Fácil', 3, 1, 1, 50, 200),
(2, 'Relíquias Perdidas', 'Recupere os artefatos antigos da caverna', 'Exploração', 'Médio', 5, 2, 2, 120, 500),
(3, 'O Lich Renascido', 'Derrote o lich antes que ele complete seu ritual', 'Boss', 'Difícil', 10, 3, 3, 400, 1500),
(4, 'Entrega Especial', 'Leve o pacote misterioso para a cidade vizinha', 'Entrega', 'Fácil', 2, 4, 4, 30, 100);
