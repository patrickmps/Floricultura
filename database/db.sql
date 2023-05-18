CREATE SCHEMA IF NOT EXISTS floricultura DEFAULT CHARACTER SET utf8;
USE floricultura;
-- CREATE TABLE IF NOT EXISTS customers (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   name VARCHAR(255) NOT NULL,
--   email VARCHAR(255) NOT NULL,
--   password VARCHAR(255) NOT NULL,
--   address_id INT,
--   role ENUM('admin', 'customer') NOT NULL,
--   created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
--   updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
-- );
CREATE TABLE IF NOT EXISTS addresses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  street VARCHAR(255) NOT NULL,
  number INT NOT NULL,
  complement VARCHAR(255),
  neighborhood VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  state VARCHAR(255) NOT NULL,
  country VARCHAR(255) NOT NULL,
  postal_code VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS suppliers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  address_id INT NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  amount INT NOT NULL,
  category_id INT NOT NULL,
  supplier_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  -- customer_id INT NOT NULL,
  amount INT NOT NULL,
  total_price DECIMAL(10, 2) NOT NULL,
  shipping_address_id INT NOT NULL,
  expected_date DATE NOT NULL,
  delivery_date DATE,
  status ENUM(
    'pending',
    'processing',
    'shipped',
    'delivered',
    'canceled'
  ) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- Adicionando chave estrangeira na tabela de suppliers
-- ALTER TABLE customers
-- ADD CONSTRAINT fk_addresses_customers FOREIGN KEY (address_id) REFERENCES addresses(id) ON DELETE CASCADE;
-- Adicionando chave estrangeira na tabela de suppliers
ALTER TABLE suppliers
ADD CONSTRAINT fk_addresses_suppliers FOREIGN KEY (address_id) REFERENCES addresses(id) ON DELETE RESTRICT;
-- Adicionando chave estrangeira na tabela de produtos
ALTER TABLE products
  ADD CONSTRAINT fk_categories FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT,
  ADD CONSTRAINT fk_suppliers FOREIGN KEY (supplier_id) REFERENCES suppliers(id) ON DELETE CASCADE;
-- Adicionando chave estrangeira na tabela de pedidos
ALTER TABLE orders -- ADD CONSTRAINT fk_customers FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
  ADD CONSTRAINT fk_addresses_orders FOREIGN KEY (shipping_address_id) REFERENCES addresses(id) ON DELETE RESTRICT,
  ADD CONSTRAINT fk_products FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE;