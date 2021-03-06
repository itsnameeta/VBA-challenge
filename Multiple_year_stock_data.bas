Attribute VB_Name = "Module1"
'VBA Homework - The VBA of Wall Street
'1. Create a script that will loop through all the stocks for one year and output the following information.
    'The ticker symbol.
    'Yearly change from opening price at the beginning of a given year to the closing price at the end of that year.
    'The percent change from opening price at the beginning of a given year to the closing price at the end of that year.
    'The total stock volume of the stock.
'2. You should also have conditional formatting that will highlight positive change in green and negative change in red.
'3. Your solution will also be able to return the stock with the "Greatest % increase", "Greatest % decrease" and "Greatest total volume". The solution will look as follows:
' ****Make the appropriate adjustments to your VBA script that will allow it to run on every worksheet, i.e., every year, just by running the VBA script once.


Sub Wall_Street()
        Dim ws As Worksheet
        For Each ws In ActiveWorkbook.Worksheets    'Run on every worksheet, i.e., every year
            ws.Select
            Call Stock_Data
        Next ws
End Sub

Sub Stock_Data()

    Dim ticker As String
    Dim total_stock As Double
    Dim ticker_count As Long
    Dim year_open As Double
    Dim year_close As Double
    Dim yearly_pct As Double
    
    Dim greatest_volume As Double
    Dim greatest_volume_stock As String
    
    Dim gp_inc As Double
    Dim gp_inc_stock As String
    
    Dim gp_dec As Double
    Dim gp_dec_stock As String
    
    '1-Write headers/ highlight them to yellow
    Cells(1, 9).Value = "Ticker"  'The ticker symbol.
    Cells(1, 9).Interior.Color = vbYellow
    
    Cells(1, 10).Value = "Yearly Change" 'Yearly change from opening price at the beginning of a given year to the closing price at the end of that year.
    Cells(1, 10).Interior.Color = vbYellow
    
    Cells(1, 11).Value = "Percentage Change" 'The percent change from opening price at the beginning of a given year to the closing price at the end of that year.
    Cells(1, 11).Interior.Color = vbYellow
    
    Cells(1, 12).Value = "Total Volume"   'The total stock volume of the stock.
    Cells(1, 12).Interior.Color = vbYellow
    
    Dim lastrow As Double
    lastrow = Cells(Rows.Count, "A").End(xlUp).Row

    'Open price for the year for 1st ticker
    year_open = Cells(2, 3).Value
    
    For Row = 2 To lastrow
    
        ticker = Cells(Row, 1).Value
        day_stock_vol = Cells(Row, 7).Value
        day_open_price = Cells(Row, 3).Value
        day_close_price = Cells(Row, 6).Value
        
        next_stock_sym = Cells(Row + 1, 1).Value
        next_open_price = Cells(Row + 1, 3).Value
        total_stock = day_stock_vol + total_stock
        
        If (year_open = 0) Then
            year_open = day_open_price
        End If
        
        If (ticker <> next_stock_sym) Then
            year_close = day_close_price
            Cells(ticker_count + 2, 9).Value = ticker
            Cells(ticker_count + 2, 12).Value = total_stock
            ticker_count = ticker_count + 1
            
            '1-calculate yearly change and % change
            yearly_change = (year_close - year_open)
            Cells(ticker_count + 1, 10).Value = yearly_change
                        
            If (year_open = 0) Then
                Cells(ticker_count + 1, 11).Value = "NA" 'Check for divide by zero error
            Else
                Cells(ticker_count + 1, 11).Value = yearly_change / year_open
            End If
            Cells(ticker_count + 1, 11).NumberFormat = "0.00%"
            
            '2-conditional formatting that will highlight positive change in green and negative change in red
            If (year_close < year_open) Then
                Cells(ticker_count + 1, 10).Interior.Color = vbRed
            Else
                Cells(ticker_count + 1, 10).Interior.Color = vbGreen
            End If
             
            '3-calculate Greatest % increase, Greatest % decrease and Greatest total volume
            If (total_stock > greatest_volume) Then
                greatest_volume = total_stock
                greatest_volume_stock = ticker
            End If
            
            If (year_open <> 0) Then
                If (yearly_change / year_open > gp_inc) Then
                    gp_inc = yearly_change / year_open
                    gp_inc_stock = ticker
                End If
            End If
            
            If (year_open <> 0) Then
                If (yearly_change / year_open < gp_dec) Then
                    gp_dec = yearly_change / year_open
                    gp_dec_stock = ticker
                End If
            End If
            
            'Reset values
            total_stock = 0
            year_open = next_open_price

            
        End If
        
        
    Next Row
    
    '3- write Greatest % increase, Greatest % decrease and Greatest total volume
    Cells(1, 16).Value = "Ticker"
    Cells(1, 16).Interior.Color = vbYellow
    Cells(1, 17).Value = "Value"
    Cells(1, 17).Interior.Color = vbYellow
    
    Cells(2, 15).Value = "Greatest % Increase"
    Cells(3, 15).Value = "Greatest % Decrease"
    Cells(4, 15).Value = "Greatest Total Volume"
    
    Cells(2, 17).Value = gp_inc
    Cells(2, 17).NumberFormat = "0.00%"
    Cells(2, 16).Value = gp_inc_stock
    
    Cells(3, 17).Value = gp_dec
    Cells(3, 17).NumberFormat = "0.00%"
    Cells(3, 16).Value = gp_dec_stock
    
    Cells(4, 17).Value = greatest_volume
    Cells(4, 16).Value = greatest_volume_stock
    
    
End Sub


