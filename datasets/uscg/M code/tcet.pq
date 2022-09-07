// Author: Chris Aragao
// Date: 9.2.2022
// Purpose: Documentation for Power Query on tcet.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 9.2.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "tcet.txt"),[Delimiter="	", Columns=13, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", Int64.Type}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", Int64.Type}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type text}, {"Column11", type text}, {"Column12", Int64.Type}, {"Column13", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "ticket_number"}, {"Column2", "casualty_event"}, {"Column3", "event_type"}, {"Column4", "event_class"}, {"Column5", "event_state"}, {"Column6", "casualty_causal_event"}, {"Column7", "causal_category"}, {"Column8", "causal_class"}, {"Column9", "causal_subclass"}, {"Column10", "causal_circumstance"}, {"Column11", "causal_party"}, {"Column12", "causal_event"}, {"Column13", "sp"}}),
    #"Replaced EF with Equipment Failure" = Table.ReplaceValue(#"Renamed Columns","EF","Equipment Failure",Replacer.ReplaceValue,{"causal_category"}),
    #"Replaced HF with Human Factor" = Table.ReplaceValue(#"Replaced EF with Equipment Failure","HF","Human Factor",Replacer.ReplaceValue,{"causal_category"}),
    #"Replaced HM with Hazardous Material" = Table.ReplaceValue(#"Replaced HF with Human Factor","HM","Hazardous Material",Replacer.ReplaceValue,{"causal_category"}),
    #"Replaced WX with Weather" = Table.ReplaceValue(#"Replaced HM with Hazardous Material","WX","Weather",Replacer.ReplaceValue,{"causal_category"})
in
    #"Replaced WX with Weather"