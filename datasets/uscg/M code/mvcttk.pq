// Author: Chris Aragao
// Date: 9.3.2022
// Purpose: Documentation for Power Query on mvcttk.txt file
// Notes: Filepath is just a placeholder for the file path for the text document

// CHANGELOG
//----------------
// 9.2.2022: Initial documentation provided.


(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "mvcttk.txt"),[Delimiter="	", Columns=33, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Renamed Columns" = Table.RenameColumns(Source,{{"Column1", "mvcase"}, {"Column2", "initiating_unit"}, {"Column3", "initiating_district"}, {"Column4", "controlling_unit"}, {"Column5", "case_start_date"}, {"Column6", "final_action"}, {"Column7", "action_unit"}, {"Column8", "action_date"}, {"Column9", "originating_program"}, {"Column10", "party_key"}, {"Column11", "party_role"}, {"Column12", "vessel_id"}, {"Column13", "facility_key"}, {"Column14", "involved_subject"}, {"Column15", "settled_amount"}, {"Column16", "paid_amount"}, {"Column17", "installment_payments"}, {"Column18", "board_ind"}, {"Column19", "case_action_code"}, {"Column20", "case_detachment"}, {"Column21", "case_unit"}, {"Column22", "total_assessed_amount"}, {"Column23", "dismiss_warn_ind"}, {"Column24", "case_closed_ind"}, {"Column25", "criminal_case_ind"}, {"Column26", "prelim_assessed_penalty"}, {"Column27", "refer_us_atty"}, {"Column28", "warning_letter"}, {"Column29", "subject_name"}, {"Column30", "subject_vin_fin"}, {"Column31", "flag"}, {"Column32", "service"}, {"Column33", "sp"}}),
    #"Trimmed Text" = Table.TransformColumns(#"Renamed Columns",{{"paid_amount", Text.Trim, type text}, {"total_assessed_amount", Text.Trim, type text}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Trimmed Text",{{"paid_amount", type number}, {"total_assessed_amount", type number}}),
    #"Replaced X with 1" = Table.ReplaceValue(#"Changed Type","X","1",Replacer.ReplaceValue,{"involved_subject", "dismiss_warn_ind", "case_closed_ind", "criminal_case_ind", "prelim_assessed_penalty", "refer_us_atty", "warning_letter"}),
    #"Replaced Blank with -1" = Table.ReplaceValue(#"Replaced X with 1","","-1",Replacer.ReplaceValue,{"involved_subject", "dismiss_warn_ind", "case_closed_ind", "criminal_case_ind", "prelim_assessed_penalty", "refer_us_atty", "warning_letter"}),
    #"Changed Type to Number" = Table.TransformColumnTypes(#"Replaced Blank with -1",{{"dismiss_warn_ind", Int64.Type}, {"case_closed_ind", Int64.Type}, {"criminal_case_ind", Int64.Type}, {"prelim_assessed_penalty", Int64.Type}, {"refer_us_atty", Int64.Type}, {"warning_letter", Int64.Type}, {"involved_subject", Int64.Type}})
in
    #"Changed Type to Number"