BEGIN TRANSACTION;
DROP TABLE IF EXISTS "Estado";
CREATE TABLE IF NOT EXISTS "Estado" (
	"id"	varchar(5),
	"nome"	TEXT,
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "MesoRegiao";
CREATE TABLE IF NOT EXISTS "MesoRegiao" (
	"id"	INTEGER,
	"nome"	TEXT,
	"estado_id"	varchar(5),
	PRIMARY KEY("id"),
	FOREIGN KEY("estado_id") REFERENCES "Estado"("id")
);
DROP TABLE IF EXISTS "MicroRegiao";
CREATE TABLE IF NOT EXISTS "MicroRegiao" (
	"id"	INTEGER,
	"nome"	TEXT,
	"mesoregiao_id"	INTEGER,
	PRIMARY KEY("id"),
	FOREIGN KEY("mesoregiao_id") REFERENCES "MesoRegiao"("id")
);
DROP TABLE IF EXISTS "Municipio";
CREATE TABLE IF NOT EXISTS "Municipio" (
	"id"	INTEGER,
	"nome"	TEXT,
	"microregiao_id"	INTEGER,
	PRIMARY KEY("id"),
	FOREIGN KEY("microregiao_id") REFERENCES "MicroRegiao"("id")
);
DROP TABLE IF EXISTS "IFCampus";
CREATE TABLE IF NOT EXISTS "IFCampus" (
	"id"	INTEGER,
	"nome"	TEXT,
	"endereco"	TEXT,
	"longitude"	REAL,
	"latitude"	REAL,
	"municipio_id"	INTEGER,
	PRIMARY KEY("id"),
	FOREIGN KEY("municipio_id") REFERENCES "Municipio"("id")
);
DROP TABLE IF EXISTS "EscolaCampo";
CREATE TABLE IF NOT EXISTS "EscolaCampo" (
	"id"	INTEGER,
	"nome"	TEXT,
	"endereco"	TEXT,
	"longitude"	REAL,
	"latitude"	REAL,
	"municipio_id"	INTEGER,
	PRIMARY KEY("id"),
	FOREIGN KEY("municipio_id") REFERENCES "Municipio"("id")
);
DROP TABLE IF EXISTS "Assentamento";
CREATE TABLE IF NOT EXISTS "Assentamento" (
	"id"	char(9),
	"nome"	TEXT,
	"endereco"	TEXT,
	"longitude"	REAL,
	"latitude"	REAL,
	"municipio_id"	INTEGER,
	PRIMARY KEY("id"),
	FOREIGN KEY("municipio_id") REFERENCES "Municipio"("id")
);
INSERT INTO "Estado" ("id","nome") VALUES ('BR-CE','Ceará');
INSERT INTO "MesoRegiao" ("id","nome","estado_id") VALUES (20,'Norte Cearense','BR-CE');
INSERT INTO "MicroRegiao" ("id","nome","mesoregiao_id") VALUES (75,'Itapipoca',20),
 (76,'Baixo Curu',20),
 (77,'Uruburetama',20),
 (78,'Médio Curu',20),
 (79,'Canidé',20),
 (80,'Baturité',20),
 (81,'Chorozinho',20),
 (82,'Cascavel',20);
INSERT INTO "Municipio" ("id","nome","microregiao_id") VALUES (661,'Amontada',75),
 (662,'Itapipoca',75),
 (663,'Trairi',75),
 (664,'Paracuru',76),
 (665,'Paraipaba',76),
 (666,'São Gonçalo do Amarante',76),
 (667,'Itapajé',77),
 (668,'Tururu',77),
 (669,'Umirim',77),
 (670,'Uruburetama',77),
 (671,'Apuiarés',78),
 (672,'General Sampaio',78),
 (673,'Pentecoste',78),
 (674,'São Luís do Curu',78),
 (675,'Tejuçuoca',78),
 (676,'Canindé',79),
 (677,'Caridade',79),
 (678,'Itatira',79),
 (679,'Paramoti',79),
 (680,'Acarape',80),
 (681,'Aracoiaba',80),
 (682,'Aratuba',80),
 (683,'Baturité',80),
 (684,'Capistrano',80),
 (685,'Guaramiranga',80),
 (686,'Itapiúna',80),
 (687,'Mulungu',80),
 (688,'Pacoti',80),
 (689,'Palmácia',80),
 (690,'Redenção',80),
 (691,'Barreira',81),
 (692,'Chorozinho',81),
 (693,'Ocara',81),
 (694,'Beberibe',82),
 (695,'Cascavel',82),
 (696,'Pindoretama',82);
INSERT INTO "IFCampus" ("id","nome","endereco","longitude","latitude","municipio_id") VALUES (23236400,'Instituto Federal de Educação, Ciência e Tecnologia do Ceará | Campus Baturité','Av. Ouvidor Vitóriano Soares Barbosa, 160 - Sanharão, Baturité - CE, 62760-000',-38.86427,-4.343191,683),
 (23245107,'Instituto Federal de Educação, Ciência e Tecnologia do Ceará | Campus Umirim','R. Carlos Antônio Sáles, s/n - Floresta, Umirim - CE, 62660-000',-39.343877,-3.687474,669),
 (23259434,'Instituto Federal de Educação, Ciência e Tecnologia do Ceará | Campus Itapipoca','Av. da Universidade, 102 - Madalena, Itapipoca - CE, 62500-000',-39.569544,-3.488939,662),
 (23259477,'Instituto Federal de Educação, Ciência e Tecnologia do Ceará | Campus Avançado de Guaramiranga','Guaramiranga, CE, 62766-000',-38.931759,-4.266658,685),
 (23265345,'Instituto Federal de Educação, Ciência e Tecnologia do Ceará | Campus Paracuru','R. Dez - Paracuru, CE, 62680-000',-39.04188,-3.444679,664),
 (23564172,'Instituto Federal de Educação, Ciência e Tecnologia do Ceará | Campus Canindé','Rodovia BR 020, Km 303, s/n - Jubaia, Canindé - CE, 62700-000',-39.312751,-4.390667,676);
INSERT INTO "EscolaCampo" ("id","nome","endereco","longitude","latitude","municipio_id") VALUES (23252472,'EEM Educação do Campo Filho da Luta Patativa do Assaré','Assentamento Santana da Cal, sn Zona Rural, Canindé - CE, 62700-000',-39.456206,-4.376054,676),
 (23268310,'EEM Francisca Pinto dos Santos','C97J+26 - Arisco dos Marianos, Ocara - CE, 62755-000',-38.619605,-4.587065,693),
 (23545402,'EEM Maria Nazaré de Sousa','Rua.Assentamento Maceio, S/N - Baleia, CE, 62500-001',-39.522205,-3.12989,662);
COMMIT;
