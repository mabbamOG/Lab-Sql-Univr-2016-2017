-- Esercizio 1
SELECT COUNT(id)
FROM CorsoStudi;

-- Esercizio 2
SELECT nome, codice, indirizzo, id_preside_persona
FROM Facolta;

-- Esercizio 3
SELECT DISTINCT C.nome, F.nome
FROM InsErogato IE, CorsoStudi C, CorsoInFacolta CF, Facolta F
WHERE IE.id_corsostudi = C.id
	AND CF.id_corsostudi = C.id
	AND CF.id_facolta = F.id

	AND IE.annoaccademico = '2010/2011'
ORDER BY C.nome;

--Esercizio 4
SELECT C.nome, C.codice, C.abbreviazione
FROM Facolta F, CorsoInFacolta CF, CorsoStudi C
WHERE CF.id_facolta = F.id
	AND CF.id_corsostudi = C.id

	AND LOWER(F.nome) = 'medicina e chirurgia';

-- Esercizio 5
SELECT nome, codice, abbreviazione
FROM CorsoStudi
WHERE nome ILIKE '%lingue%';
--WHERE nome ~* 'lingue'

-- Esercizio 6
SELECT DISTINCT sede
FROM corsostudi;

-- Esercizio 7
SELECT I.nomeins, DD.descrizione, IE.nomemodulo, IE.modulo
FROM InsErogato IE, Facolta F, Insegn I, Discriminante DD
WHERE IE.id_facolta = F.id
	AND IE.id_insegn = I.id
	AND IE.id_discriminante = DD.id

	AND IE.annoaccademico = '2010/2011'
	AND LOWER(F.nome) = 'economia'
	AND IE.modulo > 0;

-- Esercizio 8
SELECT I.nomeins, DD.descrizione
FROM InsErogato IE, Insegn I, Discriminante DD
WHERE IE.id_insegn = I.id
	AND IE.id_discriminante = DD.id

	AND IE.annoaccademico = '2009/2010'
	AND IE.modulo = '0'
	AND IE.crediti IN (3,5,12)
ORDER BY DD.descrizione;

-- Esercizio 9
SELECT IE.id, I.nomeins, DD.descrizione
FROM InsErogato IE, Insegn I, Discriminante DD
WHERE IE.id_insegn = I.id
	AND IE.id_discriminante = DD.id

	AND IE.annoaccademico = '2008/2009'
	AND IE.modulo = '0'
	AND IE.crediti > 9
ORDER BY I.nomeins DESC;

-- Esercizio 10
SELECT I.nomeins, DD.descrizione, IE.crediti, IE.annierogazione
FROM InsErogato IE, CorsoStudi C, Insegn I, Discriminante DD
WHERE IE.id_corsostudi = C.id
	AND IE.id_insegn = I.id
	AND IE.id_discriminante = DD.id

	AND IE.modulo = '0'
	AND IE.annoaccademico = '2010/2011'
	AND LOWER(C.nome) = 'laurea in informatica'
ORDER BY I.nomeins;

-- Esercizio 11
SELECT MAX(crediti) FROM InsErogato WHERE annoaccademico = '2010/2011';

-- Esercizio 12
SELECT annoaccademico, MIN(crediti), MAX(crediti)
FROM InsErogato
GROUP BY annoaccademico
ORDER BY annoaccademico;

-- Esercizio 13
SELECT C.nome, IE.annoaccademico, MAX(IE.crediti), MIN(IE.crediti), SUM(IE.crediti)
FROM InsErogato IE, CorsoStudi C
WHERE IE.id_corsostudi = C.id

	AND IE.modulo = '0'
GROUP BY IE.annoaccademico, IE.id_corsostudi, C.nome;

-- Esercizio 14
SELECT C.nome, COUNT(IE.id_insegn)
FROM InsErogato IE, Corsostudi C, Facolta F
WHERE IE.id_facolta = F.id
	AND IE.id_corsostudi = C.id

	AND LOWER(F.nome) = 'scienze matematiche fisiche e naturali'
	AND IE.annoaccademico = '2009/2010'
	AND IE.modulo = '0'
GROUP BY IE.id_corsostudi, C.nome
ORDER BY C.nome;

-- Esercizio 15
SELECT DISTINCT C.nome, C.durataanni
FROM InsErogato IE, Corsostudi C
WHERE IE.id_corsostudi = C.id

	AND IE.annoaccademico = '2010/2011'
	AND 
	(
		(IE.modulo=0 AND IE.crediti IN (4,6,8,10,12))
		OR
		(IE.modulo<0 AND IE.nomeunita~*'laboratorio' AND IE.crediti>=10 AND IE.crediti <15)
		OR
		(IE.modulo>0 AND IE.nomemodulo~*'laboratorio' AND IE.crediti>=10 AND IE.crediti <15)
	);

-- Esercizio 16
SELECT C.nome, COUNT(DISTINCT IE.id_insegn)
FROM InsErogato IE, Corsostudi C
WHERE IE.id_corsostudi = C.id

	AND IE.hamoduli = '1'
	AND IE.annoaccademico = '2010/2011'
	AND IE.id_corsostudi NOT IN
	(
		SELECT CF.id_corsostudi
		FROM CorsoInFacolta CF, Facolta F
		WHERE CF.id_facolta = F.id
			
			AND LOWER(F.nome) = 'medicina e chirurgia'
	)
GROUP BY C.id, C.nome
ORDER BY C.nome;
