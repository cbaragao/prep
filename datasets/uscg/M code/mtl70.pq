// Author: Chris Aragao
// Date: 9.6.2022
// Purpose: Documentation for Power Query on mtl70.txt file
// Notes: Filepath is just a placeholder for the file path for the text file
//        MTIL70.txt and MTIL80.txt were appended together

// CHANGELOG
//----------------
// 9.6.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "mtl70.txt"),[Delimiter="	", Columns=13, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", type text}, {"Column7", type number}, {"Column8", type number}, {"Column9", type number}, {"Column10", type number}, {"Column11", type number}, {"Column12", type text}, {"Column13", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "mtlcaseno"}, {"Column2", "cif_suppl_rec_type"}, {"Column3", "cif_num_sup_rec"}, {"Column4", "cif_num_pen_mat_resp"}, {"Column5", "chris"}, {"Column6", "chrisgp"}, {"Column7", "totpot"}, {"Column8", "spillout"}, {"Column9", "recovout"}, {"Column10", "spiltin"}, {"Column11", "recovin"}, {"Column12", "units"}, {"Column13", "pind"}})
in
    #"Renamed Columns"