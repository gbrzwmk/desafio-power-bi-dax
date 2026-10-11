let
    Fonte = financials_origem,
    // SK_ID: índice sequencial que identifica cada venda da tabela original (mesma ordem em todas as tabelas)
    #"Índice Adicionado" = Table.AddIndexColumn(Fonte, "SK_ID", 0, 1, Int64.Type),
    #"Coluna Condicional Adicionada" = Table.AddColumn(#"Índice Adicionado", "ID_Produto", each if [Product] = "Carretera" then 0 else if [Product] = "Montana" then 1 else if [Product] = "Paseo" then 2 else if [Product] = "Velo" then 3 else if [Product] = "VTT" then 4 else if [Product] = "Amarilla" then 5 else null, Int64.Type),
    // Fato: chave de cada venda, chave do produto, atributos da venda e as medidas (unidades, preço, vendas, lucro) e a data
    #"Outras Colunas Removidas" = Table.SelectColumns(#"Coluna Condicional Adicionada", {"SK_ID", "ID_Produto", "Product", "Units Sold", "Sale Price", "Discount Band", "Segment", "Country", "Sales", "Profit", "Date"}),
    #"Colunas Reordenadas" = Table.ReorderColumns(#"Outras Colunas Removidas", {"SK_ID", "ID_Produto", "Product", "Units Sold", "Sale Price", "Discount Band", "Segment", "Country", "Sales", "Profit", "Date"}),
    #"Colunas Renomeadas" = Table.RenameColumns(#"Colunas Reordenadas", {{"Product", "Produto"}})
in
    #"Colunas Renomeadas"
