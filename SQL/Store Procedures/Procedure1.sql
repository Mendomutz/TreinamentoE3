-- STORED PROCEDURE
-- São similares a funções pre compiladas que podem ser chamadas a qualquer momento

-- CRIA A STORED PROCEDURE
USE [Banco_teste]
GO
CREATE PROCEDURE cadastroCPF_SELECT
    @cpf INT
AS
BEGIN
    SELECT *
    FROM
        tbl_teste
    WHERE 
        tbl_teste.user_cpf = @cpf
END
GO

-- Cria a tabela caso ela não exista
USE [Banco_teste]
GO
IF OBJECT_ID('table_name', 'U') IS NULL
BEGIN
    CREATE TABLE tbl_teste
    (
        user_cpf INT NOT NULL PRIMARY KEY,
        user_nome VARCHAR(128) NOT NULL,
        user_email VARCHAR(128) NOT NULL
    )
END
ELSE
BEGIN
    PRINT 'Tabela ja existe'
END

BEGIN
    INSERT INTO tbl_teste
        (user_cpf, user_nome, user_email)
    VALUES(
            164158672,
            'Carlos',
            'Carlos@dominio.net'
    )
END

EXECUTE cadastroCPF_SELECT 998958889

SELECT *
FROM
    tbl_teste