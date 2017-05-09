-- Esercizio 1
--- un solo insert, 1 sola aggiornera' le altre si bloccheranno e andranno in fail
insert

-- Esercizio 2
--- TR1
BEGIN TR1;
    SELECT prezzo
    FROM museo
    WHERE nome = 'Verona'
        AND prezzo::NUMERIC(2,2) <> 0;
        -- AND prezzo <> ceil(prezzo) ??? boh
    UPDATE museo
    SET prezzo=prezzo*0.10
    -- SET prezzo = round(prezzo*(1.10),2)
    WHERE prezzo<>ceil(prezzo) -- ???
        AND citta='Verona';
END;
BEGIN TR2;
    SELECT ...
    ...
END;
-- se tr2 avviene dopo la select di tr1 non e' garantito ilfunzionamento.
-- allora devo metter tr1con livello: "repeatable read"
-- BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ
