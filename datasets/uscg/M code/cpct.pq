// Author: Chris Aragao
// Date: 9.2.2022
// Purpose: Documentation for Power Query on cpct.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 9.2.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "cpct.txt"),[Delimiter="	", Columns=33, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", type date}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type text}, {"Column11", type text}, {"Column12", type date}, {"Column13", type text}, {"Column14", Int64.Type}, {"Column15", type text}, {"Column16", type text}, {"Column17", type text}, {"Column18", type text}, {"Column19", type text}, {"Column20", type text}, {"Column21", type text}, {"Column22", Int64.Type}, {"Column23", Int64.Type}, {"Column24", Int64.Type}, {"Column25", Int64.Type}, {"Column26", Int64.Type}, {"Column27", Int64.Type}, {"Column28", Int64.Type}, {"Column29", Int64.Type}, {"Column30", type text}, {"Column31", type text}, {"Column32", type text}, {"Column33", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "mccase"}, {"Column2", "subject"}, {"Column3", "involved_party_number"}, {"Column4", "last_name"}, {"Column5", "first_name"}, {"Column6", "date_of_birth"}, {"Column7", "status"}, {"Column8", "injury"}, {"Column9", "dead"}, {"Column10", "missing"}, {"Column11", "on_duty"}}),
    #"Replaced X with 1" = Table.ReplaceValue(#"Renamed Columns","X","1",Replacer.ReplaceText,{"injury", "dead", "missing"}),
    #"Replaced Null with -1" = Table.ReplaceValue(#"Replaced X with 1","","-1",Replacer.ReplaceValue,{"injury", "dead", "missing", "on_duty", "Column13"}),
    #"Replaced Y with 1" = Table.ReplaceValue(#"Replaced Null with -1","Y","1",Replacer.ReplaceText,{"on_duty", "Column13"}),
    #"Replaced N with 0" = Table.ReplaceValue(#"Replaced Y with 1","N","0",Replacer.ReplaceText,{"on_duty", "Column13"}),
    #"Renamed Rest of Columns" = Table.RenameColumns(#"Replaced N with 0",{{"Column12", "date_of_death"}, {"Column13", "incapacitated"}, {"Column14", "duty_hours"}, {"Column15", "accident_type"}, {"Column16", "resulting_injury"}, {"Column17", "body_part"}, {"Column18", "activity"}, {"Column19", "location"}, {"Column20", "equipment_involved"}, {"Column21", "equipment_part"}, {"Column22", "years_in_industy"}, {"Column23", "months_in_industry"}, {"Column24", "years_with_company"}, {"Column25", "months_with_company"}, {"Column26", "years_present_job"}, {"Column27", "months_present_job"}, {"Column28", "years_w_vessel_facility"}, {"Column29", "months_w_vessel_facility"}, {"Column30", "employer_ipn"}, {"Column31", "employer_name"}, {"Column32", "nec_accident_type"}, {"Column33", "sp"}}),
    #"Changed to Numbers" = Table.TransformColumnTypes(#"Renamed Rest of Columns",{{"injury", Int64.Type}, {"dead", Int64.Type}, {"missing", Int64.Type}, {"on_duty", Int64.Type}, {"incapacitated", Int64.Type}})
in
    #"Changed to Numbers"