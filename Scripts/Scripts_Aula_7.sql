----------------------------------------------------------------------------------
-- AULA 07 - LUIZ LIMA:
----------------------------------------------------------------------------------

USE Treinamento_TSQL

----------------------------------------------------------------------------------
-- Variáveis
----------------------------------------------------------------------------------
-- Como declarar e utilizar uma variável?

-- EX 1 - UTILIZANDO UMA VARIÁVEL:
DECLARE @NOME VARCHAR(50)

SET @NOME = 'Luiz Lima'

SELECT @NOME
GO

-- EX 2 - DECLARANDO E ATRIBUINDO O VALOR:
DECLARE @NOME VARCHAR(50) = 'Luiz Lima'

SELECT @NOME
GO

-- EX 3 - UTILIZANDO MAIS DE UMA VARIÁVEL:
DECLARE @NOME VARCHAR(50), @SOBRENOME VARCHAR(50), @IDADE INT 

SELECT 
	@NOME = 'Luiz',
	@SOBRENOME = 'Lima',
	@IDADE = 18

SELECT @NOME AS NOME, @SOBRENOME AS SOBRENOME, @IDADE AS IDADE
GO

-- EX 4 - ESQUECENDO DE ATRIBUIR OS VALORES:
DECLARE @NOME VARCHAR(50), @SOBRENOME VARCHAR(50)

SELECT @NOME AS NOME, @SOBRENOME AS SOBRENOME
GO

-- EX 5 - CONCATENANDO VARIÁVEIS:
DECLARE @NOME VARCHAR(50), @SOBRENOME VARCHAR(50)

SELECT 
	@NOME = 'Luiz',
	@SOBRENOME = 'Lima'

SELECT @NOME + ' ' + @SOBRENOME AS NOME_COMPLETO
GO

-- EX 6 - CONCATENANDO VARIÁVEIS - NULL:
DECLARE @NOME VARCHAR(50), @SOBRENOME VARCHAR(50)

SELECT @NOME = 'Luiz'

SELECT @NOME + ' ' + @SOBRENOME AS NOME_COMPLETO

-- TRATANDO COM A FUNÇÃO "ISNULL"
SELECT @NOME + ' ' + ISNULL(@SOBRENOME,'') AS NOME_COMPLETO
GO

-- OUTRAS FUNÇÕES NO LINK ABAIXO:
-- https://www.youtube.com/watch?v=5D-V8Y9FCHQ&list=PLU480OSPgKSq55u4QF8kuRBNpjz4WGTWs&index=7&t

-- EX 7 - ESCOPO DE UMA VARIAVEL:
DECLARE @NOME VARCHAR(50) = 'Luiz'

SELECT @NOME

GO

SELECT @NOME

/*
Msg 137, Level 15, State 2, Line 72
Must declare the scalar variable "@NOME".
*/


----------------------------------------------------------------------------------
-- IF / ELSE
----------------------------------------------------------------------------------
-- EX 1 - APENAS O IF:
DECLARE @NOME VARCHAR(50) = 'Luiz'

IF (@NOME IS NOT NULL)
BEGIN
	SELECT 'Seu nome é: ' + @NOME
END
GO

-- EX 2 - IF / ELSE:
DECLARE @NOME VARCHAR(50)
--DECLARE @NOME VARCHAR(50) = 'Luiz'

IF (@NOME IS NOT NULL)
BEGIN
	SELECT 'Seu nome é: ' + @NOME
END
ELSE
BEGIN
	SELECT 'Você não informou o nome!!!'
END
GO

-- EX 3 - IFs ANINHADOS:
DECLARE @VALOR INT
--DECLARE @VALOR INT = 10
--DECLARE @VALOR INT = 15

IF (@VALOR IS NOT NULL)	-- VALIDA SE INFORMOU O VALOR!
BEGIN
	IF (@VALOR % 2 = 0)	-- VALIDA SE É UM NÚMERO PAR!
	BEGIN
		SELECT 'O NÚMERO ' + CAST(@VALOR AS VARCHAR) + ' É PAR!' 		
	END
	ELSE				-- VALIDA SE É UM NÚMERO ÍMPAR! (@VALOR % 2 <> 0)
	BEGIN
		SELECT 'O NÚMERO ' + CAST(@VALOR AS VARCHAR) + ' É ÍMPAR!' 	
	END
END
ELSE
BEGIN
	SELECT 'Você não informou o valor!!!'
END
GO


----------------------------------------------------------------------------------
-- CASE
----------------------------------------------------------------------------------
-- EX 1 - NORMAL:
DECLARE @RESPOSTA CHAR(1) = 'D'

SELECT 
	CASE 
		WHEN @RESPOSTA = 'A' THEN 'A RESPOSTA CERTA É A LETRA "A"'
		WHEN @RESPOSTA = 'B' THEN 'A RESPOSTA CERTA É A LETRA "B"'
		WHEN @RESPOSTA = 'C' THEN 'A RESPOSTA CERTA É A LETRA "C"'
		WHEN @RESPOSTA = 'D' THEN 'A RESPOSTA CERTA É A LETRA "D"'			
		ELSE 'RESPOSTA INVÁLIDA!'
	END
GO

-- EX 2 - SEM REPETIR A CONDIÇÃO:
--DECLARE @RESPOSTA CHAR(1) = 'C'
DECLARE @RESPOSTA CHAR(1) = 'E'

SELECT 
	CASE @RESPOSTA
		WHEN 'A' THEN 'A RESPOSTA CERTA É A LETRA "A"'
		WHEN 'B' THEN 'A RESPOSTA CERTA É A LETRA "B"'
		WHEN 'C' THEN 'A RESPOSTA CERTA É A LETRA "C"'
		WHEN 'D' THEN 'A RESPOSTA CERTA É A LETRA "D"'			
		ELSE 'RESPOSTA INVÁLIDA!'
	END
GO

-- EX 3 - SEM ELSE - CUIDADO!
DECLARE @RESPOSTA CHAR(1) = 'E'

SELECT 
	CASE @RESPOSTA
		WHEN 'A' THEN 'A RESPOSTA CERTA É A LETRA "A"'
		WHEN 'B' THEN 'A RESPOSTA CERTA É A LETRA "B"'
		WHEN 'C' THEN 'A RESPOSTA CERTA É A LETRA "C"'
		WHEN 'D' THEN 'A RESPOSTA CERTA É A LETRA "D"'
	END
GO


----------------------------------------------------------------------------------
-- WHILE
----------------------------------------------------------------------------------
-- EX 1 - IMPRIMIR OS NÚMEROS ATÉ 10!
-- CUIDADO COM LOOP INFINITO!

DECLARE @VALOR INT = 1

WHILE(@VALOR <= 10)
BEGIN
	SELECT @VALOR as VALOR

	SELECT @VALOR += 1
END
GO

-- EX 2 - UTILIZANDO O COMANDO CONTINUE E BRAKE!

DECLARE @VALOR INT = 1

WHILE(@VALOR <= 100)
BEGIN
	IF(@VALOR < 5)
	BEGIN
		SELECT @VALOR += 1
		CONTINUE
	END
	ELSE IF (@VALOR < 10)
	BEGIN
		SELECT @VALOR as VALOR

		SELECT @VALOR += 1
	END
	ELSE
	BEGIN
		BREAK
	END
END


----------------------------------------------------------------------------------
-- Tabelas temporárias
----------------------------------------------------------------------------------

-- REFERÊNCIAS - Tabelas temporárias:
-- https://luizlima.net/dicas-t-sql-tabelas-temporarias-parte-1-tabelas-locais/
-- https://luizlima.net/dicas-t-sql-tabelas-temporarias-parte-2-tabelas-globais/
-- https://luizlima.net/dicas-t-sql-tabelas-temporarias-parte-3-tabelas-variaveis/

-- Tabelas temporárias - Locais
DROP TABLE IF EXISTS #TEMP_LOCAL

CREATE TABLE #TEMP_LOCAL (
	ID INT IDENTITY(1,1) NOT NULL,
	NOME VARCHAR(100) NOT NULL,
	IDADE INT NOT NULL
)

INSERT INTO #TEMP_LOCAL (NOME, IDADE)
VALUES ('LUIZ LIMA', 18), ('ITALO MESQUITA', 20), ('RAPHAEL AMORIM', 22), ('WALLACE CAMARGO', 25)

SELECT * FROM #TEMP_LOCAL

-- ABRIR UMA NOVA QUERY E TENTAR EXECUTAR O SELECT ABAIXO:
/*
Msg 208, Level 16, State 0, Line 1
Invalid object name '#TEMP_LOCAL'.
*/


-- Tabelas temporárias - Globais
DROP TABLE IF EXISTS ##TEMP_GLOBAL

CREATE TABLE ##TEMP_GLOBAL (
	ID INT IDENTITY(1,1) NOT NULL,
	NOME VARCHAR(100) NOT NULL,
	IDADE INT NOT NULL
)

INSERT INTO ##TEMP_GLOBAL (NOME, IDADE)
VALUES ('LUIZ LIMA', 18), ('ITALO MESQUITA', 20), ('RAPHAEL AMORIM', 22), ('WALLACE CAMARGO', 25)

SELECT * FROM ##TEMP_GLOBAL

-- ABRIR UMA NOVA QUERY E TENTAR EXECUTAR O SELECT ABAIXO:
SELECT * FROM ##TEMP_GLOBAL

-- FAZER O UPDATE ABAIXO NA OUTRA SESSÃO TAMBÉM:
UPDATE ##TEMP_GLOBAL
SET IDADE = 50

-- FAZER O SELECT ABAIXO NESSA SESSÃO PARA VALIDAR AS ALTERAÇÕES:
SELECT * FROM ##TEMP_GLOBAL

-- DROPAR A TABELA E TENTAR ACESSAR NA OUTRA SESSÃO DEPOIS
DROP TABLE ##TEMP_GLOBAL

/*
Msg 208, Level 16, State 0, Line 2
Invalid object name '##TEMP_GLOBAL'.
*/


-- Tabelas temporárias - Variáveis
DECLARE @EVANGELIZANDO_SQL TABLE (
	ID INT IDENTITY(1,1) NOT NULL,
	NOME VARCHAR(100) NOT NULL,
	IDADE INT NOT NULL
)

INSERT INTO @EVANGELIZANDO_SQL (NOME, IDADE)
VALUES ('LUIZ LIMA', 18), ('ITALO MESQUITA', 20), ('RAPHAEL AMORIM', 22), ('WALLACE CAMARGO', 25)

SELECT * FROM @EVANGELIZANDO_SQL

-- ABRIR UMA NOVA QUERY E TENTAR EXECUTAR O SELECT ABAIXO:
/*
Msg 1087, Level 15, State 2, Line 1
Must declare the table variable "@EVANGELIZANDO_SQL".
*/

GO

-- FIM DO ESCOPO OU TENTAR EXECUTAR SOMENTE O SELECT ABAIXO:

SELECT * FROM @EVANGELIZANDO_SQL
GO
/*
Msg 1087, Level 15, State 2, Line 1
Must declare the table variable "@EVANGELIZANDO_SQL".
*/


----------------------------------------------------------------------------------
-- Subqueries
----------------------------------------------------------------------------------

DROP TABLE IF EXISTS Loja

CREATE TABLE Loja (
	Id_Loja INT IDENTITY(1,1) NOT NULL,
	Nm_Loja VARCHAR (200) NOT NULL
)

INSERT INTO Loja
VALUES('Centro'), ('Shopping Praia')

SELECT * FROM Loja

SELECT * FROM Vendas

-- 1) USANDO UMA SUBQUERY
USE Treinamento_TSQL

SELECT *,
	(
		SELECT MAX(Dt_Venda) FROM Vendas
	) AS MAX_DATA,
	(
		SELECT MAX(Vl_Venda) FROM Vendas
	) AS MAX_VALOR_VENDA
FROM Vendas


-- 2) USANDO UMA SUBQUERY COM DEPENDÊNCIA
USE Treinamento_TSQL

SELECT *,
	(
		SELECT Nm_Loja
		FROM Loja L
		WHERE 
			L.Id_Loja = A.Id_Loja
	) AS NOME_LOJA
FROM Vendas A
GO

----------------------------------------------------------------------------------
-- CTE E RECURSIVIDADE
----------------------------------------------------------------------------------
-- REFERÊNCIA:
-- https://www.dirceuresende.com/blog/sql-server-como-criar-consultas-recursivas-com-a-cte-common-table-expressions/

-- 1) USANDO CTE
;WITH CTE_VENDAS_LOJA_1 AS (
	SELECT * 
	FROM Vendas
	WHERE Id_Loja = 1
)

SELECT * FROM CTE_VENDAS_LOJA_1;

SELECT * FROM CTE_VENDAS_LOJA_1;
GO

-- 2) USANDO RECURSIVIDADE
;WITH CTE_Numerico (Nivel, Numero) 
AS
(
    -- Âncora (nível 1)
    SELECT 1 AS Nivel, 1 AS Numero
    
    UNION ALL

    -- Níveis recursivos (Níveis N)
    SELECT Nivel + 1, Numero + Numero 
    FROM CTE_Numerico
    WHERE Numero < 10
 )

SELECT *
FROM CTE_Numerico
GO

-- 3) CTE COM ERRO
SELECT 1

WITH CTE_Numerico (Nivel, Numero) 
AS
(
    -- Âncora (nível 1)
    SELECT 1 AS Nivel, 1 AS Numero
    
    UNION ALL

    -- Níveis recursivos (Níveis N)
    SELECT Nivel + 1, Numero + Numero 
    FROM CTE_Numerico
    WHERE Numero < 10
 )

SELECT *
FROM CTE_Numerico
GO

/*
Msg 319, Level 15, State 1, Line 369
Incorrect syntax near the keyword 'with'. If this statement is a common table expression, an xmlnamespaces clause or a change tracking context clause, the previous statement must be terminated with a semicolon.
*/


-- REFERÊNCIA - YOUTUBE:
-- Luiz Lima - Stored Procedures, Functions e Views
-- https://www.youtube.com/watch?v=84_V-HXvj44&list=PLU480OSPgKSq55u4QF8kuRBNpjz4WGTWs&index=4

----------------------------------------------------------------------------------
-- Stored Procedures
----------------------------------------------------------------------------------
GO

-- EXEMPLO 1:
CREATE OR ALTER PROCEDURE stpProcTest
AS
	SELECT 1
GO

EXEC stpProcTest
GO

-- EXEMPLO 2:
CREATE OR ALTER PROCEDURE stpProcTest
AS
BEGIN
	SELECT 2
END
GO

EXEC stpProcTest
GO

-- EXEMPLO 3.1:
CREATE OR ALTER PROCEDURE stpProcTest 
	@valor1 INT, 
	@valor2 INT
AS
BEGIN
	SELECT 'A soma dos valores é: ' + CAST( (@valor1 + @valor2) AS VARCHAR)
END
GO

EXEC stpProcTest 2, 3
GO

EXEC stpProcTest 2
GO
/*
Msg 201, Level 16, State 4, Procedure stpProcTest, Line 0 [Batch Start Line 456]
Procedure or function 'stpProcTest' expects parameter '@valor2', which was not supplied.
*/

EXEC stpProcTest 2, 'Luiz'
GO

/*
Msg 8114, Level 16, State 1, Procedure stpProcTest, Line 0 [Batch Start Line 463]
Error converting data type varchar to int.
*/

GO

-- EXEMPLO 3.2:
CREATE OR ALTER PROCEDURE stpProcTest 
	@valor1 INT, 
	@valor2 INT = 0
AS
BEGIN
	SELECT 'A soma dos valores é: ' + CAST( (@valor1 + @valor2) AS VARCHAR)
END
GO

EXEC stpProcTest 2
GO

-- EXEMPLO 4:
CREATE OR ALTER PROCEDURE stpProcTest 
	@valor INT OUTPUT
AS
BEGIN
	SELECT @valor = 10
END
GO

-- 4.1) Chamando a procedure com OUTPUT
DECLARE @retorno INT = 5

EXEC stpProcTest @retorno OUTPUT

SELECT @retorno
GO

-- 4.2) Chamando a procedure sem OUTPUT
DECLARE @retorno INT = 3

EXEC stpProcTest @retorno

SELECT @retorno
GO


----------------------------------------------------------------------------------
-- Functions
----------------------------------------------------------------------------------

-- SCALAR FUNCTION
CREATE OR ALTER FUNCTION fncDobro( 
	@valor INT
)
RETURNS INT
AS
BEGIN
	RETURN @valor * 2
END
GO

SELECT dbo.fncDobro(10)
SELECT dbo.fncDobro(30)
GO

-- TABLE FUNCTION
CREATE OR ALTER FUNCTION fncValorVenda( 
	@valor NUMERIC(9,2)
)
RETURNS TABLE
AS
RETURN
	SELECT *
	FROM Vendas
	WHERE Vl_Venda >= @valor
GO

SELECT * FROM Vendas
ORDER BY Vl_Venda DESC

SELECT * 
FROM dbo.fncValorVenda(400)
ORDER BY Vl_Venda

SELECT * 
FROM dbo.fncValorVenda(200)
ORDER BY Vl_Venda

-- USANDO FILTROS
SELECT * 
FROM dbo.fncValorVenda(200)
WHERE Id_Loja = 1
ORDER BY Vl_Venda
GO


----------------------------------------------------------------------------------
-- Views
----------------------------------------------------------------------------------
-- OBS 1: COMENTAR SOBRE SELECTS GIGANTES QUE PODEM SER SIMPLIFICADOS POR UMA VIEW.
-- OBS 2: EVITAR CRIAR VIEW, QUE CHAMA OUTRA VIEW, QUE CHAMA OUTRA VIEW, ... POIS DIFICULTA O ENTENDIMENTO / PERFORMANCE.
CREATE OR ALTER VIEW vwVendas2020
AS
	SELECT *
	FROM Vendas
	WHERE Dt_Venda >= '20200101' AND Dt_Venda < '20210101'	
GO

SELECT *
FROM vwVendas2020
ORDER BY Dt_Venda

-- USANDO FILTROS
SELECT *
FROM vwVendas2020
WHERE Id_Loja = 2
ORDER BY Dt_Venda

-- OBS: COMENTAR SOBRE VIEW x Acesso Tabelas


----------------------------------------------------------------------------------
-- CROSS APPLY / OUTER APPLY
----------------------------------------------------------------------------------
-- REFERÊNCIA - YOUTUBE:
-- ÍTALO MESQUITA - Aprenda a utilizar os operadores CROSS APPLY e OUTER APPLY
-- https://www.youtube.com/watch?v=6x7jT7g3b40

----------------------------------------------------------------------------------
-- Teste Kahoot
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Resolução de teste para processo seletivo
----------------------------------------------------------------------------------