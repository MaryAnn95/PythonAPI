let
    Source = Csv.Document(File.Contents("\\Mac\Home\Desktop\mySQLfIles\census2.csv"),[Delimiter=",", Columns=6, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"ID Nation", type text}, {"Nation", type text}, {"ID Year", Int64.Type}, {"Year", Int64.Type}, {"Population", Int64.Type}, {"Slug Nation", type text}}),
    #"Merged Queries" = Table.NestedJoin(#"Changed Type", {"ID Nation"}, #"census2 (3)", {"ID Nation"}, "census2 (3)", JoinKind.LeftOuter),
    #"Aggregated census2 (3)" = Table.AggregateTableColumn(#"Merged Queries", "census2 (3)", {{"Year", List.Sum, "Sum of census2 (3).Year"}})
in
    #"Aggregated census2 (3)"