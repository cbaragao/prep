// Author: Chris Aragao
// Date: 9.6.2022
// Purpose: Documentation for Power Query on mpsf80.txt file
// Notes: Filepath is just a placeholder for the file path for the text document

// CHANGELOG
//----------------
// 9.6.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "mpsf80.txt"),[Delimiter="	", Columns=17, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", type text}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type text}, {"Column11", type text}, {"Column12", type text}, {"Column13", type text}, {"Column14", type text}, {"Column15", type text}, {"Column16", type text}, {"Column17", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "scaseno"}, {"Column2", "cif_suppl_rec_type"}, {"Column3", "cif_num_sup_rec"}, {"Column4", "sver"}, {"Column5", "srcename"}, {"Column6", "srcied"}, {"Column7", "srcecode"}, {"Column8", "ownclass"}, {"Column9", "crcetype"}, {"Column10", "use"}, {"Column11", "oper"}, {"Column12", "penact"}, {"Column13", "primc"}, {"Column14", "seconc"}, {"Column15", "contrib1"}, {"Column16", "contrib2"}, {"Column17", "pind"}})
in
    #"Renamed Columns"