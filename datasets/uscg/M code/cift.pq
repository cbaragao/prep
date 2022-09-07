// Author: Chris Aragao
// Date: 8.31.2022
// Purpose: Documentation for Power Query on cift.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 8.31.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "cift.txt"),[Delimiter="	", Columns=17, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Renamed Columns" = Table.RenameColumns(Source,{{"Column1", "mccase"}, {"Column2", "facility_id_no"}, {"Column3", "facility_name"}, {"Column4", "category"}, {"Column5", "mcpd_ind"}, {"Column6", "mcpd_clsd"}, {"Column7", "pers_action"}, {"Column8", "mcpa_ind"}, {"Column9", "mcpi_ind"}, {"Column10", "mcsi_ind"}, {"Column11", "operation"}, {"Column12", "cont_stat"}, {"Column13", "verified"}, {"Column14", "facility_key"}, {"Column15", "subject"}, {"Column16", "subj_ref_num"}, {"Column17", "sp"}}),
    #"Replace Xs with 1s" = Table.ReplaceValue(#"Renamed Columns","X","1",Replacer.ReplaceText,{"mcpd_ind", "mcpd_clsd", "mcpa_ind", "mcpi_ind", "mcsi_ind", "verified"}),
    #"Replace Blanks with -1" = Table.ReplaceValue(#"Replace Xs with 1s","","-1",Replacer.ReplaceValue,{"mcpd_ind", "mcpd_clsd", "mcpa_ind", "mcpi_ind", "mcsi_ind", "verified"}),
    #"Replace Random V with 1" = Table.ReplaceValue(#"Replace Blanks with -1","V","1",Replacer.ReplaceText,{"mcpi_ind"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Replace Random V with 1",{{"subj_ref_num", Int64.Type}, {"verified", Int64.Type}, {"mcsi_ind", Int64.Type}, {"mcpi_ind", Int64.Type}, {"mcpa_ind", Int64.Type}, {"mcpd_clsd", Int64.Type}, {"mcpd_ind", Int64.Type}})
in
    #"Changed Type"