USE Pizzaria;

DROP TRIGGER IF EXISTS trg_atualiza_valor_pedido;

DELIMITER $$

CREATE TRIGGER trg_atualiza_valor_pedido
AFTER INSERT ON Itens_Pedido
FOR EACH ROW
BEGIN
    UPDATE Pedidos
    SET valor = COALESCE(valor, 0) + (NEW.valor * NEW.quantidade)
    WHERE pedido_id = NEW.pedido_id;
END$$

DELIMITER ;


---------------------------------------------------------------------------------------------------------------------------------------------

USE Pizzaria;

INSERT INTO Pedidos (cliente_id, data, hora, valor)
VALUES ((SELECT cliente_id FROM Clientes WHERE nome = 'Claudiane Mendes Trigueiro Silva'), CURDATE(), CURTIME(), 0);

SET @ultimo_pedido = LAST_INSERT_ID();

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor)
VALUES 
    (@ultimo_pedido, (SELECT pizza_id FROM Pizzas WHERE nome = 'Aliche'), 2, (SELECT valor FROM Pizzas WHERE nome = 'Aliche')),
    (@ultimo_pedido, (SELECT pizza_id FROM Pizzas WHERE nome = 'Firense'), 1, (SELECT valor FROM Pizzas WHERE nome = 'Firense'));

INSERT INTO Pedidos (cliente_id, data, hora, valor)
VALUES ((SELECT cliente_id FROM Clientes WHERE nome = 'Diogo Matos da Silva'), CURDATE(), CURTIME(), 0);

SET @ultimo_pedido = LAST_INSERT_ID();

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor)
VALUES 
    (@ultimo_pedido, (SELECT pizza_id FROM Pizzas WHERE nome = 'Toscana'), 2, (SELECT valor FROM Pizzas WHERE nome = 'Toscana')),
    (@ultimo_pedido, (SELECT pizza_id FROM Pizzas WHERE nome = 'Grega'), 1, (SELECT valor FROM Pizzas WHERE nome = 'Grega'));

INSERT INTO Pedidos (cliente_id, data, hora, valor)
VALUES ((SELECT cliente_id FROM Clientes WHERE nome = 'Eder Almeida Batista de Oliveira'), CURDATE(), CURTIME(), 0);

SET @ultimo_pedido = LAST_INSERT_ID();

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor)
VALUES 
    (@ultimo_pedido, (SELECT pizza_id FROM Pizzas WHERE nome = 'Canadense'), 1, (SELECT valor FROM Pizzas WHERE nome = 'Canadense')),
    (@ultimo_pedido, (SELECT pizza_id FROM Pizzas WHERE nome = 'Margherita'), 2, (SELECT valor FROM Pizzas WHERE nome = 'Margherita'));

-------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    p.pedido_id,
    c.nome AS cliente,
    p.valor AS valor_total_pedido
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.cliente_id
WHERE c.nome IN (
    'Claudiane Mendes Trigueiro Silva',
    'Diogo Matos da Silva',
    'Eder Almeida Batista de Oliveira'
);
