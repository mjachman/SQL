drop table if exists wizyty
drop table if exists miasta
drop table if exists pacjenci
drop table if exists lekarze
drop procedure if exists proc1
drop procedure if exists proc2
drop procedure if exists proc3
drop procedure if exists proc4
drop procedure if exists proc5
drop procedure if exists proc6
create table pacjenci(
id_pacjenta varchar(6),
nazwisko varchar(20),
data_ur date)

create table lekarze(
id_lekarza varchar(6),
id_specjalizacji varchar(6),
nr_gab int)

create table miasta(
nazwisko varchar(20),
miasto varchar(20))

create table wizyty(
id_pacjenta varchar(6),
data_wizyty datetime,
id_lekarza varchar(6))

insert into pacjenci values
('A_1234','Kowalska','1989-02-01'),
('A_3456','Nowak','1991-03-03'),
('B_2111','Malicki','1993-05-05')
insert into lekarze values
('P_12','p1',23),('O_34','o1',31),('S_90','S1',40)
insert into miasta values
('Nowak','Gdansk'),('Kowalska','Gdansk'),('Malicki','Sopot')
insert into wizyty values
('A_3456','20190421 18:00','S_90'),
('A_1234','20190513 14:50','O_34'),
('B_2111','20190603 15:00','S_90')

select id_pacjenta,nazwisko,convert(varchar,data_ur,111) as 'data_ur' from pacjenci
select * from lekarze
select * from miasta
select id_pacjenta,convert(varchar(16),data_wizyty,120) as 'data wizyty',id_lekarza from wizyty
go
create proc proc1 as
select nazwisko, data_ur, datediff(year,data_ur,getdate()) as 'wiek' from pacjenci
select nazwisko as 'nazwisko osoby najstarszej' from pacjenci 
where data_ur=(select min(data_ur) from pacjenci)
go
exec proc1
go
create proc proc2 as
select miasto,convert(varchar(16),data_wizyty,120) as 'data wizyty',
pacjenci.nazwisko from pacjenci join miasta on 
pacjenci.nazwisko=miasta.nazwisko
join wizyty on pacjenci.id_pacjenta=wizyty.id_pacjenta where miasto='Gdansk'
go
exec proc2 
go 
create proc proc3 @miasto varchar(20) as
select miasto, convert(varchar(16),data_wizyty,120) as 'data wizyty', pacjenci.nazwisko, 
lekarze.id_lekarza, id_specjalizacji
from wizyty join pacjenci on pacjenci.id_pacjenta=wizyty.id_pacjenta
join miasta on miasta.nazwisko=pacjenci.nazwisko join lekarze on wizyty.id_lekarza=lekarze.id_lekarza
where miasto=@miasto
go
exec proc3 'Gdansk'
go 
create proc proc4 @miasto varchar(20) as
select miasto, convert(varchar(16),data_wizyty,120) as 'data wizyty', pacjenci.nazwisko, 
lekarze.id_lekarza, id_specjalizacji
from wizyty join pacjenci on pacjenci.id_pacjenta=wizyty.id_pacjenta
join miasta on miasta.nazwisko=pacjenci.nazwisko join lekarze on wizyty.id_lekarza=lekarze.id_lekarza
where miasto!=@miasto
go
exec proc4 'Gdansk'
go 
create proc proc5 @nazwisko varchar(20) as
select nazwisko, convert(varchar(16),data_wizyty,120) as 'data wizyty', 
lekarze.id_lekarza, id_specjalizacji, nr_gab
from wizyty join pacjenci on pacjenci.id_pacjenta=wizyty.id_pacjenta
join lekarze on wizyty.id_lekarza=lekarze.id_lekarza
where pacjenci.nazwisko=@nazwisko
go
exec proc5 'Nowak'
go 
create proc proc6 @nazwisko varchar(20) as
select  convert(varchar(16),data_wizyty,120) as 'data wizyty', 
lekarze.id_lekarza, id_specjalizacji, nr_gab,nazwisko
from wizyty join pacjenci on pacjenci.id_pacjenta=wizyty.id_pacjenta
join lekarze on wizyty.id_lekarza=lekarze.id_lekarza
where convert(varchar,data_wizyty,23)=convert(varchar,getdate(),23)
go
exec proc6 'Nowak'
