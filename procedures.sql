SELECT valor FROM pizzas WHERE pizza_id = 5;
SELECT valor FROM pizzas WHERE pizza_id = 28;

INSERT INTO pedidos VALUES
(default, 98, CURDATE(), NOW(), null);

SELECT * FROM pedidos ORDER BY pedido_id DESC LIMIT 1;
SELECT LAST_INSERT_ID();

INSERT INTO itens_pedido VALUES
(27,5,1,(SELECT valor FROM pizzas WHERE pizza_id = 5)),
(27,28,2,(SELECT valor FROM pizzas WHERE pizza_id = 28));

SELECT * FROM itens_pedido WHERE pedido_id = 27;

SELECT sum(valor * quantidade) FROM itens_pedido WHERE pedido_id = 27;

UPDATE pedidos
    SET valor = (SELECT sum(valor * quantidade) FROM itens_pedido WHERE pedido_id = 27)
    WHERE pedido_id = 27;

SELECT * FROM pedidos WHERE pedido_id = 27;

DELIMITER $
CREATE PROCEDURE atulizaValorPedido(id int)
    BEGIN
        UPDATE pedidos
        SET valor = (SELECT sum(valor * quantidade) FROM itens_pedido WHERE pedido_id = id)
        WHERE pedido_id = id;
    END $
DELIMITER ;

DROP PROCEDURE IF EXISTS atulizaValorPedido;
CREATE PROCEDURE atulizaValorPedido(id int)
UPDATE pedidos
    SET valor = (SELECT sum(valor * quantidade) FROM itens_pedido WHERE pedido_id = id)
    WHERE pedido_id = id;

SELECT * FROM pedidos WHERE pedido_id = 27;
UPDATE pedidos SET valor = null WHERE pedido_id = 27;
SELECT * FROM pedidos WHERE pedido_id = 27;
-- Utilizar o Procedimento para alterar
CALL atulizaValorPedido(27);
SELECT * FROM pedidos WHERE pedido_id = 27;

SHOW PROCEDURE STATUS;

SELECT * FROM clientes;
SELECT * FROM pizzas;
INSERT INTO pedidos VALUES (default, 91, CURDATE(), NOW(), null);
INSERT INTO itens_pedido VALUES (28,28, 2,(SELECT valor FROM pizzas WHERE pizza_id = 28));
SELECT * FROM pedidos WHERE pedido_id = 28;
CALL atulizaValorPedido(28);
SELECT * FROM pedidos WHERE pedido_id = 28;








DELIMITER $

CREATE PROCEDURE pedidoDeUmItem(cli_id INT, piz_id INT, qtd INT)
BEGIN
    INSERT INTO pedidos VALUES (DEFAULT, cli_id, CURDATE(), NOW(), NULL);
    INSERT INTO itens_pedido VALUES (LAST_INSERT_ID(), piz_id, qtd,(SELECT valor FROM pizzas WHERE pizza_id = piz_id));

    UPDATE pedidos SET valor = ( SELECT SUM(valor * quantidade) FROM itens_pedido WHERE pedido_id = LAST_INSERT_ID())
    WHERE pedido_id = LAST_INSERT_ID();
8
END$

DELIMITER ;

CALL pedidoDeUmItem(95, 40, 1);
CALL pedidoDeUmItem(105, 38, 2);
CALL pedidoDeUmItem(92, 40, 1);
CALL pedidoDeUmItem(92, 13, 2);

SELECT * FROM itens_pedido
ORDER BY pedido_id DESC
LIMIT 4;

SELECT * FROM pedidos
ORDER BY pedido_id DESC
LIMIT 4;