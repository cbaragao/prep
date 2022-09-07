// Author: Chris Aragao
// Date: 9.2.2022
// Purpose: Documentation for Power Query on pcas.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 9.2.2022: Initial documentation provided.


(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "pcas.txt"),[Delimiter="	", Columns=29, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", Int64.Type}, {"Column5", type text}, {"Column6", type text}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type text}, {"Column11", type text}, {"Column12", type text}, {"Column13", type text}, {"Column14", type text}, {"Column15", type text}, {"Column16", type text}, {"Column17", type date}, {"Column18", type text}, {"Column19", type text}, {"Column20", type text}, {"Column21", type text}, {"Column22", type text}, {"Column23", type text}, {"Column24", type text}, {"Column25", Int64.Type}, {"Column26", Int64.Type}, {"Column27", type text}, {"Column28", type text}, {"Column29", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "mccase"}, {"Column2", "lname"}, {"Column3", "fname"}, {"Column4", "birthdate"}, {"Column5", "status"}, {"Column6", "acc_id"}, {"Column7", "injury"}, {"Column8", "body_part"}, {"Column9", "result"}, {"Column10", "cause1"}, {"Column11", "cause2"}, {"Column12", "office"}, {"Column13", "p_location"}, {"Column14", "activity"}, {"Column15", "waterbody"}, {"Column16", "yr_built"}, {"Column17", "case_date"}, {"Column18", "oper_co"}, {"Column19", "vin"}, {"Column20", "vkey"}, {"Column21", "flag"}, {"Column22", "service"}, {"Column23", "v_use"}, {"Column24", "design"}, {"Column25", "length"}, {"Column26", "gr_tons"}, {"Column27", "vslname"}, {"Column28", "numcas"}, {"Column29", "sp"}}),
    #"Split Column by Positions" = Table.SplitColumn(Table.TransformColumnTypes(#"Renamed Columns", {{"birthdate", type text}}, "en-US"), "birthdate", Splitter.SplitTextByPositions({0, 4, 6}), {"birthdate.1", "birthdate.2", "birthdate.3"}),
    #"Make bdate cols numbers" = Table.TransformColumnTypes(#"Split Column by Positions",{{"birthdate.2", Int64.Type}, {"birthdate.1", Int64.Type}, {"birthdate.3", Int64.Type}}),
    #"Merged bdate columns" = Table.CombineColumns(Table.TransformColumnTypes(#"Make bdate cols numbers", {{"birthdate.1", type text}, {"birthdate.2", type text}, {"birthdate.3", type text}}, "en-US"),{"birthdate.1", "birthdate.2", "birthdate.3"},Combiner.CombineTextByDelimiter("-", QuoteStyle.None),"birthdate"),
    #"Replaced -- with blank" = Table.ReplaceValue(#"Merged bdate columns","--","",Replacer.ReplaceText,{"birthdate"}),
    #"Make birthdate a date" = Table.TransformColumnTypes(#"Replaced -- with blank",{{"birthdate", type date}}),
    #"Replaced Error Birthdates with null" = Table.ReplaceErrorValues(#"Make birthdate a date", {{"birthdate", null}})
in
    #"Replaced Error Birthdates with null"