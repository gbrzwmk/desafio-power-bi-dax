let
    Fonte = Excel.Workbook(File.Contents(PastaDados & "\Financial Sample.xlsx"), null, true),
    financials_Table = Fonte{[Item="financials",Kind="Table"]}[Data],
    // o cabeçalho original traz " Sales" com espaço à esquerda
    #"Nomes de Colunas Aparados" = Table.TransformColumnNames(financials_Table, Text.Trim),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Nomes de Colunas Aparados", {{"Segment", type text}, {"Country", type text}, {"Product", type text}, {"Discount Band", type text}, {"Units Sold", type number}, {"Manufacturing Price", Int64.Type}, {"Sale Price", type number}, {"Gross Sales", type number}, {"Discounts", type number}, {"Sales", type number}, {"COGS", type number}, {"Profit", type number}, {"Date", type date}, {"Month Number", Int64.Type}, {"Month Name", type text}, {"Year", Int64.Type}})
in
    #"Tipo Alterado"
