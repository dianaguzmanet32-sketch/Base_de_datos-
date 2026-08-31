Create database EcoMove;
use EcoMove;

create table Tecnicos (
IDTecnico int auto_increment primary key,
Nombre varchar(50),
Apellido varchar(50)
);

create table Revisiones(
IDRevision int auto_increment primary key,
Fecha date,
Estado enum("Arreglado","Pendiente","EN revision"),
Bateria int,
Costo decimal(10,2),
Piezarem varchar(100),
Tipo_servicio varchar(100),
IDTecnico int,
FOREIGN KEY(IDTecnico) references Tecnicos(IDTecnico)
);

create table Vehiculos(
IDVehiculo int auto_increment primary key,
Marca varchar(25),
Tipo varchar(20),
IDRevision int,
Foreign key (IDRevision)references Revisiones(IDRevision)
);

Create table Organizaciones(
IDOrganizacion int auto_increment primary key,
Nombre varchar(50),
IDVehiculo int,
Foreign key (IDVehiculo) references Vehiculos(IDVehiculo)
);

Insert into Tecnicos(Nombre, Apellido) values
("Benja", "Sala"),
("Diana", "Fernandez"),
("Laura", "Lopez");

Insert into Revisiones(Fecha,Estado,Bateria,Costo,Piezarem,Tipo_servicio,IDTecnico) values
(2026-06-06,"Pendiente", 99 , 1200.50,"Tornillo","Preventivo",1),
(2026-09-09,"Arreglado",15,1500.50,"Pedal","Correctivo",2),
("Laura", "Lopez",16,1390.50,"Palanca","Preventivo",3);

Insert into Vehiculos(Marca, Tipo, IDRevision) values
("Ferrari", "Auto",1),
("Toyota", "Moto",2),
("Ferrario", "Camion",3);

Insert into Organizaciones(Nombre, IDVehiculo) values
("Buenito", 1),
("Dolar", 2),
("Losa", 3);


-- 1
select Vehiculos.Nombre, Organizaciones.IDOrganizacion
from Vehiculos
inner join Organizaciones
on Vehiculos.IDVehiculo=Organizaciones.IDVehiculo;


-- 2
select Costo
from Revisiones
where Costo >( select avg(costo)
from revisiones);