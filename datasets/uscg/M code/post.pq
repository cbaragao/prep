// Author: Chris Aragao
// Date: 9.2.2022
// Purpose: Documentation for Power Query on post.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 9.2.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "post.txt"),[Delimiter="	", Columns=19, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", Int64.Type}, {"Column3", type text}, {"Column4", type text}, {"Column5", Int64.Type}, {"Column6", type text}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type text}, {"Column11", type text}, {"Column12", type text}, {"Column13", type text}, {"Column14", type text}, {"Column15", type text}, {"Column16", type text}, {"Column17", type text}, {"Column18", type text}, {"Column19", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "mpcase"}, {"Column2", "supplement_id"}, {"Column3", "verify_indicator"}, {"Column4", "source_name"}, {"Column5", "num_poluts_spilled"}, {"Column6", "operation"}, {"Column7", "violation_report_num"}, {"Column8", "local_source_id"}, {"Column9", "own_class"}, {"Column10", "source_type"}, {"Column11", "source_use"}, {"Column12", "penalty_action"},{"Column13", "primary_cause"}, {"Column14", "secondary_cause"}, {"Column15", "contrib_factor_1"}, {"Column16", "contrib_factor_2"}, {"Column17", "facility_identification"}, {"Column18", "facility_key"}, {"Column19", "sp"}}),
    #"Replaced Y with 1" = Table.ReplaceValue(#"Renamed Columns","Y","1",Replacer.ReplaceText,{"penalty_action"}),
    #"Replaced N with 0" = Table.ReplaceValue(#"Replaced Y with 1","N","0",Replacer.ReplaceText,{"penalty_action"}),
    #"Replaced Blank with -1" = Table.ReplaceValue(#"Replaced N with 0","","-1",Replacer.ReplaceValue,{"penalty_action"}),
    #"Changed penalty action to number" = Table.TransformColumnTypes(#"Replaced Blank with -1",{{"penalty_action", Int64.Type}})
in
    #"Changed penalty action to number"