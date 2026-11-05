
-- ==========================================
-- BANCO DE DADOS OVERCLOCK
-- ==========================================

CREATE DATABASE Overclock;
GO

USE Overclock;
GO

-- ==========================================
-- TABELA: CLIENTE
-- ==========================================

CREATE TABLE Cliente (
    id_cliente INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    telefone VARCHAR(20),
    logradouro VARCHAR(200),
    numero VARCHAR(10),
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    cep VARCHAR(10)
);
GO

-- ==========================================
-- TABELA: FORNECEDOR
-- ==========================================

CREATE TABLE Fornecedor (
    id_fornecedor INT IDENTITY(1,1) PRIMARY KEY,
    razao_social VARCHAR(120) NOT NULL,         -- Nome do dono
    nome_fantasia VARCHAR(100),                 -- Nome da empresa
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    logradouro VARCHAR(200),
    numero VARCHAR(10),
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    cep VARCHAR(10)
);
GO

-- ==========================================
-- TABELA: PRODUTO
-- ==========================================

CREATE TABLE Produto (
    id_produto INT IDENTITY(1,1) PRIMARY KEY,
    id_fornecedor INT NOT NULL,
    nome VARCHAR(120) NOT NULL,
    descricao VARCHAR(MAX),
    categoria VARCHAR(60),
    marca VARCHAR(60),
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0,

    CONSTRAINT FK_Produto_Fornecedor
        FOREIGN KEY (id_fornecedor)
        REFERENCES Fornecedor(id_fornecedor),

    CONSTRAINT CK_Produto_Preco
        CHECK (preco >= 0),

    CONSTRAINT CK_Produto_Estoque
        CHECK (estoque >= 0)
);
GO

-- ==========================================
-- TABELA: PEDIDO
-- ==========================================

CREATE TABLE Pedido (
    id_pedido INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_pedido DATETIME2 DEFAULT GETDATE(),
    valor_total DECIMAL(10,2) NOT NULL DEFAULT 0,
    status VARCHAR(30) NOT NULL DEFAULT 'Pendente',

    CONSTRAINT FK_Pedido_Cliente
        FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id_cliente)
);
GO

-- ==========================================
-- TABELA: ITEM_PEDIDO
-- ==========================================

CREATE TABLE Item_Pedido (
    id_item INT IDENTITY(1,1) PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,

    CONSTRAINT FK_ItemPedido_Pedido
        FOREIGN KEY (id_pedido)
        REFERENCES Pedido(id_pedido),

    CONSTRAINT FK_ItemPedido_Produto
        FOREIGN KEY (id_produto)
        REFERENCES Produto(id_produto),

    CONSTRAINT CK_ItemPedido_Quantidade
        CHECK (quantidade > 0),

    CONSTRAINT CK_ItemPedido_Preco
        CHECK (preco_unitario >= 0)
);
GO
