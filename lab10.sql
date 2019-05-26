drop table if exists tabelka1
drop table if exists tabelka2
drop type if exists typ1
drop procedure if exists proc1
drop procedure if exists proc2
create table tabelka1(
Lp int,
Nazwisko varchar(20),
[Data] date)
create table tabelka2(
Lp int,
Nazwisko varchar(20),
Miasto varchar(20))
insert into tabelka1 values
(1,'Kowalski','1998-09-01'),
(2,'Malinowska','1995-10-09'),
(3,'Nowak','1998-02-09'),
(4,'Kowalewski','1999-03-12'),
(5,'Jankowski','1999-09-01')
insert into tabelka2 values
(1,'Kowalski','Sopot'),
(2,'Nowak','Gdansk'),
(3,'Malinowska','Gdansk'),
(4,'Kowalewski','Gdynia'),
(3,'Jankowski','Sopot')
select * from tabelka1
select * from tabelka2

 declare @tab1 table(nazwisko varchar(20),
 rok_ur int,wiek int,miasto varchar(20))
 insert into @tab1 (nazwisko,rok_ur,wiek,miasto)
 select tabelka1.nazwisko, 
 year([Data]),  
 datediff(year,[Data],getdate()),miasto from tabelka1 join tabelka2
 on tabelka1.Nazwisko=tabelka2.Nazwisko
 select * from @tab1


go
create type typ1 as table(nazwisko varchar(20),
rok_ur int,wiek int,miasto varchar(20))
go
declare @tab2 typ1
insert into @tab2
 select tabelka1.nazwisko, 
 year([Data]),  
 datediff(year,[Data],getdate()),miasto from tabelka1 join tabelka2
 on tabelka1.Nazwisko=tabelka2.Nazwisko
select * from @tab2


declare @tab3 table(nazwisko varchar(20),
 miasto varchar(20),wiek int,[ocena wieku] varchar(20))
 insert into @tab3 (nazwisko,miasto,wiek,[ocena wieku])
 select tabelka1.nazwisko, 
 miasto,  
 datediff(year,[Data],getdate()),[ocena wieku]=
 case 
when datediff(year,[Data],getdate())>=60 then 'osoba starsza'
when datediff(year,[Data],getdate())<=30 then 'osoba mloda'
else 'osoba dojrzala'
end 
from tabelka1 join tabelka2
on tabelka1.Nazwisko=tabelka2.Nazwisko
select * from @tab3


declare @tab4 table(nazwisko varchar(20),
 miasto varchar(20),wiek int,opis varchar(20))
 insert into @tab4 (nazwisko,miasto,wiek,opis)
select tabelka1.nazwisko, miasto,  
 datediff(year,[Data],getdate()),opis='Mieszkaniec Gdanska'
 from tabelka1 join tabelka2
 on tabelka1.Nazwisko=tabelka2.Nazwisko
 where miasto='Gdansk'
 select * from @tab4
 go
 create proc proc1 as
 select count(*) as 'ilosc mieszkancow',
 Miasto from tabelka1 right join tabelka2 on tabelka1.Nazwisko=tabelka2.Nazwisko 
 where year([Data])>1998
 group by miasto
 go
 exec proc1

 go
 create proc proc2 as
 select count(*) as 'ilosc mieszkancow',
 Miasto from tabelka1 left join tabelka2 on tabelka1.Nazwisko=tabelka2.Nazwisko 
 group by miasto,[Data]
 having year([Data])>1998
 go
 exec proc2

 declare @tab5 table(nazwisko varchar(20),
 miasto varchar(20),wiek int,opis varchar(20))
 insert into @tab5 (nazwisko,miasto,wiek,opis)
select tabelka1.nazwisko, miasto,  
 datediff(year,[Data],getdate()),opis='osoba najmlodsza'
 from tabelka1 join tabelka2
 on tabelka1.Nazwisko=tabelka2.Nazwisko
 where  [Data]=(select max([Data]) from tabelka1)
 select * from @tab5


