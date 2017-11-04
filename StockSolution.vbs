Sub Stocks():
Sheets.Add
ActiveSheet.Name = "Summary"

Dim Ticker As String, Stock_Volume As Double, Opening_Price As Double, Closing_Price As Double, Yearly_Change As Double, Open_Start As Long, Summary_Row As Integer
Dim Percent_Change As Single, Days As Integer, Day_Change As Single, Avg_Change As Single
Dim sodumb As String

Stock_Volume = 0
Open_Start = 2
Summary_Row = 2
Percent_Change = 0
Day_Change = 0

Worksheets("Summary").Range("A1") = "Ticker"
Worksheets("Summary").Range("B1") = "Total Change"
Worksheets("Summary").Range("C1") = "% Change"
Worksheets("Summary").Range("D1") = "Avg. Daily Change"
Worksheets("Summary").Range("E1") = "Total Volume"

LastRow = Worksheets("2016").Cells(Rows.Count, 1).End(xlUp).Row

For i = 2 To LastRow

If Worksheets("2016").Cells(i + 1, 1).Value <> Worksheets("2016").Cells(i, 1).Value Then
    Ticker = Worksheets("2016").Cells(i, 1).Value
    Total_Change = Worksheets("2016").Cells(i, "F") - Worksheets("2016").Range("C" & Open_Start)
    Percent_Change = Total_Change / Worksheets("2016").Range("C" & Open_Start)
    Day_Change = Day_Change + (Worksheets("2016").Cells(i, "D") - Worksheets("2016").Cells(i, "E"))
    Stock_Volume = Stock_Volume + Worksheets("2016").Cells(i, 7).Value
    sodumb = FormatPercent(Percent_Change, 2)
    
    Days = (i - Open_Start) + 2
    Avg_Change = Day_Change / Days

Range("A" & Summary_Row).Value = Ticker
Range("B" & Summary_Row).Value = Total_Change
Range("C" & Summary_Row).Value = sodumb
Range("D" & Summary_Row).Value = Avg_Change
Range("E" & Summary_Row).Value = Stock_Volume

Summary_Row = Summary_Row + 1
Open_Start = i + 1

Stock_Volume = 0
Day_Change = 0
Percent_Change = 0

Else
Stock_Volume = Stock_Volume + Worksheets("2016").Cells(i, 7).Value


End If

Next i

For j = 2 To LastRow

If Cells(j, 2) >= 0 Then
Cells(j, 2).Interior.ColorIndex = 4

ElseIf Cells(j, 2) < 0 Then
Cells(j, 2).Interior.ColorIndex = 3

End If

Next j


End Sub
