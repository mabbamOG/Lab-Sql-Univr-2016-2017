-- Esempio 14
SELECT DISTINCT P.nome, P.cognome
FROM InsErogato IE, Docenza D, Persona P, Insegn I
WHERE D.id_inserogato = IE.id AND
	D.id_persona = P.id AND
	IE.id_insegn = I.id AND
	I.nomeins ~ 'Lingua'
ORDER BY P.cognome ASC;


-- Esempio 15
SELECT C.nome, COUNT(DISTINCT D.id)
FROM InsErogato IE, Docenza D, Facolta F, CorsoStudi C
WHERE IE.id = D.id_inserogato AND IE.id_facolta = F.id AND IE.id_corsostudi = C.id
	AND IE.annoaccademico = '2006/2007'
	AND LOWER(F.nome) = 'economia'
GROUP BY C.id, C.nome;

-- Esempio 16
SELECT P.nome, P.cognome, COUNT(distinct IE.id), SUM(D.orelez)
FROM Docenza D, InsErogato IE, Persona P
WHERE D.id_inserogato = IE.id 
	AND D.id_persona = P.id 

	AND IE.annoaccademico = '2005/2006'
GROUP BY P.id, P.nome, P.cognome
HAVING COUNT(distinct IE.id)>1;

-- Esempio 17
SELECT DISTINCT I.nomeins, I.codiceins
FROM InsErogato IE, Facolta F, Insegn I
WHERE IE.id_facolta = F.id
	AND IE.id_insegn = I.id

	AND F.nome = 'Scienze matematiche fisiche e naturali'
	AND IE.annoaccademico = '2010/2011';

-- Esempio 18
SELECT DISTINCT I.nomeins, PL.abbreviazione AS semestre
FROM InsErogato IE, Insegn I, Lezione L LEFT OUTER JOIN PeriodoLez PL ON PL.id = L.id_periodolez
WHERE IE.id = L.id_inserogato
	AND IE.id_insegn = I.id

	AND IE.annoaccademico = '2006/2007'
	AND IE.id_corsostudi = 4;
