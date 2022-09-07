// Author: Chris Aragao
// Date: 9.3.2022
// Purpose: Documentation for Power Query on vcas.txt file. ]
//          This file was normalized a little (4 separate tables).
//          Conditions & Causes; Stats; Location; Vessel          
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 9.3.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "vcas.txt"),[Delimiter="	", Columns=57, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", Int64.Type}, {"Column5", type date}, {"Column6", type text}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type text}, {"Column11", type text}, {"Column12", type text}, {"Column13", type text}, {"Column14", Int64.Type}, {"Column15", type text}, {"Column16", type number}, {"Column17", type text}, {"Column18", type text}, {"Column19", type text}, {"Column20", Int64.Type}, {"Column21", type text}, {"Column22", type text}, {"Column23", type text}, {"Column24", type text}, {"Column25", type text}, {"Column26", type text}, {"Column27", type text}, {"Column28", type text}, {"Column29", type text}, {"Column30", type text}, {"Column31", type text}, {"Column32", type text}, {"Column33", type text}, {"Column34", type text}, {"Column35", type text}, {"Column36", type text}, {"Column37", type text}, {"Column38", Int64.Type}, {"Column39", Int64.Type}, {"Column40", type text}, {"Column41", type text}, {"Column42", Int64.Type}, {"Column43", type text}, {"Column44", Int64.Type}, {"Column45", Int64.Type}, {"Column46", Int64.Type}, {"Column47", Int64.Type}, {"Column48", Int64.Type}, {"Column49", Int64.Type}, {"Column50", Int64.Type}, {"Column51", Int64.Type}, {"Column52", type text}, {"Column53", type text}, {"Column54", type text}, {"Column55", type text}, {"Column56", type text}, {"Column57", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "mccase"}, {"Column2", "vessel_id"}, {"Column3", "vessel_key"}, {"Column4", "num_vessels_damaged"}, {"Column5", "casualty_date"}, {"Column6", "period_day"}, {"Column7", "weather"}, {"Column8", "body_water"}, {"Column9", "lat_hemi"}, {"Column10", "lat"}, {"Column11", "long_hemi"}, {"Column12", "long"}, {"Column13", "report_type"}, {"Column14", "total_damage"}, {"Column15", "unit"}, {"Column16", "milepost"}, {"Column17", "entered_by"}, {"Column18", "wind_direction"}, {"Column19", "wind_speed"}, {"Column20", "involved_vessels"}, {"Column21", "primary_nature"}, {"Column22", "secondary_nature"}, {"Column23", "tertiary_nature"}, {"Column24", "primary_cause"}, {"Column25", "secondary_cause"}, {"Column26", "tertiary_cause"}, {"Column27", "fourth_cause"}, {"Column28", "fifth_cause"}, {"Column29", "sixth_cause"}, {"Column30", "sea_condition"}, {"Column31", "configuration"}, {"Column32", "vessel_name"}, {"Column33", "flag"}, {"Column34", "year_built"}, {"Column35", "service"}, {"Column36", "seaworthiness"}, {"Column37", "vessel_use"}, {"Column38", "length"}, {"Column39", "gross_tons"}, {"Column40", "hull"}, {"Column41", "prop"}, {"Column42", "horse_power"}, {"Column43", "design"}, {"Column44", "vessel_damage"}, {"Column45", "cargo_damage"}, {"Column46", "crew_death"}, {"Column47", "passenger_death"}, {"Column48", "total_death"}, {"Column49", "crew_injury"}, {"Column50", "passenger_injury"}, {"Column51", "total_injury"}, {"Column52", "vessel_status"}, {"Column53", "person_in_charge"}, {"Column54", "society"}, {"Column55", "operating_company"}, {"Column56", "pilot"}, {"Column57", "sp"}}),
    #"Removed Other Columns" = Table.SelectColumns(#"Renamed Columns",{"mccase", "vessel_id", "vessel_key", "body_water", "lat_hemi", "lat", "long_hemi", "long", "milepost"}),
    #"Trimmed Lat & Long Columns" = Table.TransformColumns(#"Removed Other Columns",{{"lat", Text.Trim, type text}, {"long", Text.Trim, type text}}),
    #"Split Lat by Space" = Table.SplitColumn(#"Trimmed Lat & Long Columns", "lat", Splitter.SplitTextByEachDelimiter({" "}, QuoteStyle.Csv, false), {"lat.1", "lat.2"}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Split Lat by Space",{{"lat.1", Int64.Type}, {"lat.2", type number}}),
    #"Split Long by Space" = Table.SplitColumn(#"Changed Type1", "long", Splitter.SplitTextByEachDelimiter({" "}, QuoteStyle.Csv, false), {"long.1", "long.2"}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Split Long by Space",{{"long.1", Int64.Type}, {"long.2", type number}}),
    #"Divided Lat Minutes by 60" = Table.TransformColumns(#"Changed Type2", {{"lat.2", each _ / 60, type number}}),
    #"Divided Long Minutes by 60" = Table.TransformColumns(#"Divided Lat Minutes by 60", {{"long.2", each _ / 60, type number}}),
    #"Added Lat Degrees + Minutes" = Table.AddColumn(#"Divided Long Minutes by 60", "lat", each [lat.1] + [lat.2], type number),
    #"Added Long Degrees + Minutes" = Table.AddColumn(#"Added Lat Degrees + Minutes", "long", each [long.1] + [long.2], type number),
    #"Calc Lat" = Table.AddColumn(#"Added Long Degrees + Minutes", "latitude_coordinate", each fnConvertLatLong([lat], 1, [lat_hemi])),
    #"Calc Long" = Table.AddColumn(#"Calc Lat", "longitude_coordinate", each fnConvertLatLong([long], 1, [long_hemi])),
    #"Choose Columns" = Table.SelectColumns(#"Calc Long",{"mccase", "vessel_id", "vessel_key", "body_water", "latitude_coordinate", "longitude_coordinate"})
in
    #"Choose Columns"