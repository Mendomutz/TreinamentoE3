' FOR NEXT
Sub CommandButton8_Click()
	set tag = Application.GetObject("Dados.TagInterno1")

	for var = 1 to 5000
		 tag.value = tag.value + 1
	next

	Application.GetObject("Dados.TagInterno1").Value = tag.value
End Sub

' ------------------------------------------------------------------------------------------------------------------

' IF ELSEIF ELSE
Sub Figura1_Click()
	set texto = Screen.Item("textoNomeMotor")

	var = Application.SelectMenu("LIGADO|DESLIGADO|MANUTENÇÃO|DEFEITO")
	
	if var = 1 then
		texto.value = "LIGADO"
		OverrideFillColor = vbBlue
	elseif var = 2 then
		texto.value = "DESLIGADO"
		OverrideFillColor = vbBlack
	elseif var = 3 then
		texto.value = "MANUTENÇÃO"
		OverrideFillColor = vbYellow
	else
		texto.value = "DEFEITO"
		OverrideFillColor = vbRed
	end if

End Sub

' ------------------------------------------------------------------------------------------------------------------

' SELECT CASE
Sub Figura1_Click()
	set texto = Screen.Item("textoNomeMotor")
	var = Application.SelectMenu("LIGADO|DESLIGADO|MANUTENÇÃO|DEFEITO")
	
	select case var
		case 1
			texto.value = "LIGADO"
			OverrideFillColor = vbBlue
		case 2
			texto.value = "DESLIGADO"
			OverrideFillColor = vbBlack
		case 3
			texto.value = "MANUTENÇÃO"
			OverrideFillColor = vbYellow
		case 4
			texto.value = "DEFEITO"
			OverrideFillColor = vbRed
	end select

End Sub

' ------------------------------------------------------------------------------------------------------------------

' CONCATENAÇÃO
Sub Texto4_Validate(Cancel, NewValue)

	if MsgBox("Aceitar " & NewValue & " como o novo valor?", vbQuestion + vbYesNo) = vbNo then
		Cancel = true
	end if

End Sub

' ------------------------------------------------------------------------------------------------------------------

' TYPENAME
Sub CommandButton12_Click()

	for each var in Screen	

		if TypeName(var) = ("DrawString") then
			MsgBox var.value
		end if

	next

End Sub

' ------------------------------------------------------------------------------------------------------------------

' WHILE
Sub CommandButton13_Click()
	var = 7

	While var < 10
		var = var + 1
	Wend

End Sub

' ------------------------------------------------------------------------------------------------------------------

' COMBOBOX / LISTBOX
Sub ComboBox1_OnStartRunning()
	Clear()

	AddItem "LIGADO"
	AddItem "DESLIGADO"
	AddItem "MANUTENÇÃO"
	AddItem "DEFEITO"
End Sub

' ------------------------------------------------------------------------------------------------------------------

' VETORES / ARRAYS
Sub CommandButton14_Click()
	dim a(3)
	
	a(0) = "teste"
	a(1) = 10
	a(2) = 123
	a(3) = 789
	
	for var = LBound(a) to UBound(a)
		MsgBox a(var)
	next

	dim b(2)

	b(0) = Array("Coluna 0", "Coluna 1", "Coluna 2")
	b(1) = Array(501, 502, 503)
	b(2) = Array("Valor 1", 1, 4)

	For index1 = LBound(b) To UBound(b)

		For index2 = LBound(b(index1)) To UBound(b(index1))
			MsgBox b(index1)(index2)
		Next

	Next

End Sub

' ------------------------------------------------------------------------------------------------------------------

' CREATELINK IN STUDIOTIME
Sub CommandButton17_Click()
	Screen.Item("Retangulo1").Links.CreateLink "VerticalPercentFill", "Viewer.Nivel1", 0
End Sub

' ------------------------------------------------------------------------------------------------------------------

' ADDOBJECT / CREATELINK IN RUNTIME
Sub CommandButton16_Click()
	nome = InputBox("Digite o nome do retangulo")

	set a = Screen.AddObject("DrawRect", True, nome)

	a.Width = 5000
	a.Height = a.Width/2
	a.X = Application.Item("TagInterno1").Value
	a.Y = 10000
	a.ForegroundColor = vbGreen ' RGB(0, 255, 0)

	a.Links.CreateLink "VerticalPercentFill", "Viewer.Nivel1", 0

	Application.Item("TagInterno1").Value = Application.Item("TagInterno1").Value + 5000
End Sub

' ------------------------------------------------------------------------------------------------------------------

' ERROR HANDLING
Sub CommandButton18_Click()
	nome = InputBox("Digite o nome do retangulo")

	On Error Resume Next
	Set b = Screen.Item(nome)

	If Err.Number <> 0 Then
		set a = Screen.AddObject("DrawRect", True, nome)

		a.Width = 5000
		a.Height = a.Width/2
		a.X = Application.Item("TagInterno1").Value
		a.Y = 10000
		a.ForegroundColor = vbGreen ' RGB(0, 255, 0)

		a.Links.CreateLink "VerticalPercentFill", "Viewer.Nivel1", 0

		Application.Item("TagInterno1").Value = Application.Item("TagInterno1").Value + 5000
	Else
		MsgBox "Objeto ja existe, utilize outro nome"
	End If

End Sub

' ------------------------------------------------------------------------------------------------------------------

' SOMA
Sub CommandButton19_Click()
	var = soma(10, 20)
	MsgBox var
	CommandButton19_Evento1()
End Sub

Function soma(a, b)
	soma = a + b
End Function

' Criado um evento vazio pois nao tem como retirar o End Sub final
Sub vazio()
End Sub

Sub CommandButton19_Evento1()
	BackColor = vbGreen
	Width = 5600
	X = 26396.6
End Sub

' ------------------------------------------------------------------------------------------------------------------

' <GETADORECORDS()>
' BOF
If RS.BOF = True Then
	valorAnterior = "Nenhum registro"
Else
	valorAnterior = RS.Fields("Campo2").Value
End If

' EOF
If RS.EOF = True Then
	proximoValor = "Nenhum registro"
Else
	proximoValor = RS.Fields("Campo2").Value
End If

' RecordCount
Sub CommandButton20_Click()
	Set RS = Screen.Item("E3Browser1").Item("Consulta1").GetADORecordeSet()
	MsgBox rs.RecordCount	
End Sub

' MoveFirst
Sub CommandButton21_Click()
	Set RS = Screen.Item("E3Browser1").Item("Consulta1").GetADORecordeSet()

	If RS.RecordCount <> 0 Then
		RS.MoveFirst
		primeiroValor = RS.Fields("Campo2").Value
		MsgBox primeiroValor
	Else
		MsgBox "Nenhum Registro"
	End If

End Sub

' MoveLast
Sub CommandButton22_Click()
	Set	RS = Screen.Item("E3Browser1").Item("Consulta1").GetADORecordeSet()
	
	If RS.RecordCount <> 0 Then
		RS.MoveLast
		ultimoValor = RS.Fields("Campo2").Value
		MsgBox ultimoValor
	Else
		MsgBox "Nenhum Registro"
	End If

End Sub

' MoveNext
Sub CommandButton23_Click()
	Set RS = Screen.Item("E3Browser1").Item("Consulta1").GetADORecordeSet()
	
	If RS.RecordCount <> 0 Then
		RS.MoveNext
		
		If RS.EOF = True Then
			proximoValor = "Nenhum Registro"
		Else
			proximoValor = RS.Fields("Campo2").Value
		End If

		MsgBox proximoValor
	Else
		MsgBox "Nenhum Registro"
	End If

End Sub

' MovePrevious
Sub CommandButton24_Click()
	Set RS = Screen.Item("E3Browser1").Item("Consulta1").GetADORecordeSet()

	If RS.RecordCount <> 0 Then
        RS.MovePrevious

        If RS.EOF = True Then
            valorAnterior = "Nenhum Registro"
        Else
            valorAnterior = RS.Fields("Campo2").Value
        End If

        MsgBox valorAnterior
    Else
        MsgBox "Nenhum Registro"
    End If
		
End Sub
' </GETADORECORDS()>

' ------------------------------------------------------------------------------------------------------------------

' <GETASYNCADORECORDSET>
Sub CommandButton25_Click()
	Set consulta = Screen.Item("E3Browser1").Item("Consulta1")
	consulta.GetAsyncADORecordset()
End Sub

' Registros retornados no evento OnAsyncQueryFinish
Sub Consulta1_OnAsyncQueryFinish(RecordSet, Error)
	
	If Error <> True Then
		RS.MoveFirst

		For i = 1 to RS.RecordCount
			a1 = RS.Fields("Campo").Value
			a2 = RS.Fields("Campo2").Value
			strValuess = strValues & a1 & " " & a2 & Chr(13)
			RS.MoveNext()
		Next
		MsgBox strValues

	End If

End Sub
' </GETASYNCADORECORDSET>


' ------------------------------------------------------------------------------------------------------------------

' Modificando driver em tempo de execução
' Criar um vetor com as configurações mais comuns
Dim Arr(6)
' Configurando os elementos do array
Arr(1) = "IO.Type"
Arr(2) = "Serial"
Arr(3) = "IO.Serial.Port"
Arr(4) = 1
Arr(5) = "IO.Serial.BaudRate"
Arr(6) = 19200

' Fazendo de outra maneira
Dim Arr2(3)
Arr2(1) = Array("IO.Type", "Serial")
Arr2(2) = Array("IO.Serial.Port", 1)
Arr2(3) = Array("IO.Serial.BaudRate", 19200)

' ------------------------------------------------------------------------------------------------------------------



' ------------------------------------------------------------------------------------------------------------------



' ------------------------------------------------------------------------------------------------------------------