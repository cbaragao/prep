// Author: Chris Aragao
// Date: 9.7.2022
// Purpose: Documentation for Power Query on mprn70.txt file
// Notes: Filepath is just a placeholder for the file path for the text document

// CHANGELOG
//----------------
// 9.7.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "mprn70.txt"),[Delimiter="	", Columns=15, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", type text}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type text}, {"Column11", type text}, {"Column12", type text}, {"Column13", type text}, {"Column14", type text}, {"Column15", Int64.Type}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "rncaseno"}, {"Column2", "cif_suppl_rec_type"}, {"Column3", "cif_num_sup_rec"}, {"Column4", "rnver"}, {"Column5", "rnclass"}, {"Column9", "runtime"}, {"Column10", "rnadm"}, {"Column11", "rnrem"}, {"Column12", "rninv"}, {"Column13", "rnspv"}, {"Column14", "rnmon"}, {"Column15", "pind"}}),
    #"Merged date cols" = Table.CombineColumns(#"Renamed Columns",{"Column7", "Column6", "Column8"},Combiner.CombineTextByDelimiter("/", QuoteStyle.None),"rnndate"),
    #"Replaced blanks with nulls" = Table.ReplaceValue(#"Merged date cols","//",null,Replacer.ReplaceValue,{"rnndate"}),
    #"Changed date col to date" = Table.TransformColumnTypes(#"Replaced blanks with nulls",{{"rnndate", type date}})
in
    #"Changed date col to date"