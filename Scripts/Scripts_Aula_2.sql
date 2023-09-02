-- Criando um banco de dados de teste (se ainda não existir)
CREATE DATABASE TestDB;
USE TestDB;

-- Criando uma tabela de teste
CREATE TABLE TestTable (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Sobrenome VARCHAR(50),
    DataNascimento DATE,
    Salario DECIMAL(10, 2),
    Ativo BIT,
    Descricao TEXT,
    DataHoraAtual DATETIME
);