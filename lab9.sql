drop table if exists tabela1
drop table if exists tabela2
drop table if exists tabela3
drop procedure if exists proc1
drop procedure if exists proc2
drop procedure if exists proc3
create table tabela1(
nr int,
nazwisko varchar(20),
miasto varchar(20))

create table tabela2(
lp int,
nazwisko varchar(20),
data_ur date)

create table tabela3(
lp int,
nazwisko varchar(20),
wzrost decimal(10,2),
waga int)

insert into tabela1 values
(1,'Kowalski','Gdansk'),
(2,'Nowicki','Sopot'),
(3,'Malinowska','Sopot')
insert into tabela2 values
(1,'Malinowska','1980-01-01'),
(2,'Nowicki','1990-01-01'),
(3,'Kowalski','2000-01-01')
insert into tabela3 values
(1,'Malinowska',1.60,70),
(2,'Nowicki',1.93,95),
(3,'Kowalski',1.85,110)
select * from tabela1
select * from tabela2
select * from tabela3

go
create proc proc1 as
select tabela1.nazwisko,miasto,datediff(year,data_ur,getdate()) as 'wiek',wzrost,waga,BMI
=
case 
when waga/(wzrost*wzrost)>=25 then 'nadwaga'
when waga/(wzrost*wzrost)<18.5 then 'niedowaga'
else 'waga prawidlowa'
end
from tabela1 join tabela2 on tabela1.nazwisko=tabela2.nazwisko join tabela3 
on tabela2.nazwisko=tabela3.nazwisko
go
exec proc1

go
create proc proc2 as
select tabela1.nazwisko,miasto,wzrost,[ocena wzrostu]=
case 
when wzrost>1.85 then 'osoba wysoka'
when wzrost<1.70 then 'osoba niska'
else 'osoba sredniego wzrostu'
end
from tabela1 join tabela3 on tabela1.nazwisko=tabela3.nazwisko
go
exec proc2

alter table tabela1
add pensja_netto int;

update tabela1 set pensja_netto=3200 where nr=1
update tabela1 set pensja_netto=4500 where nr=2
update tabela1 set pensja_netto=8000 where nr=3
go
create proc proc3 as
select nazwisko,miasto,pensja_netto,ocena_zarobkow=
case 
when pensja_netto>=5000 then 'wysokie zarobki'
when pensja_netto<=3500 then 'niskie zarobki'
else 'srednie zarobki'
end
from tabela1
go
exec proc3
update tabela1 set pensja_netto=(
case
	when (pensja_netto>4000) then pensja_netto+pensja_netto*0.05
	else pensja_netto
	end)
select nazwisko,pensja_netto,podwyzka=
case 
when pensja_netto<=4000 then 'brak podwyzki'
else 'podwyzka przyznana'
end
from tabela1 