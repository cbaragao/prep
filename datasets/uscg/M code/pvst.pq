// Author: Chris Aragao
// Date: 9.2.2022
// Purpose: Documentation for Power Query on pvst.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 9.2.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(
        File.Contents(FILEPATH & "pvst.txt"),
        [Delimiter="	", Columns=16, Encoding=1252, QuoteStyle=QuoteStyle.None]
    ),
    #"Changed Type" = 
        Table.TransformColumnTypes(
            Source,
            {
                {"Column1", type text}, 
                {"Column2", type text}, 
                {"Column3", type text}, 
                {"Column4", type text}, 
                {"Column5", Int64.Type}, 
                {"Column6", type text}, 
                {"Column7", type text}, 
                {"Column8", type text}, 
                {"Column9", type text}, 
                {"Column10", type text}, 
                {"Column11", type text}, 
                {"Column12", type text}, 
                {"Column13", type text}, 
                {"Column14", Int64.Type}, 
                {"Column15", type text}, 
                {"Column16", type text}
            }
    ),
    #"Renamed Columns" = 
        Table.RenameColumns(
            #"Changed Type",
            {
                {"Column1", "mpcase"}, 
                {"Column2", "vessel_name"}, 
                {"Column3", "vessel_id"}, 
                {"Column4", "vessel_flag"}, 
                {"Column5", "num_pollutants"}, 
                {"Column6", "operation"}, 
                {"Column7", "violation_report_num"}, 
                {"Column8", "vessel_key"}, 
                {"Column9", "penalty_action"}, 
                {"Column10", "primary_cause"}, 
                {"Column11", "secondary_cause"}, 
                {"Column12", "contributing_factor_1"}, 
                {"Column13", "contributing_factor_2"}, 
                {"Column14", "supplement_id"}, 
                {"Column15", "service"}, 
                {"Column16", "sp"}
            }
        )
in
    #"Renamed Columns"