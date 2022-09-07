// Author: Chris Aragao
// Date: 9.2.2022
// Purpose: Documentation for Power Query on fidt.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 9.2.2022: Initial documentation provided.


(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "fidt.txt"),[Delimiter="	", Columns=24, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Renamed Columns" = Table.RenameColumns(Source,{{"Column1", "fkey"}, {"Column2", "port_zone"}, {"Column3", "unit"}, {"Column4", "unit_category"}, {"Column5", "primary_fin"}, {"Column6", "1st_alt_fin"}, {"Column7", "2nd_alt_fin"}, {"Column8", "3rd_alt_fin"}, {"Column9", "facility_name"}, {"Column10", "local_id"}, {"Column11", "category"}, {"Column12", "use"}, {"Column13", "ownership"}, {"Column14", "nec_category"}, {"Column15", "inactive_indicator"}, {"Column16", "contact"}, {"Column17", "day_phone"}, {"Column18", "night_phone"}, {"Column19", "emergency"}, {"Column20", "last_inspection_date"}, {"Column21", "marpol_solo_ind"}, {"Column22", "marpol_super_ind"}, {"Column23", "marpol_fkey"}, {"Column24", "sp"}}),
    #"Replaced X with 1" = Table.ReplaceValue(#"Renamed Columns","X","1",Replacer.ReplaceText,{"marpol_solo_ind", "marpol_super_ind"}),
    #"Replaced Blank with -1" = Table.ReplaceValue(#"Replaced X with 1","","-1",Replacer.ReplaceValue,{"marpol_solo_ind", "marpol_super_ind"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Replaced Blank with -1",{{"marpol_solo_ind", Int64.Type}, {"marpol_super_ind", Int64.Type}})
in
    #"Changed Type"