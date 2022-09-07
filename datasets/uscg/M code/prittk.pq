// Author: Chris Aragao
// Date: 9.3.2022
// Purpose: Documentation for Power Query on prittk.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 9.3.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "prittk.txt"),[Delimiter="	", Columns=37, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type date}, {"Column5", type text}, {"Column6", type text}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type text}, {"Column11", type text}, {"Column12", type text}, {"Column13", type text}, {"Column14", type text}, {"Column15", Int64.Type}, {"Column16", Int64.Type}, {"Column17", type text}, {"Column18", Int64.Type}, {"Column19", type text}, {"Column20", type text}, {"Column21", type text}, {"Column22", type text}, {"Column23", type text}, {"Column24", type text}, {"Column25", type text}, {"Column26", type text}, {"Column27", type text}, {"Column28", type text}, {"Column29", type text}, {"Column30", type text}, {"Column31", type text}, {"Column32", type text}, {"Column33", type text}, {"Column34", type text}, {"Column35", type text}, {"Column36", type text}, {"Column37", type text}}),
    #"Removed Internal Spaces" = Table.ReplaceValue(#"Changed Type"," ","",Replacer.ReplaceText,{"Column20"}),
    #"Changed Type to Number" = Table.TransformColumnTypes(#"Removed Internal Spaces",{{"Column20", type number}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type to Number",{{"Column1", "mpcase"}, {"Column2", "unit"}, {"Column3", "on_scene_coordinator"}, {"Column4", "occurrence_date"}, {"Column5", "nearest_city"}, {"Column6", "nearest_state"}, {"Column7", "epa_region"}, {"Column8", "affected_waterbody"}, {"Column9", "mccase"}, {"Column10", "date_reported"}, {"Column11", "clean_up_status"}, {"Column12", "num_vessels_involved"}, {"Column13", "num_facilities_involved"}, {"Column14", "date_closed"}, {"Column15", "time_of_spill"}, {"Column16", "river_mile"}, {"Column17", "latitude_direction"}, {"Column18", "latitude_value"}, {"Column19", "longitude_direction"}, {"Column20", "longitude_value"}, {"Column21", "spill_removal_party"}, {"Column22", "inv_rep_validated"}, {"Column23", "report_close_to_file"}, {"Column24", "project_number"}, {"Column25", "project_type"}, {"Column26", "known_date"}, {"Column27", "auth_ceiling_cost"}, {"Column28", "total_cost"}, {"Column29", "funds_expended"}, {"Column30", "num_cg_resp_reports"}, {"Column31", "reported_by"}, {"Column32", "subject"}, {"Column33", "nrc_notification"}, {"Column34", "nrc_ref_case"}, {"Column35", "sp"}}),
    #"Calculate Latitude" = Table.AddColumn(#"Renamed Columns", "latitude", each fnConvertLatLong([latitude_value], 0.001, [latitude_direction])),
    #"Calculate Longitude" = Table.AddColumn(#"Calculate Latitude", "longitude", each fnConvertLatLong([longitude_value], 0.001, [longitude_direction])),
    #"Removed Lat/Long Cols" = Table.RemoveColumns(#"Calculate Longitude",{"latitude_direction", "latitude_value", "longitude_direction", "longitude_value"}),
    #"Replaced E with Estimated" = Table.ReplaceValue(#"Removed Lat/Long Cols","E","estimated",Replacer.ReplaceText,{"known_date"}),
    #"Replaced K with Known" = Table.ReplaceValue(#"Replaced E with Estimated","K","known",Replacer.ReplaceText,{"known_date"}),
    #"Removed 2 Blank Columns" = Table.RemoveColumns(#"Replaced K with Known",{"Column36", "Column37"}),
    #"Replaced Lat/Long Errors w Null" = Table.ReplaceErrorValues(#"Removed 2 Blank Columns", {{"latitude", null}, {"longitude", null}}),
    #"Reordered Columns" = Table.ReorderColumns(#"Replaced Lat/Long Errors w Null",{"mpcase", "unit", "on_scene_coordinator", "occurrence_date", "nearest_city", "nearest_state", "epa_region", "affected_waterbody", "mccase", "date_reported", "clean_up_status", "num_vessels_involved", "num_facilities_involved", "date_closed", "river_mile", "spill_removal_party", "inv_rep_validated", "report_close_to_file", "project_number", "project_type", "known_date", "auth_ceiling_cost", "total_cost", "funds_expended", "num_cg_resp_reports", "reported_by", "subject", "nrc_notification", "nrc_ref_case", "latitude", "longitude", "time_of_spill", "sp"})
in
    #"Reordered Columns"