CREATE DATABASE EVANGELIZANDO_SQL
GO

USE EVANGELIZANDO_SQL
GO

CREATE TABLE TB_VENDAS (
  IdVenda INT PRIMARY KEY,
  IdCliente INT,
  Nome VARCHAR(100),
  Sexo CHAR(1), -- Usando CHAR para campos de sexo
  Cidade VARCHAR(50),
  Estado CHAR(2), -- Usando CHAR(2) para códigos de estado de 2 letras
  Carro VARCHAR(100),
  Cor VARCHAR(50),
  DataVenda DATE, 
  Vendedor VARCHAR(100),
  ValorBruto DECIMAL(10, 2),
  ValorDesconto DECIMAL(10, 2)
)
GO

INSERT INTO TB_VENDAS (IdVenda, IdCliente, Nome, Sexo, Cidade, Estado, Carro, Cor, DataVenda, Vendedor, ValorBruto, ValorDesconto)
VALUES
  (1, 101, 'João Silva', 'M', 'São Paulo', 'SP', 'Toyota Corolla', 'Prata', '2023-09-18', 'Ana Vendedora', 35000.00, 1000.00),
  (2, 102, 'Maria Santos', 'F', 'Rio de Janeiro', 'RJ', 'Honda Civic', 'Azul', '2023-09-17', 'Pedro Vendedor', 32000.00, 800.00),
  (3, 103, 'Carlos Pereira', 'M', 'Belo Horizonte', 'MG', 'Ford Fusion', 'Preto', '2023-09-16', 'Lucia Vendedora', 38000.00, 1500.00),
  (98, 198, 'Juliana Lima', 'F', 'Porto Alegre', 'RS', 'Volkswagen Gol', 'Vermelho', '2023-09-02', 'Miguel Vendedor', 22000.00, 500.00),
  (99, 199, 'Pedro Alves', 'M', 'Salvador', 'BA', 'Renault Sandero', 'Branco', '2023-09-01', 'Isabel Vendedora', 25000.00, 800.00),
  (100, 200, 'Ana Rodrigues', 'F', 'Recife', 'PE', 'Chevrolet Onix', 'Cinza', '2023-08-31', 'Ricardo Vendedor', 28000.00, 1000.00),
  (101, 201, 'Fernanda Pereira', 'F', 'Brasília', 'DF', 'Hyundai Tucson', 'Prata', '2023-08-30', 'Paulo Vendedor', 34000.00, 1200.00),
  (102, 202, 'Ricardo Mendes', 'M', 'Curitiba', 'PR', 'Nissan Sentra', 'Azul', '2023-08-29', 'Sandra Vendedora', 30000.00, 900.00),
  (103, 203, 'Mariana Oliveira', 'F', 'Fortaleza', 'CE', 'Kia Sportage', 'Preto', '2023-08-28', 'Daniel Vendedor', 36000.00, 1400.00),
  (198, 298, 'Roberto Santos', 'M', 'Manaus', 'AM', 'Chevrolet Cruze', 'Branco', '2023-08-14', 'Camila Vendedora', 32000.00, 800.00),
  (199, 299, 'Luana Lima', 'F', 'Goiânia', 'GO', 'Volkswagen Polo', 'Vermelho', '2023-08-13', 'Lucas Vendedor', 28000.00, 1000.00),
  (200, 300, 'Eduardo Alves', 'M', 'Porto Velho', 'RO', 'Ford Fiesta', 'Cinza', '2023-08-12', 'Isabela Vendedora', 25000.00, 600.00),
  (201, 301, 'Gustavo Fernandes', 'M', 'Campinas', 'SP', 'Toyota Camry', 'Prata', '2023-08-11', 'Ana Vendedora', 40000.00, 2000.00),
  (202, 302, 'Laura Souza', 'F', 'Recife', 'PE', 'Honda HR-V', 'Azul', '2023-08-10', 'Pedro Vendedor', 34000.00, 1000.00),
  (203, 303, 'André Silva', 'M', 'Salvador', 'BA', 'Ford Mustang', 'Preto', '2023-08-09', 'Lucia Vendedora', 55000.00, 3000.00),
  (204, 304, 'Renata Santos', 'F', 'Porto Alegre', 'RS', 'Volkswagen Jetta', 'Vermelho', '2023-08-08', 'Miguel Vendedor', 38000.00, 1500.00),
  (205, 305, 'Daniel Oliveira', 'M', 'Belo Horizonte', 'MG', 'Audi A3', 'Branco', '2023-08-07', 'Isabel Vendedora', 45000.00, 2000.00),
  (206, 306, 'Carolina Pereira', 'F', 'São Paulo', 'SP', 'BMW X5', 'Preto', '2023-08-06', 'Ricardo Vendedor', 65000.00, 3000.00),
  (207, 307, 'Marcelo Alves', 'M', 'Rio de Janeiro', 'RJ', 'Mercedes-Benz C-Class', 'Prata', '2023-08-05', 'Ana Vendedora', 60000.00, 2500.00),
  (208, 308, 'Mariana Lima', 'F', 'Curitiba', 'PR', 'Toyota RAV4', 'Azul', '2023-08-04', 'Pedro Vendedor', 42000.00, 1800.00),
  (209, 309, 'Lucas Rodrigues', 'M', 'Fortaleza', 'CE', 'Hyundai Sonata', 'Preto', '2023-08-03', 'Lucia Vendedora', 36000.00, 1200.00),
  (210, 310, 'Sofia Mendes', 'F', 'Brasília', 'DF', 'Nissan Altima', 'Cinza', '2023-08-02', 'Daniel Vendedor', 38000.00, 1300.00),
  (211, 311, 'Gustavo Fernandes', 'M', 'Manaus', 'AM', 'Kia Seltos', 'Vermelho', '2023-08-01', 'Camila Vendedora', 28000.00, 1000.00),
  (212, 312, 'Laura Souza', 'F', 'Goiânia', 'GO', 'Volkswagen Golf', 'Branco', '2023-07-31', 'Lucas Vendedor', 32000.00, 1200.00),
  (213, 313, 'André Silva', 'M', 'Porto Velho', 'RO', 'Chevrolet Tracker', 'Prata', '2023-07-30', 'Isabela Vendedora', 35000.00, 1500.00),
  (214, 314, 'Renata Santos', 'F', 'Campinas', 'SP', 'Honda Fit', 'Azul', '2023-07-29', 'Ana Vendedora', 28000.00, 800.00),
  (215, 315, 'Daniel Oliveira', 'M', 'Recife', 'PE', 'Ford EcoSport', 'Preto', '2023-07-28', 'Pedro Vendedor', 30000.00, 900.00),
  (216, 316, 'Carolina Pereira', 'F', 'Salvador', 'BA', 'Volkswagen Tiguan', 'Branco', '2023-07-27', 'Lucia Vendedora', 40000.00, 1600.00),
  (217, 317, 'Marcelo Alves', 'M', 'Porto Alegre', 'RS', 'Toyota Highlander', 'Prata', '2023-07-26', 'Miguel Vendedor', 60000.00, 2500.00),
  (218, 318, 'Mariana Lima', 'F', 'Belo Horizonte', 'MG', 'Honda Accord', 'Preto', '2023-07-25', 'Isabel Vendedora', 45000.00, 1800.00),
  (219, 319, 'Lucas Rodrigues', 'M', 'São Paulo', 'SP', 'Ford Explorer', 'Azul', '2023-07-24', 'Ricardo Vendedor', 55000.00, 2200.00),
  (220, 320, 'Sofia Mendes', 'F', 'Rio de Janeiro', 'RJ', 'Chevrolet Trailblazer', 'Vermelho', '2023-07-23', 'Ana Vendedora', 48000.00, 2000.00),
  (221, 101, 'João Silva', 'M', 'São Paulo', 'SP', 'Toyota Corolla', 'Prata', '2023-09-18', 'Ana Vendedora', 35000.00, 1000.00)
 GO
  



CREATE TABLE TB_PALESTRANTES (
	IdPalestrantes int identity (1,1),
	Nome varchar(30)
)
GO
	

INSERT INTO TB_PALESTRANTES
VALUES
('Shalom Andre'),
('Wallace Camargo'),
('Italo Mesquita'),
('Luiz Lima'),
('Raphael Amorin'),
('Enzo Delcampori')
GO

CREATE TABLE TB_APOIADORES (
	IdApoiadores int identity (1,1),
	Nome varchar (30)
)
GO

INSERT INTO TB_APOIADORES
VALUES
('Shalom Andre'),
('Wallace Camargo'),
('Reginaldo Batista'),
('Mazoelle Oliveira')
GO


