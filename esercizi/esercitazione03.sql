/*
-- Esercizio 1
DROP VIEW IF EXISTS InsErogatoDocente;
CREATE TEMP VIEW InsErogatoDocente AS
(
    SELECT  IE.id_corsostudi, D.id_persona
    FROM InsErogato IE, Docenza D
    WHERE D.id_inserogato = IE.id
    
        AND IE.annoaccademico = '2010/2011'
);
SELECT DISTINCT P.id, P.nome, P.cognome
FROM InsErogatoDocente IED1, InsErogatoDocente IED2, Persona P
WHERE IED1.id_persona = P.id

    AND IED1.id_corsostudi <> IED2.id_corsostudi
    AND IED1.id_persona = IED2.id_persona
ORDER BY P.id;

-- Esercizio 2
SELECT DISTINCT P.nome, P.cognome, P.telefono
FROM InsErogato IE, Docenza D, Persona P
WHERE D.id_inserogato = IE.id
    AND D.id_persona = P.id

    AND IE.annoaccademico = '2009/2010'
    AND IE.id_corsostudi = 4
    AND P.id NOT IN
    (
        SELECT D.id_persona
        FROM Insegn I, Docenza D, InsErogato IE
        WHERE D.id_inserogato = IE.id
            AND IE.id_insegn = I.id
        
            AND I.nomeins ~ 'Programmazione'
            AND IE.id_corsostudi = 4
    )
ORDER BY P.cognome;

-- Esercizio 3
SELECT distinct P.id, P.nome, P.cognome
FROM InsErogato IE, Docenza D, Persona P
WHERE D.id_inserogato = IE.id
    AND D.id_persona = P.id
    
    AND IE.annoaccademico = '2010/2011'
    AND NOT EXISTS
    (
        SELECT 1
        FROM InsErogato IE2, Docenza D2
        WHERE D2.id_inserogato = IE2.id

            AND IE2.annoaccademico = '2009/2010'
            AND IE2.id_insegn = IE.id_insegn
            AND D2.id_persona = P.id
    )
ORDER BY P.nome, P.cognome;

-- Esercizio 4
SELECT PL.abbreviazione, PD.discriminante, PD.inizio, PD.fine, COUNT(*)
FROM InsErogato IE, InsInPeriodo IP, PeriodoDid PD, PeriodoLez PL
WHERE IP.id_inserogato = IE.id
    AND IP.id_periodolez = PD.id
    AND PD.id = PL.id

    AND PD.annoaccademico = '2010/2011'
    AND PD.descrizione IN ('I semestre','Primo semestre')
GROUP BY PD.id, PL.id, PL.abbreviazione, PD.discriminante, PD.inizio, PD.fine;

-- Esercizio 5
SELECT F.nome, COUNT(*), SUM(IE.crediti)
FROM InsErogato IE, Facolta F
WHERE IE.id_facolta = F.id

    AND IE.modulo < 0
    AND IE.annoaccademico = '2010/2011'
GROUP BY F.id, F.nome;

-- Esercizio 6
--- vedere esercitazione02.sql

-- Esercizio 7
SELECT distinct IE.id_insegn
FROM InsErogato IE
WHERE IE.id_corsostudi = 4
    AND IE.id_insegn NOT IN
    (
        SELECT IE.id_insegn
        FROM InsInPeriodo IP, PeriodoLez PL, InsErogato IE
        WHERE IP.id_periodolez = PL.id
            AND IP.id_inserogato = IE.id
            
            AND IE.id_corsostudi = 4
            AND (PL.abbreviazione ILIKE '2%' OR PL.abbreviazione ILIKE '%2%Q%')
    );

-- Esercizio 8
DROP VIEW IF EXISTS ORELEZ;
CREATE TEMP VIEW ORELEZ AS
(
    SELECT IE.id_facolta as facolta, D.id_persona as persona, SUM(D.orelez) AS nore
    FROM Docenza D, InsErogato IE
    WHERE D.id_inserogato = IE.id
    GROUP BY IE.id_facolta, D.id_persona
);
SELECT *
FROM ORELEZ
WHERE (facolta, nore) IN
(
    SELECT facolta, MAX(nore)
    FROM ORELEZ
    GROUP BY facolta
);
*/

-- Esercizio 9
DROP VIEW IF EXISTS TempView;
CREATE TEMP VIEW TempView AS
(
    SELECT IE.id_insegn, IE.id, IE.id_discriminante, IE.annoaccademico
    FROM InsErogato IE
    WHERE IE.id_corsostudi = 240
        AND IE.annoaccademico IN ('2009/2010','2010/2011')
        AND IE.modulo = 0
);
SELECT DISTINCT I.nomeins, DD.descrizione
FROM TempView TV1, TempView TV2, Discriminante DD, Insegn I
WHERE TV1.id_insegn = TV2.id_insegn
    AND DD.id = TV1.id_discriminante
    AND TV1.id_insegn = I.id
    AND TV1.annoaccademico <> TV2.annoaccademico

    AND TV1.id_insegn NOT IN
    (
        SELECT TV.id_insegn
        FROM TempView TV, Docenza D, Persona P
        WHERE TV.id = D.id_inserogato
            AND D.id_persona = P.id

            AND P.nome IN ('Roberto','Alberto','Massimo','Luca')
    )
ORDER BY I.nomeins
