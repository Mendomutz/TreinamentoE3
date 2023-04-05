' <Inserindo registro>
' SQL "INSERT INTO Tabela1 (Lote, Lote_Quality, Usuario, Usuario_Quality, E3TimeStamp)" "VALUES ('<%Lote%>', 192, '<%Usuario%>', 192, #<%DataInicial%>#)" ' WriteRecord
Sub CommandButton25_Click()
    Application.GetObject("Hist1").WriteRecord()
End Sub
' < / Inserindo registro > ' ------------------------------------------------------------------------------------------------------------------

' < Editando registro > ' SQL
"UPDATE (função utilizada) NOMEDATABELA (tabela utilizada)"
"SET NOMEDOCAMPO2 (campo da variável a ser modificada) = NOVOVALORDOCAMPO"
"WHERE NOMEDOCAMPO1 (campo da variável utilizada como filtro) = VALORDOCAMPO"

' SetVariableValue e EXECUTE Sub CommandButton26_Click()
SET
    Consultax = Screen.Item("E3Browser1").Item("Consulta2") Consultax.SetVariableValue "VarCampo",
    Screen.Item("Texto1").Value Consultax.SetVariableValue "VarCampo2",
    Screen.Item("Texto2").Value Consultax.Execute()
END Sub ' </Editando registro>

' ------------------------------------------------------------------------------------------------------------------
' <Deletando registro>
' SQL "DELETE FROM (função utilizada) NOMEDATABELA (tabela utilizada)" "WHERE NOMEDOCAMPO (campo da variável utilizada como filtro) = VALORDOCAMPO"