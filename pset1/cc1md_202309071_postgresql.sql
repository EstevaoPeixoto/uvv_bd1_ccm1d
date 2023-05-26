-- Exclui o Banco de Dados caso já exista

DROP DATABASE IF EXISTS uvv;

-- Cria o usuário dono do Banco de Dados e exclui caso já exista

DROP 	USER IF EXISTS estevao;

CREATE 	USER estevao 	WITH 	CREATEDB
				CREATEROLE
				ENCRYPTED PASSWORD 'est'
;

-- Cria o Banco de Dados "uvv" / Comenta o Banco de Dados

CREATE DATABASE uvv	WITH 	OWNER = estevao
	     			TEMPLATE = template0
				ENCODING = UTF8
				lc_collate = 'pt_BR.UTF-8'
				lc_ctype = 'pt_BR.UTF-8'
				allow_connections = true
;

COMMENT ON DATABASE 	uvv					IS 'Banco de Dados da uvv';
-- Conecta ao Banco de Dados "uvv"

\c uvv;

-- Cria e comenta o esquema do Banco de Dados

CREATE SCHEMA lojas AUTHORIZATION estevao;

COMMENT ON SCHEMA 	lojas					IS 'Esquema das lojas UVV';


-- Muda o esquema padrão do usuário "estevao"


ALTER ROLE estevao SET SEARCH_PATH TO lojas, "$user", public;


-- Cria a tabela produtos



CREATE TABLE 		produtos (
                	produto_id 					NUMERIC(38) 		NOT NULL,
                	nome 						VARCHAR(255) 		NOT NULL,
                	preco_unitario 					NUMERIC(10,2),
                	detalhes 					BYTEA,
                	imagem 						BYTEA,
                	imagem_mime_type 				VARCHAR(512),
                	imagem_arquivo 					VARCHAR(512),
                	imagem_charset 					VARCHAR(512),
                	imagem_ultima_atualizacao 			DATE,
                	CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);



-- Comentando a tabela "produtos"


COMMENT ON TABLE 	produtos 				IS 'Tabela para armazenamento dos produtos';


-- Comentando as colunas da tabela "produtos"


COMMENT ON COLUMN 	produtos.produto_id 			IS 'Coluna PK da tabela "produtos"';
COMMENT ON COLUMN 	produtos.nome 				IS 'Coluna que armazena o nome do produto registrado';
COMMENT ON COLUMN 	produtos.preco_unitario 		IS 'Coluna para conferência do preço unitário do produto registrado';
COMMENT ON COLUMN 	produtos.detalhes 			IS 'Coluna que armazena os dados extras do produto registrado';
COMMENT ON COLUMN 	produtos.imagem 			IS 'Coluna que armazena a imagem do produto registrado';
COMMENT ON COLUMN 	produtos.imagem_mime_type 		IS 'Coluna que armazena a extensão do arquivo da imagem do produto';
COMMENT ON COLUMN 	produtos.imagem_arquivo 		IS 'Coluna que armazena o arquivo da imagem do produto';
COMMENT ON COLUMN 	produtos.imagem_charset 		IS 'Coluna que armazena o código da imagem do produto';
COMMENT ON COLUMN 	produtos.imagem_ultima_atualizacao 	IS 'Coluna que armazena a data da ultima atualização da imagem do produto';


-- Criando a tabela "lojas"



CREATE TABLE 		lojas (
                	loja_id 					NUMERIC(38) 	NOT NULL,
                	nome 						VARCHAR(255) 	NOT NULL,
                	endereco_web 					VARCHAR(100),
                	endereco_fisico 				VARCHAR(512),
                	latitude 					NUMERIC,
                	longitude 					NUMERIC,
                	logo 						BYTEA,
                	logo_mime_type 					VARCHAR(512),
                	logo_arquivo 					VARCHAR(512),
                	logo_charset 					VARCHAR(512),
                	logo_ultima_atualizacao 			DATE,
                	CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);




-- Comentando a tabela "lojas"


COMMENT ON TABLE 	lojas 					IS 'Tabela para registro das lojas';


-- Comentando as colunas da tabela "lojas"


COMMENT ON COLUMN 	lojas.loja_id 				IS 'Coluna PK da tabela "lojas"';
COMMENT ON COLUMN 	lojas.nome 				IS 'Coluna para registro do nome da loja registrada';
COMMENT ON COLUMN 	lojas.endereco_web 			IS 'Coluna para armazenamento do endereço web do site registrado';
COMMENT ON COLUMN 	lojas.endereco_fisico 			IS 'Coluna para armazenamento do endereço físico da loja registrada';
COMMENT ON COLUMN 	lojas.latitude 				IS 'Coluna para armazenamento da latitude da loja registrada';
COMMENT ON COLUMN 	lojas.longitude 			IS 'Coluna para armazenamento da longitude da loja registrada';
COMMENT ON COLUMN 	lojas.logo 				IS 'Coluna que armazena a logo da loja registrada';
COMMENT ON COLUMN 	lojas.logo_mime_type 			IS 'Coluna para armazenamento da extensão do arquivo da loja registrada';
COMMENT ON COLUMN 	lojas.logo_arquivo 			IS 'Coluna para armazenamento do arquivo da loja registrada';
COMMENT ON COLUMN 	lojas.logo_charset 			IS 'Coluna para armazenamento do código da logo da loja registrada';
COMMENT ON COLUMN 	lojas.logo_ultima_atualizacao 		IS 'Coluna que guarda a data da ultima atualização da logo da loja registrada';


-- Criando a tabela "estoques"



CREATE TABLE 		estoques (
                	estoque_id 					NUMERIC(38) NOT NULL,
                	loja_id 					NUMERIC(38) NOT NULL,
                	produto_id 					NUMERIC(38) NOT NULL,
                	quantidade 					NUMERIC(38) NOT NULL,
                	CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);


-- Comentando a tabela "estoques"


COMMENT ON TABLE 	estoques 				IS 'Tabela que relaciona "lojas" e "produtos"';


-- Comentando as colunas da tabela "estoques"


COMMENT ON COLUMN 	estoques.estoque_id 			IS 'Coluna PK da tabela "estoques"';
COMMENT ON COLUMN 	estoques.loja_id 			IS 'Coluna FK da tabela "lojas"';
COMMENT ON COLUMN 	estoques.produto_id 			IS 'Coluna FK da tabela "produtos"';
COMMENT ON COLUMN 	estoques.quantidade 			IS 'Coluna que armazena a quantidade de produtos no estoque';


-- Criando a tabela "clientes"



CREATE TABLE 		clientes (
                	cliente_id 					NUMERIC(38) 	NOT NULL,
                	email 						VARCHAR(255) 	NOT NULL,
                	nome 						VARCHAR(255) 	NOT NULL,
                	telefone1 					VARCHAR(20),
                	telefone2 					VARCHAR(20),
                	telefone3 					VARCHAR(20),
                	CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);


-- Comentando a tabela "clientes"


COMMENT ON TABLE 	clientes 				IS 'Tabela para armazenamento de informações dos clientes';


-- Comentando as colunas da tabela "clientes"


COMMENT ON COLUMN 	clientes.cliente_id 			IS 'Coluna PK da tabela "clientes"';
COMMENT ON COLUMN 	clientes.email 				IS 'Coluna para armazenamento do email do cliente registrado';
COMMENT ON COLUMN 	clientes.nome 				IS 'Coluna para armazenamento do nome do cliente registrado.';
COMMENT ON COLUMN 	clientes.telefone1 			IS 'Coluna para armazenamento do telefone do cliente';
COMMENT ON COLUMN 	clientes.telefone2 			IS 'Coluna para armazenamento do telefone do cliente';
COMMENT ON COLUMN 	clientes.telefone3 			IS 'Coluna para armazenamento do telefone do cliente';


-- Criando a tabela "envios"



CREATE TABLE 		envios (
                	envio_id 					NUMERIC(38) 	NOT NULL,
                	loja_id 					NUMERIC(38) 	NOT NULL,
                	cliente_id 					NUMERIC(38) 	NOT NULL,
                	endereco_entrega 				VARCHAR(512) 	NOT NULL,
                	status 						VARCHAR(15) 	NOT NULL,
                	CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);


-- Comentando a tabela "envios"


COMMENT ON TABLE 	envios 					IS 'Tabela que relaciona "clientes" e "lojas"';


-- Comentando as colunas da tabela "envios"


COMMENT ON COLUMN 	envios.envio_id 			IS 'Coluna PK da tabela "envios"';
COMMENT ON COLUMN 	envios.loja_id 				IS 'Coluna FK da tabela "lojas"';
COMMENT ON COLUMN 	envios.cliente_id 			IS 'Coluna FK da tabela "clientes"';
COMMENT ON COLUMN 	envios.endereco_entrega 		IS 'Coluna que armazena os endereços de entrega';
COMMENT ON COLUMN 	envios.status 				IS 'Coluna que armazena o status das entregas';


-- Criando a tabela "pedidos"



CREATE TABLE 		pedidos (
                	pedido_id 					NUMERIC(38) 	NOT NULL,
                	data_hora 					TIMESTAMP 	NOT NULL,
                	cliente_id 					NUMERIC(38) 	NOT NULL,
                	status 						VARCHAR(15) 	NOT NULL,
                	loja_id 					NUMERIC(38) 	NOT NULL,
                	CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);


-- Comentando a tabela "pedidos"


COMMENT ON TABLE 	pedidos 				IS 'Tabela que relaciona "clientes" e "lojas"';


-- Comentando as colunas da tabela "pedidos"


COMMENT ON COLUMN 	pedidos.pedido_id 			IS 'Coluna PK da tabela "pedidos"';
COMMENT ON COLUMN 	pedidos.data_hora 			IS 'Coluna que armazena os dados de tempo do pedido';
COMMENT ON COLUMN 	pedidos.cliente_id 			IS 'Coluna FK da tabela "clientes"';
COMMENT ON COLUMN 	pedidos.status 				IS 'Coluna para armazenamento do status do pedido';
COMMENT ON COLUMN 	pedidos.loja_id 			IS 'Coluna FK da tabela "lojas"';


-- Criando a tabela "pedidos_itens"



CREATE TABLE 		pedidos_itens (
                	pedido_id 					NUMERIC(38) 	NOT NULL,
                	produto_id 					NUMERIC(38) 	NOT NULL,
                	numero_da_linha 				NUMERIC(38) 	NOT NULL,
                	preco_unitario 					NUMERIC(10,2) 	NOT NULL,
                	quantidade 					NUMERIC(38) 	NOT NULL,
                	envio_id 					NUMERIC(38) 	NOT NULL,
                	CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);


-- Comentando a tabela "pedidos_itens"


COMMENT ON TABLE 	pedidos_itens 				IS 'Tabela que relaciona as tabelas "envios", "produtos" e "pedidos"';


-- Comentando as colunas da tabela "pedidos_itens"


COMMENT ON COLUMN 	pedidos_itens.pedido_id 		IS 'Coluna PFK entre as tabelas "pedidos_itens", "produtos", "pedidos", "envios"';
COMMENT ON COLUMN 	pedidos_itens.produto_id 		IS 'Coluna PFK entre as tabelas "pedidos_itens", "produtos", "pedidos", "envios"';
COMMENT ON COLUMN 	pedidos_itens.numero_da_linha 		IS 'Coluna que armazena o número da linha do pedido para conferência';
COMMENT ON COLUMN 	pedidos_itens.preco_unitario 		IS 'Coluna para conferência do preço unitário de cada item';
COMMENT ON COLUMN 	pedidos_itens.quantidade 		IS 'Coluna para conferência da quantidade de pedidos';
COMMENT ON COLUMN 	pedidos_itens.envio_id 			IS 'Coluna FK da tabela "envios"';



-- Criando as Constraints



ALTER TABLE 		estoques ADD CONSTRAINT fk_produtos_estoques
			FOREIGN KEY (produto_id)
			REFERENCES produtos (produto_id)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
			NOT DEFERRABLE;

ALTER TABLE 		pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
			FOREIGN KEY (produto_id)
			REFERENCES produtos (produto_id)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
			NOT DEFERRABLE;

ALTER TABLE 		estoques ADD CONSTRAINT lojas_estoques_fk
			FOREIGN KEY (loja_id)
			REFERENCES lojas (loja_id)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
			NOT DEFERRABLE;

ALTER TABLE 		pedidos ADD CONSTRAINT lojas_pedidos_fk
			FOREIGN KEY (loja_id)
			REFERENCES lojas (loja_id)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
			NOT DEFERRABLE;

ALTER TABLE 		envios ADD CONSTRAINT lojas_envios_fk
			FOREIGN KEY (loja_id)
			REFERENCES lojas (loja_id)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
			NOT DEFERRABLE;

ALTER TABLE 		pedidos ADD CONSTRAINT clientes_pedidos_fk
			FOREIGN KEY (cliente_id)
			REFERENCES clientes (cliente_id)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
			NOT DEFERRABLE;

ALTER TABLE 		envios ADD CONSTRAINT clientes_envios_fk
			FOREIGN KEY (cliente_id)
			REFERENCES clientes (cliente_id)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
			NOT DEFERRABLE;

ALTER TABLE 		pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
			FOREIGN KEY (envio_id)
			REFERENCES envios (envio_id)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
			NOT DEFERRABLE;

ALTER TABLE 		pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
			FOREIGN KEY (pedido_id)
			REFERENCES pedidos (pedido_id)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION
			NOT DEFERRABLE;


-- Adicionando as Constraints


ALTER TABLE 		lojas 		ADD CONSTRAINT endereco_lojas_check 			CHECK (COALESCE(endereco_web, endereco_fisico) IS NOT NULL);

ALTER TABLE 		pedidos		ADD CONSTRAINT status_pedidos_check			CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

ALTER TABLE		envios		ADD CONSTRAINT status_envios_check	   		CHECK (status IN('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

ALTER TABLE		pedidos_itens 	ADD CONSTRAINT preco_unitario_pedido_itens_check	CHECK (preco_unitario > 0);

ALTER TABLE		estoques	ADD CONSTRAINT quantidade_estoques_check		CHECK (quantidade > 0);

ALTER TABLE		produtos	ADD CONSTRAINT preco_unitario_produtos_check		CHECK (preco_unitario > 0);

