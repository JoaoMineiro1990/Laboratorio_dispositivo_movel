-- Tabela de Usuários (igual ao exemplo)
CREATE TABLE USERS (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    password CHAR(60) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE CONSTRAINT proper_email CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

-- Tabela de Geladeiras
CREATE TABLE REFRIGERATORS (
    id UUID PRIMARY KEY, -- ID único da geladeira
    name VARCHAR(255) NOT NULL, -- Nome da geladeira
    description VARCHAR(500), -- Descrição da geladeira
    user_id UUID NOT NULL REFERENCES USERS(id) -- Relacionamento com o usuário dono da geladeira
);

-- Tabela de Produtos
CREATE TABLE PRODUCTS (
    id UUID PRIMARY KEY, -- ID único do produto
    name VARCHAR(255) NOT NULL, -- Nome do produto (não único, pois pode repetir)
    expiration_date DATE NOT NULL, -- Data de validade do produto
    refrigerator_id UUID NOT NULL REFERENCES REFRIGERATORS(id) -- Relacionamento com a geladeira onde está o produto
);
