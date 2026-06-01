create database StreamingDeMusica;

Use StreamingDeMusica;

create table Artistas (
ID_Artista int auto_increment primary key,
Nombre varchar(100),
Apellido varchar(100),
Nombre_Arts varchar(100),
Edad int,
Genero enum('M' , 'F')
);

create table Albumes (
ID_Album int auto_increment primary key,
Titulo varchar(100),
ID_Artista int,
foreign key (ID_Artista) references Artistas (ID_Artista),
Genero varchar(100)
);

create table Reproducciones (
ID_Reproduccion int auto_increment primary key,
ID_Album int,
foreign key (ID_Album) references Albumes (ID_Album),
Cant_Rep int
);

insert into Artistas(Nombre, Apellido, Nombre_Arts, Edad, Genero)
values('Peter Gene','Hernandez', 'Bruno Mars', 41 , 'M'),
('Stefani Joanne Angelina', 'Germanotta', 'Lady Gaga', 40, 'F'),
('Justin Drew', 'Bieber', 'Justin Bieber', 32 , 'M'),
('Jacques Bermon', 'Webster II', 'Travis Scott', 35 , 'M'),
('Billie Eilish Pirate', 'Baird OConnell', 'Billie Eilish', 24, 'F');

insert into Albumes (Titulo, ID_Artista, Genero)
values('24K Magic', 1, 'Pop/R&B'),
('The Fame', 2, 'Pop/Dance'),
('Purpose', 3, 'Pop/R&B'),
('Astroworld', 4, 'HipHop'),
('Happier Than Ever', 5, 'Alternative/Pop');

insert into Reproducciones (ID_Album, Cant_Rep)
values (1,1000000),
(2,60000),
(3,1000000),
(4,55000),
(5,2500000);

select Artistas.Nombre_Arts,sum(Reproducciones.Cant_Rep) as TotalReproducciones
From Artistas
inner join Albumes on Artistas.ID_Artista = Albumes.ID_Artista
inner join Reproducciones on Albumes.ID_Album = Reproducciones.ID_Album
group by Artistas.ID_Artista, Artistas.Nombre_Arts
having count(Albumes.ID_Album) > 3
and sum(Reproducciones.Cant_Rep) > 1000000;

select Albumes.Titulo ,Artistas.Nombre_Arts, avg(Reproducciones.Cant_Rep) as Promedio_Reproduccion
From Albumes 
inner join Artistas on Albumes.ID_Artista = Artistas.ID_Artista
inner join Reproducciones  on Albumes.ID_Album = Reproducciones.ID_Album
group by Albumes.ID_Album, Albumes.Titulo, Artistas.Nombre_Arts
having avg(Reproducciones.Cant_Rep) > 50000;

select Artistas.Nombre_Arts, sum(Reproducciones.Cant_Rep) as TotalReproducciones
From Artistas 
inner join Albumes on Artistas.ID_Artista = Albumes.ID_Artista
inner join Reproducciones  on Albumes.ID_Album = Reproducciones.ID_Album
group by Artistas.ID_Artista, Artistas.Nombre_Arts
having count(Albumes.ID_Album) >= 1
order by TotalReproducciones asc
limit 1;
