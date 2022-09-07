// Author: Chris Aragao
// Date: 9.3.2022
// Purpose: Documentation for Power Query on mtkt.txt file
// Notes: Filepath is just a placeholder for the file path for the text document

// CHANGELOG
//----------------
// 9.3.2022: Initial documentation provided.


(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "mtkt.txt"),[Delimiter="	", Columns=27, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", type date}, {"Column7", type text}, {"Column8", type text}, {"Column9", type text}, {"Column10", type date}, {"Column11", type text}, {"Column12", type text}, {"Column13", type text}, {"Column14", type text}, {"Column15", type date}, {"Column16", type text}, {"Column17", type text}, {"Column18", type text}, {"Column19", type text}, {"Column20", Int64.Type}, {"Column21", Int64.Type}, {"Column22", type text}, {"Column23", type text}, {"Column24", type text}, {"Column25", type text}, {"Column26", type text}, {"Column27", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"Column1", "ticket_number"}, {"Column2", "reference_case"}, {"Column3", "unit"}, {"Column4", "subject"}, {"Column5", "val_ctf_ind"}, {"Column6", "val_ctf_dt"}, {"Column8", "forward_date"}, {"Column10", "appealed_date"}, {"Column11", "type"}, {"Column13", "nrc_case_number"}, {"Column14", "employer"}, {"Column15", "issue_date"}, {"Column16", "pursued_via"}, {"Column17", "ctf_key"}, {"Column19", "vin_fin_verified"}, {"Column20", "num_cities"}, {"Column21", "num_pollutants"}, {"Column22", "address_ind"}, {"Column23", "convert_now"}, {"Column24", "spec"}, {"Column25", "fwcpa_category"}, {"Column27", "sp"}}),
    #"Replaced V with Validated" = Table.ReplaceValue(#"Renamed Columns","V","validated",Replacer.ReplaceText,{"val_ctf_ind"}),
    #"Replaced C with Closed" = Table.ReplaceValue(#"Replaced V with Validated","C","closed",Replacer.ReplaceText,{"val_ctf_ind"}),
    #"Invoke fnReplaceBoolean on Forward" = Table.AddColumn(#"Replaced C with Closed", "forward_ind", each fnReplaceBoolean([Column7], "X", null)),
    #"Invoked fnReplaceBoolean on Appealed" = Table.AddColumn(#"Invoke fnReplaceBoolean on Forward", "appealed_ind", each fnReplaceBoolean([Column9], "X", null)),
    #"Replaced F with FWCPA" = Table.ReplaceValue(#"Invoked fnReplaceBoolean on Appealed","F","FWPCA",Replacer.ReplaceText,{"type"}),
    #"Replaced P with Pollution Prevention" = Table.ReplaceValue(#"Replaced F with FWCPA","P","POLLUTION PREVENTION",Replacer.ReplaceValue,{"type"}),
    #"Replaced B with Both" = Table.ReplaceValue(#"Replaced P with Pollution Prevention","B","BOTH",Replacer.ReplaceValue,{"type"}),
    #"Replaced M with Marine..." = Table.ReplaceValue(#"Replaced B with Both","M","MARINE SANITATION DEVICE",Replacer.ReplaceValue,{"type"}),
    #"Trimmed Text" = Table.TransformColumns(#"Replaced M with Marine...",{{"Column12", Text.Trim, type text}}),
    #"Replaced Null with -1" = Table.ReplaceValue(#"Trimmed Text",null,"-1",Replacer.ReplaceValue,{"Column12"}),
    #"Invoked fnReplaceBoolean on NRC" = Table.AddColumn(#"Replaced Null with -1", "nrc_notification", each fnReplaceBoolean([Column12], "Y", "N")),
    #"Invoked fnReplaceBoolean on Party" = Table.AddColumn(#"Invoked fnReplaceBoolean on NRC", "party_verified_ind", each fnReplaceBoolean([Column18], "V", null)),
    #"Invoked fnReplaceBoolean on Warning" = Table.AddColumn(#"Invoked fnReplaceBoolean on Party", "warning_ind", each fnReplaceBoolean([Column26], "X", null)),
    #"Removed Other Columns" = Table.SelectColumns(#"Invoked fnReplaceBoolean on Warning",{"ticket_number", "reference_case", "unit", "subject", "val_ctf_ind", "val_ctf_dt", "forward_date", "appealed_date", "type", "nrc_case_number", "employer", "issue_date", "pursued_via", "ctf_key", "vin_fin_verified", "num_cities", "num_pollutants", "address_ind", "convert_now", "spec", "fwcpa_category", "sp", "forward_ind", "appealed_ind", "nrc_notification", "party_verified_ind", "warning_ind"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Removed Other Columns",{"ticket_number", "reference_case", "unit", "subject", "val_ctf_ind", "val_ctf_dt", "forward_date", "appealed_date", "type", "nrc_case_number", "employer", "issue_date", "pursued_via", "ctf_key", "vin_fin_verified", "num_cities", "num_pollutants", "address_ind", "convert_now", "spec", "fwcpa_category", "forward_ind", "appealed_ind", "nrc_notification", "party_verified_ind", "warning_ind", "sp"}),
    #"Changed Types to Dates and Nums" = Table.TransformColumnTypes(#"Reordered Columns",{{"forward_ind", Int64.Type}, {"forward_date", type date}, {"appealed_ind", Int64.Type}, {"party_verified_ind", Int64.Type}, {"nrc_notification", Int64.Type}})
in
    #"Changed Types to Dates and Nums"