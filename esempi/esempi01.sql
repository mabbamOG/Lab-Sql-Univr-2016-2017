DROP TABLE  ingrediente CASCADE;
CREATE TABLE ingrediente
(
	id INT,
	nome TEXT NOT NULL,
	calorie NUMERIC CHECK (calorie>=0) NOT NULL,
	grassi NUMERIC CHECK (grassi>=0 AND grassi<=100) NOT NULL,
	proteine NUMERIC CHECK (proteine>=0 AND proteine<=100) NOT NULL,
	carboidrati NUMERIC CHECK (carboidrati>=0 AND carboidrati<=100) NOT NULL,
	PRIMARY KEY (id)
);

DROP TABLE  composizione CASCADE;
CREATE TABLE composizione
(
	ricetta INT,
	ingrediente INT,
	quantita NUMERIC CHECK (quantita>=0),
	PRIMARY KEY (ricetta,ingrediente),
	FOREIGN KEY (ricetta) REFERENCES ricetta,
	FOREIGN KEY (ingrediente) REFERENCES ingrediente
);

DROP TABLE  ricetta CASCADE;
CREATE TABLE ricetta
(
	id INT,
	nome TEXT NOT NULL,
	regione TEXT NOT NULL,
	porzioni INT NOT NULL CHECK (porzioni > 0),
	tempopreparazione INT NOT NULL CHECK (tempopreparazione > 0),
	PRIMARY KEY (id)
);
