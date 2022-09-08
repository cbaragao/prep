// Author: Chris Aragao
// Date: 9.7.2022
// Purpose: Documentation for Power Query on mv70.txt file
// Notes: Filepath is just a placeholder for the file path for the text document

// CHANGELOG
//----------------
// 9.7.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "mv70.txt"),[Delimiter="	", Columns=14, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", type text}, {"Column7", Int64.Type}, {"Column8", Int64.Type}, {"Column9", Int64.Type}, {"Column10", type text}, {"Column11", type text}, {"Column12", type text}, {"Column13", type text}, {"Column14", Int64.Type}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "mpcaseno"}, {"Column2", "cif_suppl_rec_type"}, {"Column3", "cif_num_sup_rec"}, {"Column4", "cif_num_pen_mat_resp"}, {"Column5", "mvcn"}, {"Column6", "cfrusc"}, {"Column7", "statpen"}, {"Column8", "penasses"}, {"Column9", "penpaid"}, {"Column10", "resstat"}, {"Column14", "pind"}}),
    #"Merged Date Cols" = Table.CombineColumns(#"Renamed Columns",{"Column12", "Column11", "Column13"},Combiner.CombineTextByDelimiter(" ", QuoteStyle.None),"vcdate")
in
    #"Merged Date Cols"