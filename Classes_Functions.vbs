' Dummy Class
Class Screen:

	Public Function Item(ItemId)
	End Sub

	Public Function AddObject(ClassName, [Activate], [ObjectName])
	End Sub

	Public Function GetADORecordeSet()
	End Sub

	Public Function GetAsyncADORecordset()
	End Function

	Public Function BOF
	End Sub

	Public Function EOF
	End Sub

    Public Function MoveFirst
    End Sub

    Public Function MoveLast
    End Sub

	Public Function MoveNext
	End Sub

	Public Function MovePrevious
	End Sub

    Public Function RecordCount
    End Sub

    Public Function Fields(fieldname)
    End Sub
End Class

Class Application:
	Public Function Item(string)
	End Sub

	Public Function AddObject(string, bool, string)
	End Sub

	Public Function GetADORecordeSet()
	End Sub

	Public Function WriteRecord()
	End Sub

	Public Function Execute()
	End Sub

	Public Function SetVariableValue(varName, value)
End Class

' Dummy Functions
Function Set
End Function