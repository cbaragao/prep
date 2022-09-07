// Author: Chris Aragao
// Date: 9.4.2022
// Purpose: Documentation for Power Query on mprc70.txt file
// Notes: Filepath is just a placeholder for the file path for the text file
//        MPRC70.txt and MPRC80.txt were appended together

// CHANGELOG
//----------------
// 9.4.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "mprc70.txt"),[Delimiter="	", Columns=24, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", Int64.Type}, {"Column6", Int64.Type}, {"Column7", type text}, {"Column8", Int64.Type}, {"Column9", type text}, {"Column10", Int64.Type}, {"Column11", type text}, {"Column12", Int64.Type}, {"Column13", Int64.Type}, {"Column14", Int64.Type}, {"Column15", Int64.Type}, {"Column16", Int64.Type}, {"Column17", Int64.Type}, {"Column18", Int64.Type}, {"Column19", Int64.Type}, {"Column20", Int64.Type}, {"Column21", Int64.Type}, {"Column22", Int64.Type}, {"Column23", Int64.Type}, {"Column24", Int64.Type}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "racaseno"}, {"Column2", "cif_suppl_rec_type"}, {"Column3", "cif_num_sup_rec"}, {"Column4", "cif_num_pen_mat_resp"}, {"Column5", "year"}, {"Column6", "qtr"}, {"Column7", "dist"}, {"Column8", "unit"}, {"Column9", "rcver"}, {"Column13", "rcntime"}, {"Column14", "respres"}, {"Column15", "mpfres"}, {"Column16", "mpflog"}, {"Column17", "mpfper"}, {"Column18", "mpfenv"}, {"Column19", "adm"}, {"Column20", "rem"}, {"Column21", "inv"}, {"Column22", "spv"}, {"Column23", "mon"}, {"Column24", "pind"}}),
    #"Merged date columns" = Table.CombineColumns(Table.TransformColumnTypes(#"Renamed Columns", {{"Column10", type text}, {"Column12", type text}}, "en-US"),{"Column10", "Column11", "Column12"},Combiner.CombineTextByDelimiter("-", QuoteStyle.None),"rcndate"),
    #"Changed date to date type" = Table.TransformColumnTypes(#"Merged date columns",{{"rcndate", type date}}),
    #"Replaced Errors in date with null" = Table.ReplaceErrorValues(#"Changed date to date type", {{"rcndate", null}})
in
    #"Replaced Errors in date with null"