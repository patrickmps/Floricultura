CREATE SCHEMA IF NOT EXISTS floricultura DEFAULT CHARACTER SET utf8;
USE floricultura;
CREATE TABLE IF NOT EXISTS plantas(
  id_planta INT AUTO_INCREMENT PRIMARY KEY ,
  nome VARCHAR(255) NOT NULL,
  especie VARCHAR(255) NOT NULL,
  descricao TEXT,
  preco DECIMAL(10, 2) NOT NULL,
  quantidade_em_estoque INT NOT NULL,
  id_fornecedor INT NOT NULL,
  dt_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
  dt_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS fornecedores (
  id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  endereco VARCHAR(255) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  dt_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
  dt_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS entregas (
  id_entrega INT AUTO_INCREMENT PRIMARY KEY,
  id_venda INT NOT NULL,
  data_prevista DATE NOT NULL,
  data_entrega DATE,
  dt_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
  dt_atualizacao DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS vendas (
  id_venda INT AUTO_INCREMENT PRIMARY KEY,
  id_planta INT NOT NULL,
  quantidade INT NOT NULL,
  valor_total DECIMAL(10, 2) NOT NULL,
  dt_criacao DATETIME DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE plantas 
  ADD CONSTRAINT FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor) ON DELETE CASCADE;

ALTER TABLE vendas 
  ADD CONSTRAINT FOREIGN KEY (id_planta) REFERENCES plantas(id_planta) ON DELETE RESTRICT;

ALTER TABLE entregas 
  ADD CONSTRAINT FOREIGN KEY (id_venda) REFERENCES vendas(id_venda) ON DELETE CASCADE;
