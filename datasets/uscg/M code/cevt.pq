// Author: Chris Aragao
// Date: 8.31.2022
// Purpose: Documentation for Power Query on cevt.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 8.31.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "cevt.txt"),[Delimiter="	", Columns=12, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Renamed Columns" = Table.RenameColumns(Source,{{"Column1", "mccase"}, {"Column2", "event"}, {"Column3", "first_subject_num"}, {"Column4", "second_subject_num"}, {"Column5", "type"}, {"Column6", "class"}, {"Column7", "state"}, {"Column8", "first_casual_event"}, {"Column9", "second_casual_event"}, {"Column10", "first_subject_sign"}, {"Column11", "second_subject_sign"}, {"Column12", "sp"}}),
    #"Changed to whole numbers" = Table.TransformColumnTypes(#"Renamed Columns",{{"second_casual_event", Int64.Type}, {"first_casual_event", Int64.Type}, {"second_subject_num", Int64.Type}, {"first_subject_num", Int64.Type}, {"event", Int64.Type}})
in
    #"Changed to whole numbers"