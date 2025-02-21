--------------------------------------------------------------------------------------------------
-- LIVE EVANGELIZANDO SQL - MELHORES PR�TICAS - CONSULTAS SQL
--------------------------------------------------------------------------------------------------

/*
DICA 01: Utilize padr�es para nomenclaturas
DICA 02: Case Sensitive / Accent Sensitive
DICA 03: Fa�a Identa��o no seu c�digo!
DICA 04: Versionamento de c�digo
DICA 05: VIEW COM SELECT * FROM
DICA 06: COUNT(*) x COUNT(coluna)
DICA 07: CUIDADOS COM NULL x NOT IN
DICA 08: Cria��o de �ndice � Warning! The maximum key length is X bytes
DICA 09: Warning: Null value is eliminated by an aggregate or other SET operation
DICA 10: Qual impacto de utilizar o prefixo �sp_� no nome de uma procedure?
*/

--------------------------------------------------------------------------------------------------
-- DICA 01: Utilize padr�es para nomenclaturas
--------------------------------------------------------------------------------------------------

-- Link: https://builtin.com/articles/pascal-case-vs-camel-case#:~:text=Pascal%20case%20is%20a%20casing,capitalized%2C%20such%20as%3A%20camelCase%20.

-- OBS: Se a empresa ou cliente j� utilizam algum padr�o, respeite isso e siga!

-- camelCase -> deve come�ar com a primeira letra min�scula e a primeira letra de cada nova palavra subsequente mai�scula:

dataReferencia
valorFinal
nomeCliente

-- PascalCase -> combina palavras colocando TODAS com a primeira letra mai�scula

DataReferencia
ValorFinal
NomeCliente

-- Snake Case e Outros:

data_referencia 
Data_Referencia 
Dt_Referencia
DtReferencia
stpCalculaValor
vwRelatorioVendas
vwRelVendas

USE Traces
GO

-- Colunas sem um padrao definido
DROP TABLE IF EXISTS testeNomenclatura

CREATE TABLE testeNomenclatura (
	ID INT IDENTITY(1,1),
	nome VARCHAR(100),
	Idade INT,
	DataNascimento DATE,
	vlSalario NUMERIC(9,2)
)

SELECT * 
FROM testeNomenclatura
GO


--------------------------------------------------------------------------------------------------
-- DICA 02: Case Sensitive / Accent Sensitive
--------------------------------------------------------------------------------------------------
USE Traces
GO

DROP TABLE IF EXISTS testeCS_AS

CREATE TABLE testeCS_AS (
	ID INT IDENTITY(1,1),
	nome VARCHAR(100) COLLATE Latin1_General_CS_AS,
	DataNascimento DATE
)

INSERT INTO testeCS_AS
VALUES	('Luiz Vitor','19990602'),
		('Luiz V�tor','19951219'),
		('luiz vitor','19951219')

SELECT * FROM testeCS_AS

SELECT * FROM testeCS_AS WHERE nome = 'Luiz Vitor'

SELECT * FROM testeCS_AS WHERE nome = 'Luiz V�tor'

SELECT * FROM testeCS_AS WHERE nome = 'luiz vitor'


DROP TABLE IF EXISTS testeCI_AI

CREATE TABLE testeCI_AI (
	ID INT IDENTITY(1,1),
	nome VARCHAR(100) COLLATE Latin1_General_CI_AI,
	DataNascimento DATE
)

INSERT INTO testeCI_AI
VALUES	('Luiz Vitor','19990602'),
		('Luiz V�tor','19951219'),
		('luiz vitor','19951219')

SELECT * FROM testeCI_AI

SELECT * FROM testeCI_AI WHERE nome = 'Luiz Vitor'

SELECT * FROM testeCI_AI WHERE nome = 'Luiz V�tor'

SELECT * FROM testeCI_AI WHERE nome = 'luiz vitor'
GO


--------------------------------------------------------------------------------------------------
-- DICA 03: Fa�a Identa��o no seu c�digo!
--------------------------------------------------------------------------------------------------

-- Luiz Lima
-- Link: https://luizlima.net/dicas-t-sql-if-else-begin-end/

USE Traces

DECLARE @ID INT = 10

IF (@ID = 10)
BEGIN
	SELECT '(1) - O VALOR DA VARIAVEL � IGUAL A 10!!!' 
END
ELSE
	SELECT '(2) - O VALOR DA VARIAVEL � DIFERENTE 10!!!'
	SELECT '(3) - FIM DO PROGRAMA!!!'

GO


USE Traces

DECLARE @ID INT = 10

IF (@ID = 10)
BEGIN
	SELECT '(1) - O VALOR DA VARIAVEL � IGUAL A 10!!!' 
END
ELSE
BEGIN
	SELECT '(2) - O VALOR DA VARIAVEL � DIFERENTE 10!!!'
	SELECT '(3) - FIM DO PROGRAMA!!!'
END
GO

-- ABRIR A PROCEDURE SP_WHOISACTIVE E VALIDAR A IDENTA��O


--------------------------------------------------------------------------------------------------
-- DICA 04: Versionamento de c�digo
--------------------------------------------------------------------------------------------------
USE Traces
GO

-- ABRIR O C�DIGO DA PROCEDURE ABAIXO E VALIDAR O HIST�RICO DE ALTERA��ES:
EXEC stpRetornaInfosBD
GO


--------------------------------------------------------------------------------------------------
-- DICA 05: VIEW COM SELECT * FROM
--------------------------------------------------------------------------------------------------

-- Gabriel da Silva
-- Link: https://www.linkedin.com/posts/gabrieldba_sqlserver-tsql-activity-7297754163327778817-Kujl?utm_source=share&utm_medium=member_desktop&rcm=ACoAABlpREkBRBgqUI8KEUjb8qYFKWXKx9-YImo

USE Traces
GO

DROP TABLE IF EXISTS TB_TESTE
DROP VIEW IF EXISTS VW_TESTE
GO

CREATE TABLE TB_TESTE (col1 int, col2 int)
go

create view VW_TESTE as
select * from TB_TESTE
go

-- View retornando 2 colunas
select * from VW_TESTE

-- Adicionando coluna "col3"
alter table TB_TESTE add col3 int
go

-- View continua retornando 2 colunas - ERRADO!!!
select * from VW_TESTE
go

-- U�, mas a tabela tem 3 colunas Luiz...
select * from TB_TESTE
go

-- Atualizando Metadados da view
EXEC sp_refreshview 'VW_TESTE'
go

-- Resultado da view ap�s a atualiza��o
-- Agora a View retorna 3 colunas - CORRETO!!!
select * from VW_TESTE
go

select * from TB_TESTE
go

-- IMPORTANTE: EVITE UTILIZAR "SELECT * FROM", AO INV�S DISSO, ESPECIFIQUE SEMPRE AS COLUNAS QUE DEVEM SER RETORNADAS

-- Excluindo a coluna "col3"
alter table TB_TESTE drop column col3
go

select * from VW_TESTE
go

/*
Msg 4502, Level 16, State 1, Line 197
View or function 'VW_TESTE' has more column names specified than columns defined.
*/

-- Atualizando Metadados da view
EXEC sp_refreshview 'VW_TESTE'
go

-- Resultado da view ap�s a atualiza��o
-- Agora a View volta a retornar 2 colunas - CORRETO!!!
select * from VW_TESTE
go

select * from TB_TESTE
go


--------------------------------------------------------------------------------------------------
-- DICA 06: COUNT(*) x COUNT(coluna)
--------------------------------------------------------------------------------------------------

-- Arthur Luz
-- Link: https://www.linkedin.com/posts/arthurluz_sql-dataengineer-spark-activity-7296172165412843520-4ysj?utm_source=share&utm_medium=member_desktop&rcm=ACoAABlpREkBRBgqUI8KEUjb8qYFKWXKx9-YImo

USE Traces
GO

DROP TABLE IF EXISTS TESTE_COUNT

CREATE TABLE TESTE_COUNT (
	ID INT IDENTITY(1,1) NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	Idade INT NULL
)

INSERT INTO TESTE_COUNT
VALUES	('Luiz Lima', 20),
		('Italo Mesquita', 35),
		('Raphael Amorim', 40),
		('Wallace Camargo', 50),
		('Gabriel Quintella', 60),
		('Dirceu Resende', NULL)

SELECT * FROM TESTE_COUNT

-- COUNT(*) - conta os valores NULL tamb�m!
SELECT COUNT(*) AS [Count]
FROM TESTE_COUNT

-- COUNT(Nome)
SELECT COUNT(Nome) AS [Count_Nome]
FROM TESTE_COUNT

-- COUNT(Idade) - N�O conta os valores NULL!
SELECT COUNT(Idade) AS [Count_Idade]
FROM TESTE_COUNT

/*
(1 row affected)
Warning: Null value is eliminated by an aggregate or other SET operation.
*/
GO


--------------------------------------------------------------------------------------------------
-- DICA 07: CUIDADOS COM NULL x NOT IN
--------------------------------------------------------------------------------------------------

-- Rodrigo Ribeiro
-- Link: https://www.linkedin.com/posts/rodrigoribeirogomes_vendas-regras-activity-7294923485242368001-VNm6?utm_source=share&utm_medium=member_desktop&rcm=ACoAABlpREkBRBgqUI8KEUjb8qYFKWXKx9-YImo

USE Traces
GO

DROP TABLE IF EXISTS TESTE_NULL

CREATE TABLE TESTE_NULL (
	ID INT IDENTITY(1,1) NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	Idade INT NULL
)

INSERT INTO TESTE_NULL
VALUES	('Luiz Lima', 18),
		('Italo Mesquita', 35),
		('Raphael Amorim', 40),
		('Wallace Camargo', 50),
		('Gabriel Quintella', 60)

DROP TABLE IF EXISTS TESTE_IDADES

CREATE TABLE TESTE_IDADES (
	Idade INT NULL
)

INSERT INTO TESTE_IDADES
VALUES (10),(40),(50),(60),(NULL)

SELECT * FROM TESTE_NULL

SELECT * FROM TESTE_IDADES

-- CUIDADO: NOT IN COM NULL!!!
SELECT * 
FROM TESTE_NULL
WHERE Idade NOT IN (SELECT Idade FROM TESTE_IDADES)

-- Mas porque isso acontece Luiz???

/*
valor NOT IN (X,Y,Z) � o mesmo que:

valor != X AND valor != Y AND valor != Z

valor != NULL, por padr�o, � FALSE, pois o valor de NULL � "desconhecido"

Logo, se um for falso, tudo ser� falso e n�o ir� retornar nada!!!
*/

-- Quando tiver valores NULL, utilize outras op��es!

SELECT * FROM TESTE_NULL

SELECT * FROM TESTE_IDADES

-- Op��o 1: LEFT JOIN
SELECT N.* 
FROM TESTE_NULL N
LEFT JOIN TESTE_IDADES I ON N.Idade = I.Idade
WHERE I.Idade IS NULL

-- Op��o 2: NOT EXISTS
SELECT * 
FROM TESTE_NULL N
WHERE NOT EXISTS (SELECT Idade FROM TESTE_IDADES I WHERE N.Idade = I.Idade)


--------------------------------------------------------------------------------------------------
-- DICA 08: Cria��o de �ndice � Warning! The maximum key length is X bytes
--------------------------------------------------------------------------------------------------

-- Luiz Lima
-- Link: https://luizlima.net/dicas-de-tuning-criacao-de-indice-warning-the-maximum-key-length-is-x-bytes/

USE Traces

DROP TABLE IF EXISTS test

create table test (
      col varchar(2000)
    , otherCol bit -- This column will take a byte out of the index below, pun intended
);

create nonclustered index test_index on test (col, otherCol);

/*
Warning! The maximum key length for a nonclustered index is 1700 bytes. 
The index 'test_index' has maximum length of 2001 bytes. 
For some combination of large values, the insert/update operation will fail.
*/

insert into test select cast(replicate('x', 1699) as varchar(1699)), 0; -- Success

insert into test select cast(replicate('y', 1700) as varchar(1700)), 0; -- Fail

update test 
set col = cast(replicate('y', 1700) as varchar(1700))
where otherCol = 0

/*
Msg 1946, Level 16, State 3, Line 201
Operation failed. The index entry of length 1701 bytes for the index 'test_index' exceeds the maximum length of 1700 bytes for nonclustered indexes.
*/

SELECT * FROM test


--------------------------------------------------------------------------------------------------
-- DICA 09: Warning: Null value is eliminated by an aggregate or other SET operation
--------------------------------------------------------------------------------------------------

-- Luiz Lima
-- Link: https://luizlima.net/dicas-t-sql-warning-null-value-is-eliminated-by-an-aggregate-or-other-set-operation/

USE Traces

DROP TABLE IF EXISTS Teste_Soma

CREATE TABLE Teste_Soma (
	Id INT IDENTITY(1,1) NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	Salario NUMERIC(9,2) NULL
)

INSERT INTO Teste_Soma
VALUES 
	('Luiz Vitor', 1500.00),
	('Gustavo Larocca', 3000.00),
	('Eduardo Roedel', 5000.00)

SELECT * FROM Teste_Soma

-- Verificar a aba MESSAGE
SELECT SUM(Salario) AS Vl_Total_Salario
FROM Teste_Soma

-- Inserindo um valor NULL
INSERT INTO Teste_Soma
VALUES ('Dirceu Resende', NULL)

SELECT * FROM Teste_Soma

SELECT SUM(Salario) AS Vl_Total_Salario
FROM Teste_Soma

-- Verificar a aba MESSAGE
-- Warning: Null value is eliminated by an aggregate or other SET operation.


--------------------------------------------------------------------------------------------------
-- DICA 10: Qual impacto de utilizar o prefixo �sp_� no nome de uma procedure?
--------------------------------------------------------------------------------------------------
-- Link: https://luizlima.net/dicas-t-sql-qual-impacto-de-utilizar-o-prefixo-sp_-no-nome-de-uma-procedure/

/*
Link: https://learn.microsoft.com/en-us/sql/t-sql/statements/create-procedure-transact-sql?view=sql-server-2017

Avoid the use of the sp_ prefix when naming procedures. 
This prefix is used by SQL Server to designate system procedures. 
Using the prefix can cause application code to break if there is a system procedure with the same name.
*/

USE Traces

DROP PROC IF EXISTS sp_teste

USE master

DROP PROC IF EXISTS sp_teste
DROP PROC IF EXISTS spteste

GO
CREATE PROC sp_teste
AS
BEGIN
	SELECT DB_NAME() AS Nm_Database, 'Executei na MASTER!!!' AS Ds_Observacao
END
GO 

USE Traces
GO
EXEC sp_teste
GO

USE master
GO
EXEC sp_teste
GO 

-- Criando a procedure tamb�m na base Traces
USE Traces

GO
CREATE PROC sp_teste
AS
BEGIN
	SELECT DB_NAME() AS Nm_Database, 'Executei na TRACES!!!' AS Ds_Observacao
END
GO


USE Traces
GO
EXEC sp_teste
GO

USE master
GO
EXEC sp_teste
GO


-- Mais um teste, agora com outro nome
USE master
GO
CREATE PROC spteste
AS
BEGIN
	SELECT DB_NAME() AS Nm_Database, 'Executei na MASTER!!!' AS Ds_Observacao
END
GO

USE Traces
GO
EXEC spteste

/*
Msg 2812, Level 16, State 62, Line 317
Could not find stored procedure 'spteste'.
*/

GO

USE master
GO
EXEC spteste
GO
