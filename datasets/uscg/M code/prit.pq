// Author: Chris Aragao
// Date: 9.2.2022
// Purpose: Documentation for Power Query on prit.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 9.2.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "prit.txt"),[Delimiter="	", Columns=37, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Renamed Columns" = Table.RenameColumns(Source,{{"Column1", "mpcase"}, {"Column2", "unit"}, {"Column3", "on_scene_agency"}, {"Column4", "occurrence_date"}, {"Column5", "city"}, {"Column6", "state"}, {"Column7", "epa_region"}, {"Column8", "waterbody"}, {"Column9", "mccase"}, {"Column10", "date_reported"}, {"Column11", "clean_up_status"}, {"Column12", "num_vessels_involved"}, {"Column13", "num_nonvessels_involved"}, {"Column14", "date_closed"}, {"Column15", "time_spilled"}, {"Column16", "river_mile"}, {"Column17", "lat_direction"}, {"Column18", "latitude"}, {"Column19", "long_dir"},{"Column20", "longitude"}, {"Column21", "spill_removal_party"}, {"Column22", "validated"}, {"Column23", "report_closed"}, {"Column24", "project_number"}, {"Column25", "project_type"}, {"Column26", "date_known"}, {"Column27", "authorized_ceiling_cost"}, {"Column28", "total_cost"}, {"Column29", "funds_expended"}, {"Column30", "num_cg_response_rpts"}, {"Column31", "time_spill_reported"}, {"Column32", "number_noncg_rpts"}, {"Column33", "reported_by"}, {"Column34", "cause_of_spill"}, {"Column35", "nrc_notified_unit"}, {"Column36", "nrc_case_num"}, {"Column37", "sp"}}),
    #"Replaced Blank with 0" = Table.ReplaceValue(#"Renamed Columns","","0",Replacer.ReplaceValue,{"latitude", "longitude"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Replaced Blank with 0",{{"time_spilled", type text}, {"river_mile", Int64.Type}, {"num_nonvessels_involved", Int64.Type}, {"date_closed", type date}, {"num_vessels_involved", Int64.Type}, {"date_reported", type date}, {"occurrence_date", type date}, {"latitude", Int64.Type}, {"longitude", Int64.Type}}),
    #"Calc Latitude" = Table.AddColumn(#"Changed Type", "lat", each fnConvertLatLong([latitude], 0.001, [lat_direction])),
    #"Calc Longitude" = Table.AddColumn(#"Calc Latitude", "long", each fnConvertLatLong([longitude], 0.001, [long_dir])),
    #"Changed Type of Remainder" = Table.TransformColumnTypes(
        #"Calc Longitude",
        {
            {"mpcase", type text}, 
            {"unit", type text}, 
            {"on_scene_agency", type text}, 
            {"city", type text}, 
            {"state", type text}, 
            {"epa_region", Int64.Type}, 
            {"waterbody", type text}, 
            {"mccase", type text}, 
            {"clean_up_status", type text}, 
            {"lat_direction", type text}, 
            {"long_dir", type text}, 
            {"spill_removal_party", type text}, 
            {"validated", type text}, 
            {"report_closed", type text}, 
            {"project_number", type text}, 
            {"project_type", type text}, 
            {"date_known", type text}, 
            {"authorized_ceiling_cost", Int64.Type}, 
            {"total_cost", Int64.Type}, 
            {"funds_expended", Int64.Type}, 
            {"num_cg_response_rpts", Int64.Type}, 
            {"time_spill_reported", Int64.Type}, 
            {"number_noncg_rpts", Int64.Type}, 
            {"reported_by", type text}, 
            {"cause_of_spill", type text}, 
            {"nrc_notified_unit", type text}, 
            {"nrc_case_num", type text}, 
            {"sp", type text},
            {"lat", type number}, 
            {"long", type number}
        }
    ),
    #"Replaced X with 1" = Table.ReplaceValue(#"Changed Type of Remainder","X","1",Replacer.ReplaceText,{"validated"}),
    #"Replaced Blank with -1" = Table.ReplaceValue(#"Replaced X with 1","","-1",Replacer.ReplaceValue,{"validated"}),
    #"Replaced K with Known" = Table.ReplaceValue(#"Replaced Blank with -1","K","known",Replacer.ReplaceText,{"date_known"}),
    #"Replaced E with Estimated" = Table.ReplaceValue(#"Replaced K with Known","E","estimated",Replacer.ReplaceText,{"date_known"}),
    #"Replaced U with Unknown" = Table.ReplaceValue(#"Replaced E with Estimated","U","unknown",Replacer.ReplaceText,{"date_known"}),
    #"Removed Other Columns" = Table.SelectColumns(#"Replaced U with Unknown",{"mpcase", "unit", "on_scene_agency", "occurrence_date", "city", "state", "epa_region", "waterbody", "mccase", "date_reported", "clean_up_status", "num_vessels_involved", "num_nonvessels_involved", "date_closed", "time_spilled", "river_mile", "spill_removal_party", "validated", "report_closed", "project_number", "project_type", "date_known", "authorized_ceiling_cost", "total_cost", "funds_expended", "num_cg_response_rpts", "time_spill_reported", "number_noncg_rpts", "reported_by", "cause_of_spill", "nrc_notified_unit", "nrc_case_num", "sp", "lat", "long"}),
    #"Changed Type of Validated" = Table.TransformColumnTypes(#"Removed Other Columns",{{"validated", Int64.Type}}),
    #"Reordered Columns" = Table.ReorderColumns(#"Changed Type of Validated",{"mpcase", "unit", "on_scene_agency", "occurrence_date", "city", "state", "epa_region", "waterbody", "mccase", "date_reported", "clean_up_status", "num_vessels_involved", "num_nonvessels_involved", "date_closed", "time_spilled", "river_mile", "spill_removal_party", "validated", "report_closed", "project_number", "project_type", "date_known", "authorized_ceiling_cost", "total_cost", "funds_expended", "num_cg_response_rpts", "time_spill_reported", "number_noncg_rpts", "reported_by", "cause_of_spill", "nrc_notified_unit", "nrc_case_num", "lat", "long", "sp"})
in
    #"Reordered Columns"