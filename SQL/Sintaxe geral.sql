-- Exemplo de comando utilizado para a criação e inserção de dados nas tabelas
-- Tabela Store_Information

CREATE TABLE Store_Information
(
    Store_Name varchar(20) NOT NULL,
    Sales int NOT NULL,
    Date_Time date NOT NULL
)
INSERT
    Store_Information
VALUES
    ('Los Angeles', 1500, '05-Jan-1999'),
    ('San Diego', 250, '07-Jan-1999'),
    ('Los Angeles', 300, '08-Jan-1999'),
    ('Bostom', 700, '08-Jan-1999')
GO

-- Tabela Internet_Sales
CREATE TABLE Internet_Sales
(
    Date_Time date NOT NULL,
    Sales int NOT NULL
)
INSERT
    Internet_Sales
VALUES
    ('07-Jan-1999', 250),
    ('10-Jan-1999', 535),
    ('11-Jan-1999', 320),
    ('12-Jan-1999', 750)
GO

--------------------------------------------------------------------------------------------------------------------------------------
-- KEYWORDS
-- WHERE
SELECT
    Store_Name
FROM
    Store_Information
WHERE
    Sales > 1000

-- HAVING
SELECT
    Store_name,
    SUM(sales)
FROM
    Store_Information
GROUP BY
    Store_Name
HAVING
    SUM(Sales) > 1500

-- DISTINCT
SELECT
    DISTINCT store_name
FROM
    Store_Information

-- FUNCTION
SELECT
    SUM(Sales)
FROM
    Store_Information

-- JOIN
-- Utilizado para unir duas tabelas e comparar valores
-- SELECT * FROM Tabela1
-- JOIN Tabela2
-- ON Tabela1.Campo = Tabela2.Campo
-- UNION
-- Utilizado para combinar o resultado de duas consultas
-- As colunas correspondente devem possuir o mesmo tipo de dado

    SELECT
        Date_time
    FROM
        Store_Information
UNION
    SELECT
        Date_time
    FROM
        Internet_Sales

-- UNION ALL
-- Semelhante ao UNION, porem ao invez de selecionar somente os valores diferentes
-- UNION ALL seleciona todos os valores
    SELECT
        Date_time
    FROM
        Store_Information
UNION
ALL
    SELECT
        Date_time
    FROM
        Internet_Sales

--------------------------------------------------------------------------------------------------------------------------------------
-- VIEW
-- CREATE VIEW vmVas AS
-- SELECT * FROM Vas V
-- JOIN Clientes C ON V.Cliente_id = C.id_Cliente
-- JOIN Produtos P ON V.Produto_id = P.id_Produto
-- Para acessar a view
-- SELECT * FROM vmVas
