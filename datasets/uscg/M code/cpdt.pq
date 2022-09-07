// Author: Chris Aragao
// Date: 9.2.2022
// Purpose: Documentation for Power Query on cpdt.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 9.2.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Table.FromColumns({Lines.FromBinary(File.Contents("C:\Users\chris\OneDrive\MILLIB\USCG\MarCas_Part1\cpdt.txt"), null, null, 1252)}),
    #"Split Column by Delimiter" = Table.SplitColumn(Source, "Column1", Splitter.SplitTextByDelimiter("#(tab)", QuoteStyle.Csv), {"Column1.1", "Column1.2", "Column1.3", "Column1.4", "Column1.5", "Column1.6", "Column1.7", "Column1.8", "Column1.9", "Column1.10", "Column1.11", "Column1.12", "Column1.13", "Column1.14"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"Column1.1", type text}, {"Column1.2", type text}, {"Column1.3", type text}, {"Column1.4", type text}, {"Column1.5", Int64.Type}, {"Column1.6", Int64.Type}, {"Column1.7", Int64.Type}, {"Column1.8", Int64.Type}, {"Column1.9", Int64.Type}, {"Column1.10", type text}, {"Column1.11", type text}, {"Column1.12", type text}, {"Column1.13", type date}, {"Column1.14", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1.1", "mccase"}, {"Column1.2", "subject"}, {"Column1.3", "chem_code"}, {"Column1.4", "type"}, {"Column1.5", "potential_qty"}, {"Column1.6", "out_of_water_spilled"}, {"Column1.7", "out_of_water_recovered"}, {"Column1.8", "in_water_spilled"}, {"Column1.9", "in_water_recovered"}, {"Column1.10", "units_measured"}, {"Column1.11", "substance_name"}, {"Column1.12", "category"}, {"Column1.13", "date_of_spill"}, {"Column1.14", "sp"}}),
    #"Replaced L with Liquid" = Table.ReplaceValue(#"Renamed Columns","L","Liquid",Replacer.ReplaceText,{"type"}),
    #"Replaced G with Gas" = Table.ReplaceValue(#"Replaced L with Liquid","G","Gas",Replacer.ReplaceText,{"type"}),
    #"Replaced S with Solid" = Table.ReplaceValue(#"Replaced G with Gas","S","Solid",Replacer.ReplaceText,{"type"}),
    #"Replaced P with Petroleum..." = Table.ReplaceValue(#"Replaced S with Solid","P","Petroleum-Based Products",Replacer.ReplaceText,{"category"}),
    #"Replaced O with Other Oil..." = Table.ReplaceValue(#"Replaced P with Petroleum...","O","Other Oil Products",Replacer.ReplaceText,{"category"}),
    #"Replaced C with Chemical" = Table.ReplaceValue(#"Replaced O with Other Oil...","C","Chemical",Replacer.ReplaceText,{"category"}),
    #"Replaced N with Natural Substance" = Table.ReplaceValue(#"Replaced C with Chemical","N","Natural Substance",Replacer.ReplaceText,{"category"}),
    #"Replaced M with Multiple Substances" = Table.ReplaceValue(#"Replaced N with Natural Substance","M","Multiple Substances",Replacer.ReplaceText,{"category"}),
    #"Replaced G with Garbage" = Table.ReplaceValue(#"Replaced M with Multiple Substances","G","Garbage",Replacer.ReplaceText,{"category"}),
    #"Replaced U with Unknown" = Table.ReplaceValue(#"Replaced G with Garbage","U","Unknown",Replacer.ReplaceText,{"category"})
in
    #"Replaced U with Unknown"