/*
SCRIPT DE CRIAÇÃO E CARREGAMENTO DOS DADOS, COLE UMA COPIA DA PASTA csv para:
C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/
esta pasta e um local de onde o MYSQL consegue importar os arquivos sem mais configura;'oes de segurança
rode o comando 
SHOW VARIABLES LIKE 'secure_file_priv';
para saber onde essa pasta está no seu sistema para saber onde colar os arquivos
*/

CREATE DATABASE db_brasileirao_kaique;
CREATE SCHEMA Exercicio;
USE db_brasileirao_kaique;
CREATE TABLE Exercicio.PARTIDAS (
partida_id INT PRIMARY KEY,
rodada INT, 
data DATE,
hora TIME,
mandante VARCHAR(250),
visitante VARCHAR(250),
tecnico_mandante VARCHAR(250),
tecnico_visitante VARCHAR(250),
vencedor VARCHAR(250),
arena VARCHAR(250),
mandante_placar INT,
visitante_placar INT,
mandante_estado VARCHAR(2),
visitante_estado VARCHAR(2)
);
/*
Copie a pasta cvs para o diretório seguro do MySQL
*/
SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/csv/partidas.csv'
INTO TABLE Exercicio.PARTIDAS
FIELDS TERMINATED BY ','  -- Indica que os campos no arquivo CSV são separados por vírgulas
LINES TERMINATED BY '\n' -- Indica que cada linha termina com uma quebra de linha
IGNORE 1 LINES;          -- Pula a primeira linha, que geralmente contém cabeçalhos de coluna

CREATE TABLE Exercicio.GOLS (
gol_id INT AUTO_INCREMENT PRIMARY KEY,
partida_id INT,
clube VARCHAR(150),
atleta VARCHAR(250),
minuto VARCHAR(20),
tipo_de_gol VARCHAR(100),
CONSTRAINT FK_PartidaGols FOREIGN KEY (partida_id)
    REFERENCES Exercicio.PARTIDAS(partida_id)
);

-- Carrega os dados do CSV, pulando a coluna gol_id
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/csv/gols.csv'
INTO TABLE Exercicio.GOLS
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n' 
IGNORE 1 LINES            
(partida_id,clube, atleta, minuto, @tipo_de_gol)       -- caso a coluna esteja vazia carrega como null
SET tipo_de_gol = NULLIF(@tipo_de_gol, '');

CREATE TABLE Exercicio.CARTOES (
cartoes_id INT AUTO_INCREMENT PRIMARY KEY,
partida_id INT,
clube VARCHAR(150),
cartao VARCHAR(150),
atleta VARCHAR(150),
posicao VARCHAR(150),
minuto VARCHAR(20),
CONSTRAINT FK_PartidaCartoes FOREIGN KEY (partida_id)
    REFERENCES Exercicio.PARTIDAS(partida_id)
)
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/csv/cartoes.csv'
INTO TABLE Exercicio.CARTOES
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n' 
IGNORE 1 LINES            
(partida_id,clube,cartao,atleta,posicao,minuto);       -- caso a coluna esteja vazia carrega como null

drop table Exercicio.ESTATISTICAS

CREATE TABLE IF NOT EXISTS Exercicio.ESTATISTICAS (
    estatisticas_id INT AUTO_INCREMENT PRIMARY KEY,
    partida_id INT,
    clube VARCHAR(150),
    chutes INT,
    posse_de_bola DOUBLE,
    passes INT,
    precisao_passes FLOAT,
    faltas INT,
    impedimentos INT,
    escanteios INT,
    CONSTRAINT FK_PartidaEstatisticas FOREIGN KEY (partida_id)
    REFERENCES Exercicio.PARTIDAS(partida_id)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/csv/estatisticas.csv' 
INTO TABLE Exercicio.ESTATISTICAS
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(partida_id, clube, chutes, @posse_de_bola, passes, @precisao_passes, faltas, impedimentos, escanteios)
SET precisao_passes = NULLIF(@tipo_de_gol, 0), posse_de_bola = NULLIF(@posse_de_bola, 0);


