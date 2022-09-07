// Author: Chris Aragao
// Date: 9.3.2022
// Purpose: Documentation for Power Query on pssttk.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 9.3.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Table.FromColumns({Lines.FromBinary(File.Contents(FILEPATH & "pssttk.txt"), null, null, 1252)}),
    #"Split Column by Delimiter" = Table.SplitColumn(Source, "Column1", Splitter.SplitTextByDelimiter("#(tab)", QuoteStyle.Csv), {"Column1.1", "Column1.2", "Column1.3", "Column1.4", "Column1.5", "Column1.6", "Column1.7", "Column1.8", "Column1.9", "Column1.10", "Column1.11", "Column1.12", "Column1.13"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"Column1.1", type text}, {"Column1.2", Int64.Type}, {"Column1.3", type text}, {"Column1.4", Int64.Type}, {"Column1.5", Int64.Type}, {"Column1.6", type text}, {"Column1.7", type text}, {"Column1.8", type text}, {"Column1.9", type text}, {"Column1.10", type text}, {"Column1.11", type text}, {"Column1.12", type date}, {"Column1.13", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1.1", "mpcase"}, {"Column1.2", "supplement_id"}, {"Column1.3", "chemical_code"}, {"Column1.4", "potential_qty"}, {"Column1.5", "out_of_water_spilled"}, {"Column1.6", "out_of_water_recover"}, {"Column1.7", "in_water_spilled"}, {"Column1.8", "in_water_recover"}, {"Column1.9", "units_measure"}, {"Column1.10", "substance_name"}, {"Column1.11", "type"}, {"Column1.12", "spill_report_date"}, {"Column1.13", "sp"}}),
    #"Replaced P w Petroleum..." = Table.ReplaceValue(#"Renamed Columns","P","Petroleum Based Oils",Replacer.ReplaceValue,{"type"}),
    #"Replaced C w Chemicals" = Table.ReplaceValue(#"Replaced P w Petroleum...","C","Chemicals",Replacer.ReplaceValue,{"type"}),
    #"Replace N w Natural..." = Table.ReplaceValue(#"Replaced C w Chemicals","N","Natural Substance",Replacer.ReplaceValue,{"type"}),
    #"Replaced M w Multiple..." = Table.ReplaceValue(#"Replace N w Natural...","M","Multiple Substances",Replacer.ReplaceValue,{"type"}),
    #"Replaced O w Other Oil..." = Table.ReplaceValue(#"Replaced M w Multiple...","O","Other Oil Products",Replacer.ReplaceValue,{"type"}),
    #"Replaced G with Garbage" = Table.ReplaceValue(#"Replaced O w Other Oil...","G","Garbage",Replacer.ReplaceValue,{"type"}),
    #"Replaced U with Unknown" = Table.ReplaceValue(#"Replaced G with Garbage","U","Unknown",Replacer.ReplaceValue,{"type"})
in
    #"Replaced U with Unknown"