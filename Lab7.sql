drop table if exists tabela1
drop table if exists tabela2
drop function if exists f1
drop function if exists f2
drop function if exists f3
drop function if exists f4
drop function if exists f5
drop function if exists f6
drop function if exists f7
drop function if exists f8
drop function if exists f9
create table tabela1(
nazwisko varchar(30) primary key,
wzrost int)

create table tabela2(
miasto varchar(30),
nazwisko varchar(30) primary key,
[pensja netto] float
)

insert into tabela1 values
('Kowalski',180),
('Malicka',185),
('Malinowski',165),
('Nowicki',178)
insert into tabela2 values
('Gdansk','Kowalski',2600.90),
('Gdynia','Malicka',4400.90),
('Gdansk','Malinowski',2800.90),
('Gdansk','Nowicki',3900.90)
go
create function f1()
returns int
begin
declare @ile int
set @ile=(select count(*) from tabela2 where [pensja netto]<3000)
return @ile
end
go

select dbo.f1() as 'ilosc osob z Gdanska o pensji netto<3000'

go 
create function f2()
returns float
begin
declare @ile float
set @ile=(select round(avg(wzrost*0.01),2) from tabela1 join tabela2 on
tabela1.nazwisko=tabela2.nazwisko where miasto='Gdansk')
return @ile
end
go

select dbo.f2() as 'sredni wzrost(w metrach) osob z Gdanska'

go 
create function f3()
returns varchar(30)
begin
declare @naz varchar(30)
set @naz=(select nazwisko from tabela2 where 
[pensja netto]=(select max([pensja netto]) from tabela2))
return @naz
end
go
select dbo.f3() as 'osoba zarabiajaca najwiecej'

go 
create function f4(@miasto varchar(30))
returns int
begin
declare @ile int
set @ile=(select count(*)from tabela2 where miasto=@miasto group by miasto)
return @ile
end
go
select dbo.f4('Gdynia') as 'ilosc osob w Gdyni'

go 
create function f5(@miasto varchar(30))
returns int
begin
declare @ile int
set @ile=(select count(*)from tabela2 group by miasto having miasto=@miasto)
return @ile
end
go
select dbo.f5('Gdynia') as 'ilosc osob w Gdyni'
go
create function f6()
returns table as
return (select nazwisko as 'Nazwisko',[pensja netto] as 'Netto',
round(1.23*[pensja netto],2) as 'Brutto' from tabela2 where 1.23*[pensja netto]
>(select min(1.23*[pensja netto]) from tabela2))
go
select*from dbo.f6()
go
create function f7()
returns table as
return (select miasto as 'Miasto',avg([pensja netto]) as 'Netto',
avg(round(1.23*[pensja netto],2)) as 'Brutto' from tabela2 group by miasto)
go
select*from dbo.f7()

update tabela2 set [pensja netto]=[pensja netto]*1.05 where miasto='Gdansk'

go
create function f8()
returns table as
return (select * from tabela2)
go
select*from dbo.f8()

go
create function f9()
returns table as
return (select tabela1.nazwisko as 'Nazwisko',miasto as 'Miasto',wzrost as 'Wzrost',[pensja netto] as 'Netto',1.23*[pensja netto] as 'Brutto'
from tabela1 join tabela2 on tabela1.nazwisko =tabela2.nazwisko)
go
select*from dbo.f9()
