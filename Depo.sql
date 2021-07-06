create database DepoDB
use DepoDB
create table Depo
(
	Depo_ID int primary key identity(1,1),
	Siperfaqja varchar(50) not null,
	Kapaciteti int not null,
	Zip_kodi int not null,
	Qyteti varchar(50) not null,
	Rruga varchar(50) not null
) 
create table Personat 
( 
	Personat_ID int primary key identity (1,1),
	Nr_Personal int not null,
	Emri varchar(50) not null,
	Mbiemri varchar(50) not null,
	Gjinia char(1) not null
	check (Gjinia = 'M' or Gjinia ='F'),
	[Data e lindjes] date not null,
	check (datediff(year, [Data e lindjes], getDate()) >= 18),
	Depo int foreign key references Depo(Depo_ID)
) 
create table Klienti
(
	Klienti_ID int foreign key references Personat(Personat_ID)
	primary key(Klienti_ID),
	[Emri i Kompanis] varchar(50) not null,
)  
create table [Stafi i depos] 
(
	StafiIDepos_ID int foreign key references Personat(Personat_ID)
	primary key(StafiIDepos_ID),
	Kualifikimi varchar(50) not null,
	[Data e fillimit te punes] date not null,
	[Pervoja e punes] int null,
	Paga numeric (7,2) not null,
	Qyteti varchar(50) not null,
	Rruga varchar(50) not null,
	ZipKodi int not null,
)  alter table [Stafi i depos] add Menaxheri int foreign key references Menaxheret(Menaxheret_ID)
create table [Stafi i sigurimit]
(
	StafiISigurimit_ID int foreign key references [Stafi i depos](StafiIDepos_ID)
	primary key(StafiISigurimit_ID),
	[Forma e monotorimit] varchar(50) not null,
)
create table Mirembajtesit 
(
	Mirembajtesi_ID int foreign key references [Stafi i depos](StafiIDepos_ID)
	primary key(Mirembajtesi_ID), 
	[Koha e mirembajtjes] time not null,
	[Lloji i mjetit] varchar(50) not null
)
create table Menaxheret 
(
	Menaxheret_ID int foreign key references [Stafi i depos](StafiIDepos_ID)
	primary key (Menaxheret_ID),
	Pozita varchar(50) not null 

)
create table Zyretaret
(
	Zyretare_ID int foreign key references [Stafi i depos](StafiIDepos_ID)
	primary key (Zyretare_ID),
	Pozita varchar(50) not null
)
create table [Stafi i logjistikes] 
(
	StafiILogjistikes_ID int foreign key references [Stafi i depos](StafiIDepos_ID)
	primary key (StafiILogjistikes_ID),
	rrezikshmeria varchar(50) not null
) 

create table [Puntoret fizike]
(
	P_Fizike_ID int foreign key references [Stafi i logjistikes](StafiILogjistikes_ID)
    primary key(P_Fizike_ID)
)
create table Operatoret
(
	Operatoret_ID int foreign key references [Stafi i logjistikes](StafiILogjistikes_ID)
	primary key(Operatoret_ID),
	Pozita varchar(50) not null                  
)
create table [Puntoret e thjeshte]
(
	P_Thjeshte_ID int foreign key references [Puntoret fizike](P_Fizike_ID)
	primary key(P_Thjeshte_ID)
)
create table [Trajtuesit e materialit]
(
	Trajtuesit_ID int foreign key references [Puntoret fizike](P_Fizike_ID)
	primary key(Trajtuesit_ID)
)
create table Paketuesit
(
	Paketuesit_ID int foreign key references [Puntoret fizike](P_Fizike_ID)
	primary key(Paketuesit_ID)
)
create table Bashkepunuesit
(
	Bashkepunuesit_ID int foreign key references [Puntoret fizike](P_Fizike_ID)
	primary key(Bashkepunuesit_ID)
) 
create table Produktet
( 
	Produktet_ID int primary key identity(1,1),
	Depo int foreign key references Depo(Depo_ID),
	[Emri i kompanis prodhuese] varchar(50) not null,
	[Emri i produktit] varchar(50) not null,
	[Data e Prodhimit] date not null,
	Sasia int not null,
	check (Sasia > 0),
	Cmimi float not null,
	check (Cmimi > 0),
	Pershkrimi varchar(200) not null,
	[Data e pranimit] Date unique,
	check (datediff(year,[Data e pranimit],[Data e Prodhimit]) < 0)
) 
create table [Produkte higjenike]
(
	P_higjenike_ID int foreign key references Produktet(Produktet_ID)
	primary key (P_higjenike_ID),
	[Mosha e lejuar per perdorim] int,
	check ([Mosha e lejuar per perdorim] > 0 and [Mosha e lejuar per perdorim] < 10)
) 
create table [Produkte ushqimore]
(
	P_ushqimore_ID int foreign key references Produktet(Produktet_ID)
	primary key (P_ushqimore_ID),
 	[Data e skadences] date not null,
)
create table [Produkte teknike]
(
	P_teknike_ID int foreign key references Produktet(Produktet_ID)
	primary key (P_teknike_ID),
	Fortesia char(1) not null
	check (Fortesia = 'W' or Fortesia = 'S') 
)
create table [Produkte tekstili]
(
	P_tekstili_ID int foreign key references Produktet(Produktet_ID)
	primary key (P_tekstili_ID),
	Materiali varchar(50) not null
)
create table Inspektori
(
	Nr_Personal int primary key not null identity(987654321,1),
	Emri varchar(50) not null,
	Mbiemri varchar(50) not null,
	Gjinia char(1) not null
	check (Gjinia = 'M' or Gjinia = 'F'),
	Depo int foreign key references Depo(Depo_ID)
)	
create table Sektori
(
	 Depo_ID int foreign key references Depo(Depo_ID) 
	 on delete cascade,
	 Sektori_ID int primary key (Sektori_ID,Depo_ID),
	 [Tipi i sektorit] varchar(50) not null,
	 NrRafteve int not null,
	 check (NrRafteve > 0),
	 [Madhesia e raftit] char(1)
	 check ([Madhesia e raftit] = 'S' or[Madhesia e raftit] = 'M' or[Madhesia e raftit] = 'L') 
)
create table Makinat
(
	Makina_ID int primary key not null identity(1,1),
	[Tipi i makines] varchar(50) not null,
	M_Operatore int REFERENCES Operatoret(Operatoret_ID), 
    CONSTRAINT M_Operatore UNIQUE (M_Operatore)
)




 



