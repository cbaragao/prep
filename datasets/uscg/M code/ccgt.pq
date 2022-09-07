// Author: Chris Aragao
// Date: 8.31.2022
// Purpose: Documentation for Power Query on ccgt.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 8.31.2022: Initial documentation provided.


(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "ccgt.txt"),[Delimiter="	", Columns=7, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Renamed Columns" = Table.RenameColumns(Source,{{"Column1", "mccase"}, {"Column2", "subject"}, {"Column3", "speed"}, {"Column4", "impact_location"}, {"Column5", "double_btm_vsl"}, {"Column6", "double_hull_vsl"}, {"Column7", "sp"}}),
    #"Invoked fnReplaceBoolean on dbv" = Table.AddColumn(#"Renamed Columns", "double_bottom_vessel", each fnReplaceBoolean([double_btm_vsl], "Y", "N")),
    #"Invoked fnReplaceBoolean on dhv" = Table.AddColumn(#"Invoked fnReplaceBoolean on dbv", "double_hull_vessel", each fnReplaceBoolean([double_hull_vsl], "Y", "N")),
    #"Removed Other Columns" = Table.SelectColumns(#"Invoked fnReplaceBoolean on dhv",{"mccase", "subject", "speed", "impact_location", "sp", "double_bottom_vessel", "double_hull_vessel"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Removed Other Columns",{"mccase", "subject", "speed", "impact_location", "double_bottom_vessel", "double_hull_vessel", "sp"}),
    #"Changed Type to whole numbers" = Table.TransformColumnTypes(#"Reordered Columns",{{"double_hull_vessel", Int64.Type}, {"double_bottom_vessel", Int64.Type}, {"speed", Int64.Type}})
in
    #"Changed Type to whole numbers"