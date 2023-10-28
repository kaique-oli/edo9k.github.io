USE db_brasileirao_kaique;
SELECT * FROM Exercicio.PARTIDAS;
SELECT * FROM Exercicio.GOLS;
SELECT * FROM Exercicio.CARTOES;
SELECT * FROM Exercicio.ESTATISTICAS;

	  /*
	  Quantas partidas cada clube venceu?
	  R:
	  # TIME	VITORIAS
	-	825
	Palmeiras	160
	Flamengo	159
	Atletico-MG	143
	Corinthians	131
	Santos	128
	Athletico-PR	123
	Sao Paulo	120
	Fluminense	116
	Internacional	115
	Gremio	115
	Botafogo-RJ	77
	Sport	72
	Cruzeiro	65
	Bahia	60
	Chapecoense	59
	Vasco	57
	Fortaleza	57
	Coritiba	52
	Ceara	52
	Goias	45
	America-MG	45
	Atletico-GO	42
	Ponte Preta	38
	Bragantino	38
	Avai	33
	Vitoria	32
	Cuiaba	20
	Figueirense	19
	Juventude	14
	Santa Cruz	8
	CSA	8
	Joinville	7
	Parana	4*/
  SELECT TP.VENCEDOR AS TIME, COUNT(TP.VENCEDOR) AS VITORIAS  FROM Exercicio.PARTIDAS TP GROUP BY TP.VENCEDOR ORDER BY VITORIAS DESC;
  -- Query com avaliação do vencedor a partir do placar para ter certeza:
     SELECT * FROM (
    SELECT
    time AS vencedor,
    COUNT(*) AS total_vitorias FROM (
    SELECT partida_id, 
           CASE 
               WHEN mandante_placar > visitante_placar THEN mandante
               WHEN mandante_placar < visitante_placar THEN visitante
               ELSE 'Empate'
           END AS time
    FROM Exercicio.PARTIDAS
) AS vencedores
GROUP BY time) AS TEMP
ORDER BY TEMP.total_vitorias DESC;
  /* Quais times foram os maiores vencedores, e quais times ficaram com menos vitórias? */
      /*
	Os três maiores vencedores são:
    Palmeiras	160
	Flamengo	159
	Atletico-MG	143
    
    Os três maiores perdedores são:
    CSA	8
	Joinville	7
	Parana	4
    
    Obs: Empates foram os mais frequentes com : 825 partidas
    
	*/
  -- Cartões vermelhos e amarelos.
  
  -- Quais times levou o maior numero de cartões?
  SELECT TC.CLUBE AS TIME, TC.CARTAO AS CARTAO, COUNT(TC.CARTAO) AS QUANTIDADE FROM Exercicio.CARTOES AS TC WHERE TC.CARTAO = 'Amarelo' 	GROUP BY TC.CLUBE, TC.CARTAO ORDER BY  QUANTIDADE DESC;
  SELECT TC.CLUBE AS TIME, TC.CARTAO AS CARTAO, COUNT(TC.CARTAO) AS QUANTIDADE FROM Exercicio.CARTOES AS TC WHERE TC.CARTAO = 'Vermelho' 	GROUP BY TC.CLUBE, TC.CARTAO ORDER BY  QUANTIDADE DESC;
  
  /*
	R: 
    Os três times com maior numero de cartões vermelhos são:
    # 	TIME			CARTAO		QUANTIDADE
		Fluminense		Vermelho		44
		Internacional	Vermelho		43
		Santos			Vermelho		40
	Os três times com maior numero de cartões amarelos são:
    # 	TIME			CARTAO		QUANTIDADE
		Santos			Amarelo			722
		Sao Paulo		Amarelo			711
		Palmeiras		Amarelo			707    
  */

  -- Quais jogadores receberam o maior número de cartões? 
  SELECT TC.CLUBE AS TIME, TC.ATLETA AS JOGADOR, TC.CARTAO AS CARTAO, COUNT(TC.CARTAO) AS QUANTIDADE FROM Exercicio.CARTOES AS TC WHERE TC.CARTAO = 'Amarelo' 	GROUP BY TC.CLUBE, TC.ATLETA, TC.CARTAO ORDER BY  QUANTIDADE DESC;
  SELECT TC.CLUBE AS TIME, TC.ATLETA AS JOGADOR, TC.CARTAO AS CARTAO, COUNT(TC.CARTAO) AS QUANTIDADE FROM Exercicio.CARTOES AS TC WHERE TC.CARTAO = 'Vermelho' 	GROUP BY TC.CLUBE, TC.ATLETA, TC.CARTAO ORDER BY  QUANTIDADE DESC;
  /*
  R:
	Os Jogadore que mais ganharam cartões Vermelhos:
    # 	TIME			JOGADOR						CARTAO		QUANTIDADE
		Santos			Gustavo Henrique Vernes		Vermelho		4
		Ceara			Samuel Xavier				Vermelho		4
		Palmeiras		José Rafael Vivian			Vermelho		4
		Fortaleza		Felipe						Vermelho		4
		Athletico-PR	Thiago Heleno				Vermelho		4
	Os Jogadore que mais ganharam cartões Amarelos:
	# 	TIME			JOGADOR				CARTAO	QUANTIDADE
		Corinthians		Fagner				Amarelo		48
		Botafogo-RJ		Joel Carli			Amarelo		46
		Gremio			Walter Kannemann	Amarelo		44
		Palmeiras		Felipe Melo			Amarelo		42
		Flamengo		Diego Ribas			Amarelo		40

  */
  
  -- Gols
  -- Quais times tiveram mais gols?
  SELECT * FROM Exercicio.GOLS  
  SELECT TG.CLUBE AS TIME, COUNT(TG.GOL_ID) AS GOLS FROM Exercicio.GOLS AS TG GROUP BY TG.CLUBE ORDER BY GOLS DESC;
/*
	R: Os cinco times que mais golearam sâo:
    # TIME			GOLS
	Flamengo		488
	Palmeiras		483
	Atletico-MG		455
	Santos			397
	Sao Paulo		375

*/
  -- Quem foram os maiores artilheiros de todas as partidas registradas nos dados? 
    SELECT TG.CLUBE AS TIME, TG.ATLETA AS JOGADOR, COUNT(TG.GOL_ID) AS GOLS FROM Exercicio.GOLS AS TG GROUP BY TG.CLUBE, TG.ATLETA ORDER BY GOLS DESC;
    /*
    R:
    Os cinco maiores artilheiros sâo:
    
    # TIME		JOGADOR							GOLS
	Flamengo	Gabriel Barbosa					51
	Palmeiras	Eduardo Pereira Rodrigues		50
	Bahia		Gilberto Oliveira Souza Junior	46
	Flamengo	Bruno Henrique					43
	Santos		Ricardo Oliveira				39

    */

  
  
  
  
  
  
  
  
  
  
  
  
  
  