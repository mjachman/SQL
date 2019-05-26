IF(OBJECT_ID('FK_zwierze_gatunek') IS NOT NULL)
BEGIN
	ALTER TABLE [dbo].[zwierzeta]
	DROP CONSTRAINT FK_zwierze_gatunek
END

IF(OBJECT_ID('FK_zwierze_wybieg') IS NOT NULL)
BEGIN
	ALTER TABLE [dbo].[zwierzeta]
	DROP CONSTRAINT FK_zwierze_wybieg
END

IF(OBJECT_ID('FK_wybieg') IS NOT NULL)
BEGIN
	ALTER TABLE [dbo].[opiekunowie_wybiegi]
	DROP CONSTRAINT FK_wybieg
END

IF(OBJECT_ID('FK_opiekun') IS NOT NULL)
BEGIN
	ALTER TABLE [dbo].[opiekunowie_wybiegi]
	DROP CONSTRAINT FK_opiekun
END

IF(OBJECT_ID('FK_karmienie_pokarm') IS NOT NULL)
BEGIN
	ALTER TABLE [dbo].[karmienia]
	DROP CONSTRAINT FK_karmienie_pokarm
END

IF(OBJECT_ID('FK_karmienie_zwierze') IS NOT NULL)
BEGIN
	ALTER TABLE [dbo].[karmienia]
	DROP CONSTRAINT FK_karmienie_zwierze
END

IF(OBJECT_ID('FK_karmienie_opiekun') IS NOT NULL)
BEGIN
	ALTER TABLE [dbo].[karmienia]
	DROP CONSTRAINT FK_karmienie_opiekun
END

IF(OBJECT_ID('FK_gromada') IS NOT NULL)
BEGIN
	ALTER TABLE [dbo].[gatunki]
	DROP CONSTRAINT FK_gromada
END
IF(OBJECT_ID('FK_sektor') IS NOT NULL)
BEGIN
	ALTER TABLE [dbo].[wybiegi]
	DROP CONSTRAINT FK_sektor
END
IF(OBJECT_ID('FK_kierownik') IS NOT NULL)
BEGIN
	ALTER TABLE [dbo].[sektory]
	DROP CONSTRAINT FK_kierownik
END
IF(OBJECT_ID('FK_badanie_zwierze') IS NOT NULL)
BEGIN
	ALTER TABLE [dbo].[badania]
	DROP CONSTRAINT FK_badanie_zwierze
END
drop table if exists kierownicy
drop table if exists gatunki
drop table if exists gromady
drop table if exists zwierzeta
drop table if exists wybiegi
drop table if exists opiekunowie
drop table if exists opiekunowie_wybiegi
drop table if exists pokarmy
drop table if exists karmienia
drop table if exists sektory
drop table if exists badania

create table kierownicy(
id_kierownik int primary key identity,
imie varchar(30),
nazwisko varchar(30)
)
create table opiekunowie(
id_opiekun int primary key identity,
imie varchar(30),
nazwisko varchar(30)
)
create table sektory
(id_sektor int primary key identity,
id_kierownik int,
nazwa varchar(30)
)
create table wybiegi
(
id_wybieg int primary key identity,
id_sektor int,
nazwa varchar(30)
)
create table opiekunowie_wybiegi(
id_opiekun int,
id_wybieg int
)
create table gromady
(id_gromada int primary key identity,
nazwa varchar(30)
)
create table gatunki
(id_gatunek int primary key identity,
id_gromada int,
nazwa varchar(30)
)
create table zwierzeta
(id_zwierze int primary key identity,
imie varchar(30),
plec bit,
id_gatunek int,
id_wybieg int
)
create table pokarmy(
id_pokarm int primary key identity,
nazwa varchar(30)
)
create table karmienia
(id_karmienie int primary key identity,
id_pokarm int,
id_zwierze int,
id_opiekun int,
porcja int,
data date)

create table badania
(id_badanie int primary key identity,
id_zwierze int,
[data] date,
wynik varchar(100)
)

alter table zwierzeta
add constraint FK_zwierze_gatunek foreign key (id_gatunek)
references gatunki(id_gatunek)

alter table zwierzeta
add constraint FK_zwierze_wybieg foreign key (id_wybieg)
references wybiegi(id_wybieg)

alter table opiekunowie_wybiegi
add constraint FK_wybieg foreign key (id_wybieg)
references wybiegi(id_wybieg)

alter table opiekunowie_wybiegi
add constraint FK_opiekun foreign key (id_opiekun)
references opiekunowie(id_opiekun)

alter table karmienia
add constraint FK_karmienie_zwierze foreign key (id_zwierze)
references zwierzeta(id_zwierze)

alter table karmienia
add constraint FK_karmienie_opiekun foreign key (id_opiekun)
references opiekunowie(id_opiekun)

alter table karmienia
add constraint FK_karmienie_pokarm foreign key (id_pokarm)
references pokarmy(id_pokarm)

alter table gatunki
add constraint FK_gromada foreign key (id_gromada)
references gromady(id_gromada)

alter table wybiegi
add constraint FK_sektor foreign key (id_sektor)
references sektory(id_sektor)

alter table sektory
add constraint FK_kierownik foreign key (id_kierownik)
references kierownicy(id_kierownik)

alter table badania
add constraint FK_badanie_zwierze foreign key (id_zwierze)
references zwierzeta(id_zwierze)