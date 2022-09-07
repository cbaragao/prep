// Author: Chris Aragao
// Date: 9.2.2022
// Purpose: Documentation for Power Query on psst.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 9.2.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Table.FromColumns({Lines.FromBinary(File.Contents(FILEPATH & "psst.txt"), null, null, 1252)}),
    #"Split Column by Delimiter" = Table.SplitColumn(Source, "Column1", Splitter.SplitTextByDelimiter("#(tab)", QuoteStyle.Csv), {"Column1.1", "Column1.2", "Column1.3", "Column1.4", "Column1.5", "Column1.6", "Column1.7", "Column1.8", "Column1.9", "Column1.10", "Column1.11", "Column1.12", "Column1.13"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"Column1.1", type text}, {"Column1.2", Int64.Type}, {"Column1.3", type text}, {"Column1.4", Int64.Type}, {"Column1.5", Int64.Type}, {"Column1.6", Int64.Type}, {"Column1.7", Int64.Type}, {"Column1.8", Int64.Type}, {"Column1.9", type text}, {"Column1.10", type text}, {"Column1.11", type text}, {"Column1.12", type date}, {"Column1.13", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1.1", "mpcase"}, {"Column1.2", "supplement_id"}, {"Column1.3", "chemical_code"}, {"Column1.4", "total_potential_qty"}, {"Column1.5", "out_of_water_spill"}, {"Column1.6", "out_of_water_rec"}, {"Column1.7", "in_water_qty_spilled"}, {"Column1.8", "in_water_qty_rec"}, {"Column1.9", "units_measure"}, {"Column1.10", "substance_name"}, {"Column1.11", "type_of_substance"}, {"Column1.12", "spill_report_date"}, {"Column1.13", "sp"}}),
    #"Replaced P with Petroleum..." = Table.ReplaceValue(#"Renamed Columns","P","Petroleum Based Oils",Replacer.ReplaceValue,{"type_of_substance"}),
    #"Replaced C with Chemicals" = Table.ReplaceValue(#"Replaced P with Petroleum...","C","Chemicals",Replacer.ReplaceValue,{"type_of_substance"}),
    #"Replaced O with Other Oil..." = Table.ReplaceValue(#"Replaced C with Chemicals","O","Other Oil Products",Replacer.ReplaceValue,{"type_of_substance"}),
    #"Replaced G with Garbage..." = Table.ReplaceValue(#"Replaced O with Other Oil...","G","Garbage",Replacer.ReplaceValue,{"type_of_substance"}),
    #"Replaced U with Unknown" = Table.ReplaceValue(#"Replaced G with Garbage...","U","Unknown",Replacer.ReplaceValue,{"type_of_substance"}),
    #"Replaced M with Multiple..." = Table.ReplaceValue(#"Replaced U with Unknown","M","Multiple Substances",Replacer.ReplaceValue,{"type_of_substance"}),
    #"Replaced N with Natural..." = Table.ReplaceValue(#"Replaced M with Multiple...","N","Natural Substance",Replacer.ReplaceValue,{"type_of_substance"})
in
    #"Replaced N with Natural..."