-- Esercizio 1
DROP DOMAIN IF EXISTS TGIORNO CASCADE;
CREATE DOMAIN TGIORNO AS CHAR(3) CHECK( VALUE IN( 'lun','mar','mer','gio','ven','sab','dom'));

DROP TABLE IF EXISTS museo CASCADE;
CREATE TABLE museo
(
	nome VARCHAR(30) NOT NULL DEFAULT 'MuseoVeronese',
	citta VARCHAR(20) NOT NULL DEFAULT 'Verona',
	indirizzo TEXT NOT NULL,
	numerotelefono TEXT,
	giornochiusura TGIORNO NOT NULL ,
	prezzo INT NOT NULL DEFAULT 10 CHECK (prezzo>=0),

	PRIMARY KEY (nome, citta)
);

DROP TABLE IF EXISTS mostra CASCADE;
CREATE TABLE mostra
(
	titolo VARCHAR(30) NOT NULL,
	inizio DATE NOT NULL,
	fine DATE NOT NULL,
	museo VARCHAR(30),
	citta VARCHAR(20),
	prezzo INT NOT NULL CHECK (prezzo>=0),
	CHECK (fine>=inizio),

	PRIMARY KEY (titolo, inizio),
	FOREIGN KEY (museo, citta) REFERENCES museo ON UPDATE SET DEFAULT ON DELETE SET DEFAULT
);

DROP TABLE IF EXISTS opera CASCADE;
CREATE TABLE opera
(
	nome VARCHAR(30) NOT NULL,
	cognomeautore VARCHAR(20) NOT NULL,
	nomeautore VARCHAR(20) NOT NULL,
	museo VARCHAR(30),
	citta VARCHAR(20),
	epoca INT NOT NULL CHECK (epoca>=0),
	anno INT NOT NULL CHECK (anno>=0),

	PRIMARY KEY (nome, cognomeautore, nomeautore),
	FOREIGN KEY (museo, citta) REFERENCES museo ON UPDATE CASCADE ON DELETE SET NULL
);

DROP TABLE IF EXISTS orario CASCADE;
CREATE TABLE orario
(
	progressivo INT NOT NULL,
	museo VARCHAR(30) NOT NULL,
	citta VARCHAR(20) NOT NULL,
	giorno TGIORNO NOT NULL,
	orarioapertura TIME WITH TIME ZONE DEFAULT '09:00 CET',
	orariochiusura TIME WITH TIME ZONE DEFAULT '19:00 CET',
	CHECK (orariochiusura>=orarioapertura),

	PRIMARY KEY (progressivo),
	FOREIGN KEY (museo, citta) REFERENCES museo ON UPDATE CASCADE ON DELETE CASCADE
);

-- Esercizio 2
INSERT INTO museo (nome, citta, indirizzo, numerotelefono, giornochiusura, prezzo) VALUES 
	('Arena', 'Verona', 'piazza Bra', '045 8003204', 'mar', 20), 
	('CastelVecchio', 'Verona', 'Corso Castelvecchio', '045 594734', 'lun', 15);

-- Esercizio 3
INSERT INTO opera VALUES 
	('Earnest', 'Wilde', 'Oscar', 'Arena', 'Verona', 1800, 1895),
	('Salome', 'Wilde', 'Oscar', 'Arena', 'Verona', 1800, 1891),
	('Manon', 'Massenet', 'Jules', 'CastelVecchio', 'Verona', 1800, 1884);
INSERT INTO mostra VALUES
	('Faces of Picasso', '2017-03-13', '2017-04-13','Arena','Verona',20),
	('Dantes Inferno', '2017-03-3', '2017-03-9','Arena','Verona',10),
	('Albaco', '2017-04-13', '2017-04-29','CastelVecchio','Verona',30);

-- Esercizio 4
INSERT INTO museo VALUES ('Padoan', 'Padova', 'Via del padoan 12', NULL, NULL, 8);
INSERT INTO museo VALUES ('Bergamasco', 'Bergamo', 'Viale del nord 1', 0457766442, 'mer', -18);

-- Esercizio 5
ALTER TABLE museo ADD COLUMN sitointernet TEXT DEFAULT '';
UPDATE museo SET sitointernet='www.arenaverona.it' WHERE nome='Arena' AND citta='Verona';
UPDATE museo SET sitointernet='www.castelvecchio.verona.gov.it' WHERE nome='CastelVecchio' AND citta='Verona';
UPDATE museo SET sitointernet='elpadoan.unipd.it' WHERE nome='Padoan' AND citta='Padoan';
UPDATE museo SET sitointernet='http://www.il-bergamasco.com' WHERE nome='Bergamasco' AND citta='Bergamo';

-- Esercizio 6
ALTER TABLE mostra RENAME COLUMN prezzo TO prezzointero;
ALTER TABLE mostra ADD COLUMN prezzoridotto INT DEFAULT 5;
ALTER TABLE mostra ADD CHECK (prezzoridotto<prezzointero);

-- Esercizio 7
UPDATE museo SET prezzo=prezzo+1;

-- Esercizio 8
UPDATE mostra SET prezzoridotto=prezzoridotto+1 WHERE prezzointero<15
