create database Restaurantes;
use Restaurantes;

create table Restaurantes (
    ID_Restaurante int auto_increment primary key,
    Nombre varchar(100),
    Zona varchar(50)
);

create table Platos (
    ID_Plato int  auto_increment primary key,
    Nombre_p varchar(100),
    Precio decimal(10,2),
    ID_Restaurante int,
    foreign key (ID_Restaurante) references Restaurantes(ID_Restaurante)
);

create table Pedidos (
    ID_Pedido int  auto_increment primary key,
    ID_Plato int,
    foreign key (id_plato) references platos(id_plato),
    Cantidad int
);

insert into Restaurantes (Nombre , Zona) values 
('Restaurante clasico', 'norte'), 
('burger king', 'centro'),
('dominos pizza', 'sur'), 
('sushi easy', 'norte'), 
('taco bell', 'oeste');
 
insert into platos (Nombre_p, Precio, ID_Restaurante) values 
('hamburguesa clasica', 250.00, 1),
('hamburguesa con xtra cheddar', 300.00, 2),
('pizza de peperoni', 1800.00, 3),
('sushi roll', 1500.00, 4),
('taco de carne', 120.00, 5);

insert into pedidos (ID_Plato, Cantidad) 
values (1, 25),(2, 5),(3, 6),( 4, 10),
(5, 1);

select Restaurantes.Nombre, sum(Pedidos.Cantidad) as total_ventas
from Restaurantes 
inner join Platos on Restaurantes.ID_Restaurante = Platos.ID_Restaurante
inner join Pedidos on Platos.ID_Plato = Pedidos.ID_Plato
group by Restaurantes.ID_Restaurante, Restaurantes.Nombre
having count(Platos.ID_Plato) > 5 
and sum(Pedidos.Cantidad) > 200;

select Restaurantes.Nombre, avg(Platos.Precio * Pedidos.Cantidad) as Promedio_Ingresos
From Restaurantes 
inner join Platos  on Restaurantes.ID_Restaurante = Platos.ID_Restaurante
inner join Pedidos  on Platos.ID_Plato = Pedidos.ID_Plato
where Platos.Precio > 1500
group by Restaurantes.Nombre;

select Platos.Nombre_p , sum(Pedidos.Cantidad) as Cantidad_Vendida
from Restaurantes 
inner join Platos on Restaurantes.ID_Restaurante = Platos.ID_Restaurante
inner join Pedidos on Platos.ID_Plato = Pedidos.ID_Plato
where Restaurantes.Nombre = 'pizza'
group by Platos.Nombre_p
order by Cantidad_Vendida desc
limit 10;
