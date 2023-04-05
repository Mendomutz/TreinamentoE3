-- DML – Data Manipulation Language Statements: INSERT, UPDATE, DELETE, SELECT
-- DDL – Data Definition Language Statements: CREATE, ALTER, DROP
-- DCL – Data Control Language Statements:GRANT, DENY, REVOKE
--------------------------------------------------------------------------------------------------------------------------------------
-- DML – Linguagem de Manipulação de Dados
-- É empregada para realizar inclusões, consultas, exclusões e alterações de dados.
-- Utiliza os comandos INSERT, SELECT, UPDATE e DELETE.
--
-- Exemplo:
USE MyDB
SELECT
    categoryid,
    productname,
    productid,
    unitprice
FROM
    products
END

--------------------------------------------------------------------------------------------------------------------------------------
-- DDL – Linguagem de Definição de Dados
-- Permite ao desenvolvedor definir tabelas e elementos associados.
-- Seus comandos principais são CREATE, ALTER e DROP.
--
-- Exemplo:
USE MyDB CREATE TABLE customer(
    cust_id int,
    company varchar(40),
    contact varchar(30),
    phone char(12)
)
END

--------------------------------------------------------------------------------------------------------------------------------------
-- DCL – Linguagem de Controle de Dados
-- Controla os aspectos de autorização de dados e a liberação de usuários.
-- Os principais comandos são GRANT, DENY e REVOKE.
--
-- Exemplo:
USE MyDB GRANT
SELECT
    ON products TO public
END