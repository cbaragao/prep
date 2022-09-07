// Author: Chris Aragao
// Date: 8.31.2022
// Purpose: Documentation for Power Query on civt.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 8.31.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(FILEPATH & "civt.txt"),[Delimiter="	", Columns=20, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", type text}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type text}, {"Column11", type text}, {"Column12", type text}, {"Column13", type text}, {"Column14", type text}, {"Column15", type text}, {"Column16", type text}, {"Column17", type text}, {"Column18", Int64.Type}, {"Column19", type text}, {"Column20", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "mccase"}, {"Column2", "vessel_id"}, {"Column3", "vessel_name"}, {"Column4", "flag"}, {"Column5", "service"}, {"Column6", "mcpd_ind"}, {"Column7", "mcpa_ind"}, {"Column8", "mcpi_ind"}, {"Column9", "mcsi_ind"}, {"Column10", "tow_supp"}, {"Column11", "dam_eval"}, {"Column12", "operation"}, {"Column13", "vsl_status"}, {"Column14", "vkey"}, {"Column15", "towed_vsl_pos"}, {"Column16", "tow_status"}, {"Column17", "subject"}, {"Column18", "subject_ref_num"}, {"Column19", "mcpd_closed"}, {"Column20", "filler"}}),
    #"Replaced Random V" = Table.ReplaceValue(#"Renamed Columns","V","X",Replacer.ReplaceText,{"mcpi_ind"}),
    #"Replaced Blanks with -1" = Table.ReplaceValue(#"Replaced Random V","","-1",Replacer.ReplaceValue,{"mcpd_ind", "mcpa_ind", "mcpi_ind", "mcsi_ind", "tow_supp", "mcpd_closed"}),
    #"Replaced X with 1" = Table.ReplaceValue(#"Replaced Blanks with -1","X","1",Replacer.ReplaceText,{"mcpd_ind", "mcpa_ind", "mcpi_ind", "mcsi_ind", "mcpd_closed"}),
    #"Changed Type on Indicator columns" = Table.TransformColumnTypes(#"Replaced X with 1",{{"mcpd_ind", Int64.Type}, {"mcpa_ind", Int64.Type}, {"mcpi_ind", Int64.Type}, {"mcsi_ind", Int64.Type}, {"tow_supp", Int64.Type}, {"mcpd_closed", Int64.Type}})
in
    #"Changed Type on Indicator columns"