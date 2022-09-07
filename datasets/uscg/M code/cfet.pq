// Author: Chris Aragao
// Date: 8.31.2022
// Purpose: Documentation for Power Query on cfet.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 8.31.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "cfet.txt"),[Delimiter="	", Columns=14, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Renamed Columns" = Table.RenameColumns(Source,{{"Column1", "mccase"}, {"Column2", "subject"}, {"Column3", "location"}, {"Column4", "ignition_source"}, {"Column5", "fuel_source"}, {"Column6", "detection"}, {"Column7", "immediate_area"}, {"Column8", "adjacent_areas"}, {"Column9", "fixed"}, {"Column10", "portable"}, {"Column11", "smoke_fact"}, {"Column12", "page_key"}, {"Column13", "sup_ind"}, {"Column14", "sp"}}),
    #"Replaced Boolean FN on SF" = Table.AddColumn(#"Renamed Columns", "smoke_factor", each fnReplaceBoolean([smoke_fact], "Y", "N")),
    #"Replace Boolean FN on SI" = Table.AddColumn(#"Replaced Boolean FN on SF", "supp_ind", each fnReplaceBoolean([sup_ind], "X", null)),
    #"Reordered Columns" = Table.ReorderColumns(#"Replace Boolean FN on SI",{"mccase", "subject", "location", "ignition_source", "fuel_source", "detection", "immediate_area", "adjacent_areas", "fixed", "portable", "smoke_fact", "page_key", "sup_ind", "smoke_factor", "supp_ind", "sp"}),
    #"Removed Other Columns" = Table.SelectColumns(#"Reordered Columns",{"mccase", "subject", "location", "ignition_source", "fuel_source", "detection", "immediate_area", "adjacent_areas", "fixed", "portable", "page_key", "smoke_factor", "supp_ind", "sp"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Removed Other Columns",{{"smoke_factor", Int64.Type}, {"supp_ind", Int64.Type}, {"page_key", Int64.Type}})
in
    #"Changed Type"