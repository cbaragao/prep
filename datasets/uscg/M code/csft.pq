// Author: Chris Aragao
// Date: 9.2.2022
// Purpose: Documentation for Power Query on csft.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 9.2.2022: Initial documentation provided.


(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "csft.txt"),[Delimiter="	", Columns=16, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", Int64.Type}, {"Column5", type text}, {"Column6", type text}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type text}, {"Column11", type text}, {"Column12", type text}, {"Column13", type text}, {"Column14", type text}, {"Column15", type text}, {"Column16", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "mccase"}, {"Column2", "subject"}, {"Column3", "class"}, {"Column4", "type"}, {"Column5", "pattern_type"}, {"Column6", "port"}, {"Column7", "starboard"}, {"Column8", "center"}, {"Column9", "deck"}, {"Column10", "bottom"}, {"Column11", "side"}, {"Column12", "internal"}, {"Column13", "bow"}, {"Column14", "stern"}, {"Column15", "special_attn_vessel"}, {"Column16", "sp"}}),
    #"Replaced Y with Yes" = Table.ReplaceValue(#"Renamed Columns","Y","Yes",Replacer.ReplaceValue,{"port"}),
    #"Replaced N with No" = Table.ReplaceValue(#"Replaced Y with Yes","N","No",Replacer.ReplaceValue,{"port"}),
    #"Replaced Blank with na" = Table.ReplaceValue(#"Replaced N with No","","n/a",Replacer.ReplaceValue,{"port", "starboard", "center", "deck", "bottom", "side", "internal", "bow", "stern", "special_attn_vessel"}),
    #"Replaced X with Yes" = Table.ReplaceValue(#"Replaced Blank with na","X","Yes",Replacer.ReplaceValue,{"starboard", "center", "deck", "bottom", "side", "internal", "bow", "stern", "special_attn_vessel"}),
    #"Concat Indicators" = Table.AddColumn(#"Replaced X with Yes", "Indicators", each "Port: " & [port] & "; Starboard: " & [starboard] & "; Center: " & [center] & "; Deck: " & [deck] & "; Bottom: " & [bottom] & "; Side: " & [side] & "; Internal:" & [internal] & "; Bow: " & [bow] & "; " & [stern] & "Special Attention Vessel: " & [special_attn_vessel]),
    #"Removed Other Columns" = Table.SelectColumns(#"Concat Indicators",{"mccase", "subject", "class", "type", "pattern_type", "sp", "Indicators"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Removed Other Columns",{"mccase", "subject", "class", "type", "pattern_type", "Indicators", "sp"})
in
    #"Reordered Columns"