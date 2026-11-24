use pizzaria;
drop function if exists moeda;

create function moeda(v float) returns text
return concat("R$ ",v);
select moeda(4.9);
drop function if exists moeda;
delimiter //
create function moeda(v float) returns text
Begin
    return concat("R$ ",v);
end//
delimiter ;
select moeda(5.99);
drop function if exists moeda;
delimiter //
create function moeda(v float) returns text
begin
    declare x varchar(20);
    set x = format(v,2,'de_DE');
    return concat("R$ ",x);
end//
delimiter ;
select pizza_id, nome, moeda(valor) as 'preço' from pizzas;


delimiter //
drop procedure if exists pedido_de_um_item;
CREATE PROCEDURE pedido_de_um_item(cliente_id int, pizza_id int, quantidade int)
BEGIN
   INSERT INTO pedidos(cliente_id) VALUES (cliente_id);
    INSERT INTO itens_pedido(pedido_id, pizza_id, quantidade) VALUES (LAST_INSERT_ID(), pizza_id, quantidade);
END//
delimiter ;

call pedido_de_um_item(91, 28, 2);

select pizza_id, nome, moeda(valor) as 'preço' from pizzas;