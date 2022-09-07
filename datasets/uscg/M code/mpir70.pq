// Author: Chris Aragao
// Date: 9.4.2022
// Purpose: Documentation for Power Query on mpir70.txt file
// Notes: Filepath is just a placeholder for the file path for the text file
//        MPIR70.txt and MPIR80.txt were appended together

// CHANGELOG
//----------------
// 9.4.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "mpir70.txt"),[Delimiter="	", Columns=43, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", Int64.Type}, {"Column6", Int64.Type}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type text}, {"Column11", type text}, {"Column12", type text}, {"Column13", type text}, {"Column14", type text}, {"Column15", type text}, {"Column16", type text}, {"Column17", type text}, {"Column18", type text}, {"Column19", type text}, {"Column20", Int64.Type}, {"Column21", type text}, {"Column22", Int64.Type}, {"Column23", Int64.Type}, {"Column24", type text}, {"Column25", type text}, {"Column26", Int64.Type}, {"Column27", type text}, {"Column28", Int64.Type}, {"Column29", type text}, {"Column30", Int64.Type}, {"Column31", type text}, {"Column32", type text}, {"Column33", type text}, {"Column34", type text}, {"Column35", type text}, {"Column36", type text}, {"Column37", Int64.Type}, {"Column38", Int64.Type}, {"Column39", Int64.Type}, {"Column40", type text}, {"Column41", type text}, {"Column42", Int64.Type}, {"Column43", Int64.Type}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "caseno"}, {"Column2", "cg_district"}, {"Column3", "cg_unit"}, {"Column4", "pcn"}, {"Column5", "incident_year"}, {"Column6", "pind"}, {"Column43", "qtr"}, {"Column42", "year"}, {"Column41", "nrcnumber"}, {"Column40", "notification"}, {"Column39", "tcost"}, {"Column38", "expend"}, {"Column37", "ceiling"}, {"Column36", "ptype"}, {"Column35", "pnum"}, {"Column34", "removal_party"}, {"Column33", "act"}, {"Column32", "state"}, {"Column31", "city"}, {"Column30", "long"}, {"Column29", "longind"}, {"Column28", "lat"}, {"Column27", "latind"}, {"Column26", "rmile"}, {"Column25", "wtrbd"}, {"Column24", "casref"}, {"Column23", "stime"}, {"Column19", "dtime"}, {"Column18", "rtime"}, {"Column14", "reported_by"}, {"Column13", "valid"}, {"Column7", "port_code"}, {"Column8", "osc"}, {"Column9", "epa"}}),
    #"Trimmed Text" = Table.TransformColumns(#"Renamed Columns",{{"cg_unit", Text.Trim, type text}}),
    #"Merged cdate" = Table.CombineColumns(#"Trimmed Text",{"Column10", "Column11", "Column12"},Combiner.CombineTextByDelimiter("-", QuoteStyle.None),"cdate"),
    #"Merged rdate" = Table.CombineColumns(#"Merged cdate",{"Column17", "Column16", "Column15"},Combiner.CombineTextByDelimiter("-", QuoteStyle.None),"rdate"),
    #"Merged sdate" = Table.CombineColumns(Table.TransformColumnTypes(#"Merged rdate", {{"Column20", type text}, {"Column22", type text}}, "en-US"),{"Column20", "Column21", "Column22"},Combiner.CombineTextByDelimiter("-", QuoteStyle.None),"sdate"),
    #"Changed cdate & rdate & sdate to date" = Table.TransformColumnTypes(#"Merged sdate",{{"cdate", type date},{"sdate", type date}, {"rdate", type date}}),
    #"Replaced Errors in dates" = Table.ReplaceErrorValues(#"Changed cdate & rdate & sdate to date", {{"rdate", null}, {"sdate", null}, {"cdate", null}}),
    #"Calc latitude" = Table.AddColumn(#"Replaced Errors in dates", "latitude", each fnConvertLatLong([lat], 0.001, [latind])),
    #"Calc longitude" = Table.AddColumn(#"Calc latitude", "longitude", each fnConvertLatLong([long], 0.001, [longind])),
    #"Removed Other Columns" = Table.SelectColumns(#"Calc longitude",{"caseno", "cg_district", "cg_unit", "pcn", "incident_year", "pind", "port_code", "osc", "epa", "cdate", "valid", "reported_by", "rdate", "rtime", "dtime", "sdate", "stime", "casref", "wtrbd", "rmile", "city", "state", "act", "removal_party", "pnum", "ptype", "ceiling", "expend", "tcost", "notification", "nrcnumber", "year", "qtr", "latitude", "longitude"})
in
    #"Removed Other Columns"