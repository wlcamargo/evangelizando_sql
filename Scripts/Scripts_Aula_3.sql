/*
Scripts da Aula 3 - Evangelizando o SQL 

Desenvolvedor: Ítalo Mesquita

Linkedin: https://www.linkedin.com/in/italomesquita/

Canal Youtube: https://www.youtube.com/@ItaloMesquita
*/

IF NOT EXISTS(
	SELECT TOP 1 1
	FROM sys.databases
	WHERE [name] = 'Aula03'
)
BEGIN

	CREATE DATABASE Aula03;

END
GO

USE Aula03
GO

DROP TABLE IF EXISTS tblVendas
DROP TABLE IF EXISTS tblVendedores
DROP TABLE IF EXISTS tblProdutos
DROP TABLE IF EXISTS tblMarca
DROP TABLE IF EXISTS tblEmpresas
DROP TABLE IF EXISTS tblCargosComissoes
DROP TABLE IF EXISTS logCargosComissoes
GO

CREATE TABLE tblEmpresas(
	EmpresaID INT PRIMARY KEY NOT NULL,
	Nome VARCHAR(24) NOT NULL,
	NomeFantasia VARCHAR(80) NOT NULL,
	Ativa BIT NOT NULL DEFAULT(1)
)
GO

CREATE TABLE tblCargosComissoes(
	CargoComissaoID SMALLINT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Descricao VARCHAR(80) NOT NULL,
	PercComissao NUMERIC(5,2)
)
GO

CREATE TABLE tblVendedores(
	VendedorID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Nome VARCHAR(80) NOT NULL,
	EmpresaID INT REFERENCES tblEmpresas(EmpresaID),
	CargoComissaoID SMALLINT REFERENCES tblCargosComissoes(CargoComissaoID)
)
GO

CREATE TABLE logCargosComissoes(
	LogCargosComissoesID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	CargoComissaoID SMALLINT NOT NULL,
	DescricaoAnt VARCHAR(80) NULL,
	DescricaoAtual VARCHAR(80) NULL,
	PercComissaoAnt NUMERIC(5,2),
	PercComissaoAtual NUMERIC(5,2),
	DataHora DATETIME NOT NULL DEFAULT(GETDATE()),
	UserLogado VARCHAR(40) NOT NULL DEFAULT(SUSER_NAME()),
	HostName VARCHAR(40) NOT NULL DEFAULT(HOST_NAME()),
	CommandName VARCHAR(8) NOT NULL
)
GO

CREATE TABLE tblMarca(
	MarcaID INT PRIMARY KEY IDENTITY(1,1),
	Descricao VARCHAR(80)
)
GO

CREATE TABLE tblProdutos(

	ProdutoID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Descricao VARCHAR(80) NOT NULL,
	MarcaID INT,

	CONSTRAINT FK_tblMarca_MarcaID FOREIGN KEY(MarcaID) REFERENCES tblMarca(MarcaID)
)
GO


CREATE TABLE tblVendas(
	EmpresaID INT NOT NULL,
	VendaID INT NOT NULL,
	VendedorID INT,
	ProdutoID INT NOT NULL,
	Quantidade INT NOT NULL,
	ValorBruto MONEY NOT NULL,
	Desconto MONEY NOT NULL,
	ValorLiquido AS (ValorBruto-ValorLiquido),
	--CONSTRAINT
	CONSTRAINT FK_tblEmpresas_EmpresaID FOREIGN KEY(EmpresaID) REFERENCES tblEmpresas(EmpresaID),
	CONSTRAINT FK_tblVendedores_VendedorID FOREIGN KEY(VendedorID) REFERENCES tblVendedores(VendedorID),
	CONSTRAINT PK_EmpresaID_VendaID PRIMARY KEY(EmpresaID,VendaID),
	CONSTRAINT DF_Desconto_0 DEFAULT 0 FOR Desconto
)
GO 

ALTER TABLE tblVendas 
	ADD CONSTRAINT FK_tblProdutos_ProdutoID FOREIGN KEY(ProdutoID) REFERENCES tblProdutos(ProdutoID)
GO

CREATE OR ALTER TRIGGER trLogCargosComissoes ON tblCargosComissoes AFTER INSERT,UPDATE,DELETE
AS
BEGIN

	DECLARE @IsDeleted  BIT = 0        
	DECLARE @IsInserted BIT = 0        
	DECLARE @TipoComando VARCHAR(10)    
	    
	IF EXISTS (SELECT TOP 1 1 FROM inserted) SET @IsInserted = 1        
	IF EXISTS (SELECT TOP 1 1 FROM deleted)  SET @IsDeleted  = 1    
	    
	IF @IsDeleted  = 1 AND @IsInserted = 1 
		SET @TipoComando = 'updated'  
	ELSE IF @IsDeleted  = 0 
		SET @TipoComando = 'inserted' 
	ELSE 
		SET @TipoComando = 'deleted' 

	IF @TipoComando = 'inserted'
	BEGIN
	
		INSERT INTO logCargosComissoes(
			CargoComissaoID,
			DescricaoAtual,
			PercComissaoAtual,
			CommandName
		)

		SELECT 
			inserted.CargoComissaoID,
			inserted.Descricao AS DescricaoAtual,
			inserted.PercComissao AS PercComissaoAtual,
			@TipoComando AS CommandName
		FROM inserted

	END ELSE IF @TipoComando = 'updated'
	BEGIN

		INSERT INTO logCargosComissoes(
			CargoComissaoID,
			DescricaoAnt,
			DescricaoAtual,
			PercComissaoAnt,
			PercComissaoAtual,
			CommandName
		)

		SELECT
			inserted.CargoComissaoID,
			deleted.Descricao AS DescricaoAnt,
			inserted.Descricao AS DescricaoAtual,
			deleted.PercComissao AS PercComissaoAnt,
			inserted.PercComissao AS PercComissaoAtual,
			@TipoComando AS CommandName
		FROM deleted
		INNER JOIN inserted
			ON (deleted.CargoComissaoID = inserted.CargoComissaoID)


	END	ELSE
	BEGIN

		INSERT INTO logCargosComissoes(
			CargoComissaoID,
			DescricaoAnt,
			PercComissaoAnt,
			CommandName
		)

		SELECT 
			deleted.CargoComissaoID,
			deleted.Descricao AS DescricaoAnt,
			deleted.PercComissao AS PercComissaoAnt,
			@TipoComando AS CommandName
		FROM deleted

	END
END
GO

INSERT INTO tblCargosComissoes(
	Descricao,
    PercComissao
)

VALUES
	('Vendedor',2.00),
	('Gerente',0.5),
	('Supervisor',0.2),
	('Others', 0.2)
GO

UPDATE tblCargosComissoes
SET PercComissao = 1.5
WHERE Descricao = 'Vendedor'
GO

-- BEGIN TRANSACTION
DELETE FROM tblCargosComissoes
WHERE Descricao = 'Others'

--ROLLBACK
--COMMIT
GO


/*
--ELIMINA TODAS AS LINHAS DAS TABELA (REINICIA IDENTITIES, NÃO ACIONA TRIGGERS)
TRUNCATE TABLE [table_name]

--ELIMINA A ESTRUTURA DA TABELA + DADOS (NÃO ACIONA TRIGGERS)
DROP TABLE [table_name]
*/