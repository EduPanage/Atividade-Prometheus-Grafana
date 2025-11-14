CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(200),
    categoria VARCHAR(100),
    preco DECIMAL(10,2),
    estoque INT
);

CREATE TABLE vendas (
    id SERIAL PRIMARY KEY,
    produto_id INT REFERENCES produtos(id),
    quantidade INT,
    valor_total DECIMAL(10,2),
    data_venda TIMESTAMP DEFAULT NOW()
);

-- Inserir 25 produtos
INSERT INTO produtos (nome, categoria, preco, estoque) VALUES
('Notebook Dell', 'Eletrônicos', 3299.90, 15),
('Mouse Logitech', 'Eletrônicos', 149.90, 50),
('Teclado Mecânico', 'Eletrônicos', 599.90, 30),
('Monitor LG 27"', 'Eletrônicos', 1299.90, 20),
('Webcam HD', 'Eletrônicos', 299.90, 40),
('Clean Code', 'Livros', 89.90, 100),
('Design Patterns', 'Livros', 119.90, 80),
('JavaScript', 'Livros', 69.90, 70),
('Python Data', 'Livros', 79.90, 60),
('Algoritmos', 'Livros', 199.90, 40),
('Camiseta', 'Roupas', 49.90, 200),
('Calça Jeans', 'Roupas', 159.90, 150),
('Jaqueta', 'Roupas', 299.90, 80),
('Tênis', 'Roupas', 349.90, 100),
('Boné', 'Roupas', 79.90, 120),
('Café Gourmet', 'Alimentos', 39.90, 300),
('Chocolate', 'Alimentos', 29.90, 250),
('Azeite', 'Alimentos', 59.90, 180),
('Mel Orgânico', 'Alimentos', 44.90, 200),
('Cookies', 'Alimentos', 24.90, 350),
('Cadeira Gamer', 'Móveis', 1299.90, 35),
('Mesa Escritório', 'Móveis', 899.90, 25),
('Estante', 'Móveis', 599.90, 40),
('Poltrona', 'Móveis', 1899.90, 15),
('Luminária LED', 'Móveis', 199.90, 60);

-- Inserir 30 vendas
INSERT INTO vendas (produto_id, quantidade, valor_total, data_venda) VALUES
(1, 2, 6599.80, NOW() - INTERVAL '1 day'),
(2, 5, 749.50, NOW() - INTERVAL '1 day'),
(6, 3, 269.70, NOW() - INTERVAL '2 days'),
(11, 10, 499.00, NOW() - INTERVAL '3 days'),
(21, 1, 1299.90, NOW() - INTERVAL '3 days'),
(3, 2, 1199.80, NOW() - INTERVAL '4 days'),
(16, 8, 319.20, NOW() - INTERVAL '5 days'),
(12, 4, 639.60, NOW() - INTERVAL '5 days'),
(4, 1, 1299.90, NOW() - INTERVAL '6 days'),
(7, 2, 239.80, NOW() - INTERVAL '7 days'),
(22, 1, 899.90, NOW() - INTERVAL '8 days'),
(14, 3, 1049.70, NOW() - INTERVAL '9 days'),
(8, 5, 349.50, NOW() - INTERVAL '10 days'),
(17, 12, 358.80, NOW() - INTERVAL '11 days'),
(5, 3, 899.70, NOW() - INTERVAL '12 days'),
(13, 2, 599.80, NOW() - INTERVAL '13 days'),
(23, 1, 599.90, NOW() - INTERVAL '14 days'),
(9, 4, 319.60, NOW() - INTERVAL '15 days'),
(18, 6, 359.40, NOW() - INTERVAL '16 days'),
(10, 2, 399.80, NOW() - INTERVAL '17 days'),
(24, 1, 1899.90, NOW() - INTERVAL '18 days'),
(19, 10, 449.00, NOW() - INTERVAL '19 days'),
(15, 5, 399.50, NOW() - INTERVAL '20 days'),
(20, 8, 199.20, NOW() - INTERVAL '21 days'),
(25, 2, 399.80, NOW() - INTERVAL '22 days'),
(1, 1, 3299.90, NOW() - INTERVAL '23 days'),
(6, 5, 449.50, NOW() - INTERVAL '24 days'),
(11, 15, 748.50, NOW() - INTERVAL '25 days'),
(16, 20, 798.00, NOW() - INTERVAL '26 days'),
(21, 2, 2599.80, NOW() - INTERVAL '27 days');