-- TRIGGER
CREATE TABLE tbl_teste
(
    user_cpf INT NOT NULL PRIMARY KEY,
    user_nome VARCHAR(128) NOT NULL,
    user_email VARCHAR(128) NOT NULL
)
GO

CREATE TABLE Status_tbl
(
    Field1 VARCHAR(128) NOT NULL,
    Date_time DATETIME
)
GO

CREATE TRIGGER onInsertValue ON tbl_teste 
FOR INSERT AS
    IF (SELECT COUNT(*)
FROM INSERTED) = 1
    INSERT INTO Status_tbl
    (Field1, Date_time)
VALUES('Record inserted successfully', CURRENT_TIMESTAMP)

-- Inserindo um valor na tabela para teste
INSERT INTO tbl_teste
    (user_cpf, [user_nome], user_email)
VALUES
    (
        000999053021,
        'Pedro Santos',
        'pedro@dominio.net'
    )
GO

-- Consultando o ultimo registro na tabela auxiliar Status_tbl
SELECT TOP 1
    Status_tbl.Field1, Status_tbl.Date_time
FROM
    Status_tbl
ORDER BY 
    Status_tbl.Date_time DESC
