SELECT * FROM pedidos;
SELECT p.*, c.nome  FROM pedidos p INNER JOIN clientes c
ON p.cliente_id = c.cliente_id;

CREATE VIEW vw_pedidos1 AS
SELECT p.*, c.nome  FROM pedidos p INNER JOIN clientes c
ON p.cliente_id = c.cliente_id;

SELECT * FROM vw_pedidos1;

--todos os pedidos, itens, nome dos clientes e nome das pizzas--
CREATE VIEW vw_pedidos AS
SELECT i.*, c.nome as cliente, pi.nome as pizza
FROM pedidos p JOIN itens_pedido i ON p.pedido_id = i.pedido_id
JOIN clientes c ON c.cliente_id = p.cliente_id
JOIN pizzas pi ON pi.pizza_id = i.pizza_id;

SHOW TABLES;
SELECT * FROM vw_pedidos;

--subtotal--
DROP VIEW vw_pedidos;
CREATE VIEW vw_pedidos AS
SELECT i.*, c.nome as cliente, pi.nome as pizza, (i.valor * i.quantidade) as subtotal
FROM pedidos p JOIN itens_pedido i ON p.pedido_id = i.pedido_id
JOIN clientes c ON c.cliente_id = p.cliente_id
JOIN pizzas pi ON pi.pizza_id = i.pizza_id;


--valor total--

SELECT pedido_id, sum(quantidade * valor) as valor_total from itens_pedido group by pedido_id;

SELECT i.*, c.nome as cliente, pi.nome as pizza, sum(i.valor * i.quantidade) as total
FROM pedidos p JOIN itens_pedido i ON p.pedido_id = i.pedido_id
JOIN clientes c ON c.cliente_id = p.cliente_id
JOIN pizzas pi ON pi.pizza_id = i.pizza_id group by p.pedido_id;

--quantas pizzas cada pedido possui--

SELECT i.*, c.nome as cliente, pi.nome as pizza, sum(i.quantidade) as total_pizza, sum(i.valor * i.quantidade) as total
FROM pedidos p JOIN itens_pedido i ON p.pedido_id = i.pedido_id
JOIN clientes c ON c.cliente_id = p.cliente_id
JOIN pizzas pi ON pi.pizza_id = i.pizza_id group by p.pedido_id; 
