drop table if exists tabela1
drop table if exists tabela2
drop table if exists tabela3
drop table if exists tabela4
drop table if exists tabela5
drop table if exists tabela6
--zad 25
create table tabela1(
Lp int primary key identity,
[Data] date,
Nazwisko varchar(30))

create table tabela2(
Lp int primary key identity,
Nazwisko varchar(30),
Miasto varchar(30))

create table tabela3(
Lp int primary key identity,
Nazwisko varchar(30),
Brutto int)
insert into tabela1(Nazwisko,[Data]) values
('Kowalski','1998-09-01'),
('Malinowska','1991-10-09'),
('Nowak','2001-02-09'),
('Kowalewski','2002-03-12')
insert into tabela2 values
('Kowalski','Sopot'),
('Nowak','Gdañsk'),
('Malinowska','Gdañsk'),
('Kowalewski','Gdynia')
insert into tabela3 values
('Kowalski',8120),
('Malinowska',7891),
('Nowak',9882),
('Kowalewski',6789)

select * from tabela1
select * from tabela2
select tabela3.Nazwisko, 0.77*Brutto as 'Netto' from tabela2 join tabela3 on tabela2.Nazwisko=tabela3.Nazwisko
where 0.77*Brutto>(select min(0.77*Brutto) from tabela3 join tabela2 on tabela2.Nazwisko=tabela3.Nazwisko
where Miasto='Gdañsk') 
 
select Nazwisko,0.77*Brutto as 'Netto',Brutto from tabela3 where Brutto=(select max(Brutto) from tabela3)

select Miasto, avg(Brutto) as 'Brutto', 
avg(Brutto*0.77) as 'Netto' from tabela3 join tabela2 on tabela2.Nazwisko=tabela3.Nazwisko
group by Miasto
--zad 26
create table tabela4(
imie varchar(30),
nazwisko varchar(30))

create table tabela5(
nazwisko varchar(30),
wzrost int)

create table tabela6(
miasto varchar(30),
nazwisko varchar(30),
netto float)

insert into tabela4 values
('Jan','Kowalski'),
('Tomasz','Nowicki'),
('Krzysztof','Malinowski'),
('Irena','Malicka')
insert into tabela5 values
('Kowalski',190),
('Malicka',195),
('Malinowski',185),
('Nowicki',188)
insert into tabela6 values
('Gdañsk','Kowalski',2500.90),
('Gdynia','Nowicki',4300.90),
('Gdañsk','Malinowski',2700.90),
('Gdynia','Malicka',3600.90)
select * from tabela4
select * from tabela5
select * from tabela6

alter table tabela4
add [data] date

update tabela4 set [data] ='1991-01-01' where nazwisko='Kowalski'
update tabela4 set [data] ='1994-01-10' where nazwisko='Nowicki'
update tabela4 set [data] ='1991-01-21' where nazwisko='Malinowski'
update tabela4 set [data] ='1986-09-21' where nazwisko='Malicka'
select * from tabela4

select avg(wzrost*0.01) as 'œredni wzrost' from tabela5

select year([data]) as 'rok urodzenia', datediff(year,[data],getdate()) as 'wiek', miasto,tabela4.nazwisko,wzrost from tabela4
join tabela5 on tabela4.nazwisko=tabela5.nazwisko join tabela6 on tabela5.nazwisko=tabela6.nazwisko
where wzrost>(select avg(wzrost) from tabela5)

select count(*) as 'iloœæ osób', miasto from tabela4 join tabela6 on tabela4.nazwisko=tabela6.nazwisko join tabela5 on tabela5.nazwisko = tabela4.nazwisko
where year([data])>1990 and wzrost>(select avg(wzrost) from tabela5 where miasto='Gdañsk') group by miasto