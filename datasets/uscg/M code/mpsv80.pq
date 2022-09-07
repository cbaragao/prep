// Author: Chris Aragao
// Date: 9.6.2022
// Purpose: Documentation for Power Query on mpsv80.txt file
// Notes: Filepath is just a placeholder for the file path for the text document

// CHANGELOG
//----------------
// 9.6.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "mpsv80.txt"),[Delimiter="	", Columns=21, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", type text}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type text}, {"Column11", type text}, {"Column12", type text}, {"Column13", type text}, {"Column14", type text}, {"Column15", type text}, {"Column16", type text}, {"Column17", type text}, {"Column18", type text}, {"Column19", type text}, {"Column20", type text}, {"Column21", type text}}),
       #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "scaseno"}, {"Column2", "cif_suppl_rec_type"}, {"Column3", "cif_num_sup_rec"}, {"Column4", "sver"}, {"Column5", "vsname"}, {"Column6", "vstype"}, {"Column7", "vsstyp"}, {"Column8", "vin1"}, {"Column9", "vin2"}, {"Column10", "vin3"}, {"Column11", "vin4"}, {"Column12", "vin5"}, {"Column13", "csign"}, {"Column14", "flag"}, {"Column15", "oper"}, {"Column16", "penact"}, {"Column17", "primc"}, {"Column18", "seconc"}, {"Column19", "contrib1"}, {"Column20", "contrib2"}, {"Column21", "pind"}})
in
    #"Renamed Columns"