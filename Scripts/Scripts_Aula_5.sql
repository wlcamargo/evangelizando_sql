----------------------------------------------------------------------------------
------------------------- EVANGELIZANDO O SQL AULA 5 -----------------------------
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- SCRIPTS DESENVOLVIDOS POR WALLACE CAMARGO
----------------------------------------------------------------------------------
-- LINKEDIN - https://www.linkedin.com/in/wallace-camargo-35b615171/
-- CANAL YOUTOUBE - https://www.youtube.com/channel/UCK0B4IoF57JoiVVVeEcN8-A

-- AGENDA ------------------------------------------------------------------------

-- PRE REQUISITOS ----------------------------------------------------------------
-- CRIAR BANCO DE DADOS (DATASET_AULA_5.SQL)
-- INSERIR TABELAS NO BANCO DE DADOS VIA SCRIPT (ARQUIVO DATASET_AULA_5.SQL)

-- UNIÃO DE DUAS TABELAS
-- FUNÇÕES DE AGREGAÇÃO
-- FUNÇÕES DE TIME INTELLIGENCE
-- ORDEM DE PROCESSAMENTO DE UMA CONSULTA
----------------------------------------------------------------------------------

-- UNIAO DE TABELAS
-- UNION VS UNION ALL
SELECT * FROM TB_PALESTRANTES
UNION 
SELECT * FROM TB_APOIADORES


SELECT * FROM TB_PALESTRANTES
UNION ALL
SELECT * FROM TB_APOIADORES


-- ADICIONANDO UMA COLUNA DURANTE A CONSULTA
SELECT *, 'TB_PALESTRANTES' AS SOURCE FROM  TB_PALESTRANTES
UNION 
SELECT *, 'TB_APOIADORES' AS SOURCE FROM TB_APOIADORES


-- FUNÇÕES DE AGREGAÇÃO 
-- SUM, COUNT, AVG, MAX, MIN

-- RESPONDENDO PERGUNTAS DE NEGÓCIO ------------------------


-- QUAL O VALOR TOTAL DE VENDAS POR ESTADO? 
SELECT 
	ESTADO,
	SUM(ValorBruto) AS VALOR_BRUTO
FROM 
	TB_VENDAS
GROUP BY
	ESTADO


-- QUAL O TOTAL DE VENDAS POR CLIENTE E POR ESTADO?
SELECT 
	NOME AS CLIENTE, 
	ESTADO,
	MAX(ValorBruto) AS VALOR_BRUTO
FROM
	TB_VENDAS
GROUP BY
	NOME,
	ESTADO
ORDER BY
	2 DESC;


-- QUAL O CARRO MAIS VENDIDO?
SELECT 
	Carro,
	COUNT(*) AS QTD_VENDIDA
FROM 
	TB_VENDAS
GROUP BY
	Carro
ORDER BY 
	2 DESC

	
-- TRAZER SOMENTE CARRO QUE VENDEU MAIS DE UMA UNIDADE
SELECT 
	Carro,
	COUNT(*) AS QTD_VENDIDA
FROM 
	TB_VENDAS
GROUP BY
	Carro
HAVING 
	COUNT(*) > 1
		
		
-- QUAL FOI O CLIENTE COM MAIOR DESCONTO?
SELECT 
	NOME AS CLIENTE, 
	MAX(VALORDESCONTO) AS MAIOR_DESCONTO
FROM
	TB_VENDAS
GROUP BY
	NOME
ORDER BY
	2 DESC;


--QUAL O MAIOR VALOR BRUTO DE UM VENDEDOR?
SELECT 
	NOME, 
	MAX(VALORDESCONTO)
FROM
	TB_VENDAS
GROUP BY
	NOME

	
--QUAL A MEDIA DO VALOR BRUTO DE VENDAS POR DIA?
SELECT 
	DataVenda,
	AVG(ValorBruto) as Media
FROM 
	TB_VENDAS
GROUP BY
	DataVenda
ORDER BY 
	DataVenda


--QUANTIDADE DE VENDA POR VENDEDOR?
SELECT 
	VENDEDOR,
	COUNT(*) AS QTD_VENDIDA
FROM 
	TB_VENDAS
GROUP BY
	VENDEDOR
ORDER BY 
	2 DESC


-- FUNCOES DE TIME INTELLIGENCE
SELECT GETDATE() -- DATA ATUAL DO SISTEMA

SELECT YEAR (GETDATE())	-- ANO ATUAL
SELECT MONTH (GETDATE()) -- MES ATUAL
SELECT DAY (GETDATE()) -- DIA ATUAL


-- FILTRA OS ÚLTIMOS 7 DIAS 
SELECT *
FROM TB_VENDAS
WHERE DataVenda >= DATEADD(DAY, -7, GETDATE());


-- FILTRA O ÚLTIMO MÊS 
SELECT *
FROM TB_VENDAS
WHERE DataVenda >= DATEADD(MONTH, -1, GETDATE());


-- FILTRA O MÊS ATUAL
SELECT *
FROM TB_VENDAS
WHERE MONTH(DataVenda) = MONTH(GETDATE()) AND YEAR(DataVenda) = YEAR(GETDATE());


--ORDEM DO PROCESSAMENTO DE UMA CONSULTA
--1º PASSO --> FROM (JOINS SE TIVER)

--2º PASSO --> WHERE

--3º PASSO --> GROUP BY

--4º PASSO --> HAVING

--5º PASSO --> SELECT

--6º PASSO --> ORDER BY