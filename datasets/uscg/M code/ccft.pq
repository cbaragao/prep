// Author: Chris Aragao
// Date: 8.31.2022
// Purpose: Documentation for Power Query on ccft.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 8.31.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "ccft.txt"),[Delimiter="	", Columns=14, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Renamed Columns" = Table.RenameColumns(Source,{{"Column1", "mccase"}, {"Column2", "event"}, {"Column3", "category"}, {"Column4", "subject"}, {"Column5", "class"}, {"Column6", "subclass"}, {"Column7", "state"}, {"Column8", "party"}, {"Column9", "first_casual_event"}, {"Column10", "second_casual_event"}, {"Column11", "supplement_indicator"}, {"Column12", "supplement_id"}, {"Column13", "human_factor_no"}, {"Column14", "sp"}}),
    #"Invoked fnReplaceBoolean" = Table.AddColumn(#"Renamed Columns", "supp_indicator", each fnReplaceBoolean([supplement_indicator], "X", null)),
    #"Reordered Columns" = Table.ReorderColumns(#"Invoked fnReplaceBoolean",{"mccase", "event", "category", "subject", "class", "subclass", "state", "party", "first_casual_event", "second_casual_event", "supplement_indicator", "supp_indicator", "supplement_id", "human_factor_no", "sp"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Reordered Columns",{{"human_factor_no", Int64.Type}, {"event", Int64.Type}, {"subject", Int64.Type}, {"first_casual_event", Int64.Type}, {"second_casual_event", Int64.Type}, {"supp_indicator", Int64.Type}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Changed Type",{"mccase", "event", "category", "subject", "class", "subclass", "state", "party", "first_casual_event", "second_casual_event", "supp_indicator", "supplement_id", "human_factor_no", "sp"}),
    #"Renamed Supp_Indicator" = Table.RenameColumns(#"Removed Other Columns",{{"supp_indicator", "supplement_indicator"}})
in
    #"Renamed Supp_Indicator"