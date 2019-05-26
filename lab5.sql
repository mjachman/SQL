drop table if exists  tabela1
drop table if exists  tabela2
drop view if exists widok1
drop view if exists widok2
drop view if exists widok3
drop table if exists #tab1
drop table if exists #tab2
--zad 18
create table tabela1(
Lp int primary key identity,
Nazwisko varchar(30),
[Data] date)
create table tabela2(
Lp int primary key identity,
Nazwisko varchar(30),
Miasto varchar(30))
insert into tabela1 values
('Kowalski','1998-09-01'),
('Malinowska','1991-10-09'),
('Nowak','1993-02-09'),
('Kowalewski','1992-03-12'),
('Jankowski','1999-09-01')
insert into tabela2 values
('Kowalski','Sopot'),
('Nowak','Gda?sk'),
('Malinowska','Gda?sk'),
('Kowalewski','Gdynia'),
('Jankowski','Sopot')
select * from tabela1
select * from tabela2
--zad 19
select tabela1.Nazwisko, year([Data]) as 'Rok urodzenia',
DATEDIFF(year,[Data],getdate()) as 'Wiek', Miasto
from tabela1 join tabela2 on tabela1.Nazwisko=tabela2.Nazwisko
--zad 20 
go
create view widok1 as
select tabela1.Nazwisko, year([Data]) as 'Rok urodzenia', 
DATEDIFF(year,[Data],getdate()) as 'Wiek', Miasto
from tabela1 join tabela2 on tabela1.Nazwisko=tabela2.Nazwisko
go
select * from widok1
--zad 21
select * into #tab1 from tabela1
select * into #tab2 from tabela2
select * from #tab1
select * from #tab2
go 
create view widok2 as
select tabela1.Nazwisko, 
DATEDIFF(year,[Data],getdate()) as 'Wiek', Miasto
from tabela1 join tabela2 on tabela1.Nazwisko=tabela2.Nazwisko
go
select * from widok2
select Nazwisko as 'Nazwisko osoby najm?odszej'
from widok2 where Wiek=(select min(Wiek) from widok2)
go
--zad 22
create view widok3 as
select COUNT(*) as 'ilo?? mieszka?ców',Miasto from tabela2 group by Miasto
go
select * from widok3
--zad 23
select COUNT(*) as 'ilo?? mieszka?ców',Miasto from tabela2  left join 
tabela1 on tabela1.Nazwisko=tabela2.Nazwisko where year([Data])>1998 
group by Miasto
--zad 24
select COUNT(*) as 'ilo?? mieszka?ców',Miasto from (tabela1 left join 
tabela2 on tabela2.Nazwisko=tabela1.Nazwisko) 
group by Miasto,[Data] 
having YEAR([Data])>1998