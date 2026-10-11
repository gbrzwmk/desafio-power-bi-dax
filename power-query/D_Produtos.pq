let
    Fonte = financials_origem,
    // Agrupar por Product (avançado): estatísticas de unidades e de preço de venda por produto
    #"Linhas Agrupadas" = Table.Group(Fonte, {"Product"}, {{"Média de Unidades Vendidas", each List.Average([Units Sold]), type nullable number}, {"Média do Valor de Vendas", each List.Average([Sale Price]), type nullable number}, {"Mediana do Valor de Vendas", each List.Median([Sale Price]), type nullable number}, {"Valor Máximo de Venda", each List.Max([Sale Price]), type nullable number}, {"Valor Mínimo de Venda", each List.Min([Sale Price]), type nullable number}}),
    // Coluna condicional: índice numérico do produto (chave da dimensão)
    #"Coluna Condicional Adicionada" = Table.AddColumn(#"Linhas Agrupadas", "ID_Produto", each if [Product] = "Carretera" then 0 else if [Product] = "Montana" then 1 else if [Product] = "Paseo" then 2 else if [Product] = "Velo" then 3 else if [Product] = "VTT" then 4 else if [Product] = "Amarilla" then 5 else null, Int64.Type),
    #"Colunas Reordenadas" = Table.ReorderColumns(#"Coluna Condicional Adicionada", {"ID_Produto", "Product", "Média de Unidades Vendidas", "Média do Valor de Vendas", "Mediana do Valor de Vendas", "Valor Máximo de Venda", "Valor Mínimo de Venda"}),
    #"Colunas Renomeadas" = Table.RenameColumns(#"Colunas Reordenadas", {{"Product", "Produto"}}),
    #"Linhas Classificadas" = Table.Sort(#"Colunas Renomeadas", {{"ID_Produto", Order.Ascending}})
in
    #"Linhas Classificadas"
