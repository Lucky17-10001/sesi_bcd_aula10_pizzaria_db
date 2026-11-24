--Quantas tabelas o banco de dados possui?--

show tables;

--Quantos Clientes cadastrados?--

select * from clientes;
select count(*) from clientes;
select count(*) as `Total de clientes` from clientes;

--Quantas pizzas Cadastradas?--

select count(*) as `Total de pizzas` from pizzas;

--Quantas pizzas o pedido nº 3 possui?--

select * from pedidos;
select * from itens_pedido;
select * from itens_pedido where pedido_id = 3;
select sum(quantidde) from itens_pedido where pedido_id = 3;
select sum(quantidde) as `Total de pizzas` from itens_pedido where pedido_id = 3;

--Qual nome do cliente que fez o pedido nº 3?--

select c.nome from clientes c join pedidos p on c.cliente_id = p.cliente_id where p.pedido_id = 3;

--Quais os nomes das pizzas do pedido nº 3?--

select p.nome from pizzas p join itens_pedido i on p.pizza_id = i.pizza_id where i.pedido_id = 3;

------
insert into Clientes(nome, logradouro, numero, complemento, bairro, referencia) values
("Gaspar Oliveira","Rua Lizandro Silva",21,null,"São Dimas","Ao lado da igrejinha");

insert into Telefones(cliente_id, Telefone) values
(106,"19998981141");

insert into Itens_Pedido( 21, 1, valor) values(1,1,1, (select valor from Pizzas where pizza_id = 1));

insert into Pizzas(nome, descricao, valor) values("A moda do chef","Molho de tomate, palmito macio em rodelas, coberto com catupiry, frango desfiado, ovos, carne seca, oregano e azeitonas",41.9);

[
    {"quantidade":1,"pizza":"Margherita"},
    {"quantidade":2,"pizza":"Napolitana"}
]