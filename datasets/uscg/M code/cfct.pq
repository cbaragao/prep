// Author: Chris Aragao
// Date: 8.31.2022
// Purpose: Documentation for Power Query on cfct.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 8.31.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "cfct.txt"),[Delimiter="	", Columns=42, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Renamed Columns" = Table.RenameColumns(Source,{{"Column1", "mccase"}, {"Column2", "subject"}, {"Column3", "intact_dam_cond"}, {"Column4", "cause"}, {"Column5", "special_cir_1"}, {"Column6", "special_cir_2"}, {"Column7", "special_cir_3"}, {"Column8", "special_cir_4"}, {"Column9", "special_cir_5"}, {"Column10", "req_intact_stab"}, {"Column11", "meet_intact_stab"}, {"Column12", "req_dam_stab"}, {"Column13", "meet_dam_stab"}, {"Column14", "spec_stab_info_avail"}, {"Column15", "spec_stab_info_fol"}, {"Column16", "pers_know_how_info"}, {"Column17", "num_comparts_flood"}, {"Column18", "use_flood_comp_1"}, {"Column19", "use_flood_comp_2"}, {"Column20", "use_flood_comp_3"}, {"Column21", "use_flood_comp_4"}, {"Column22", "use_flood_comp_5"}, {"Column23", "use_flood_comp_6"}, {"Column24", "use_flood_comp_7"}, {"Column25", "sink_hours"}, {"Column26", "sink_minutes"}, {"Column27", "manner_of_sink"}, {"Column28", "pre_cas_drafts_fwd_1"}, {"Column29", "pre_cas_drafts_fwd_2"}, {"Column30", "pre_cas_fwd_units"}, {"Column31", "pre_cas_drafts_aft_1"}, {"Column32", "pre_cas_drafts_aft_2"}, {"Column33", "pre_cas_aft_units"}, {"Column34", "post_cas_drafts_fw_1"}, {"Column35", "post_cas_drafts_fw_2"}, {"Column36", "post_cas_fwd_units"}, {"Column37", "post_cas_drafts_af_1"}, {"Column38", "post_cas_drafts_af_2"}, {"Column39", "post_cas_aft_units"}, {"Column40", "page_key"}, {"Column41", "sup_for_fac"}, {"Column42", "sp"}}),
    #"Replaced Y with 1" = Table.ReplaceValue(#"Renamed Columns","Y","1",Replacer.ReplaceText,{"req_intact_stab", "meet_intact_stab", "req_dam_stab", "meet_dam_stab", "spec_stab_info_avail", "spec_stab_info_fol", "pers_know_how_info"}),
    #"Replaced N with 0" = Table.ReplaceValue(#"Replaced Y with 1","N","0",Replacer.ReplaceText,{"req_intact_stab", "meet_intact_stab", "req_dam_stab", "meet_dam_stab", "spec_stab_info_avail", "spec_stab_info_fol", "pers_know_how_info"}),
    #"Replaced Blank with -1" = Table.ReplaceValue(#"Replaced N with 0","","-1",Replacer.ReplaceValue,{"req_intact_stab", "meet_intact_stab", "req_dam_stab", "meet_dam_stab", "spec_stab_info_avail", "spec_stab_info_fol", "pers_know_how_info", "sup_for_fac"}),
    #"Replaced X with 1" = Table.ReplaceValue(#"Replaced Blank with -1","X","1",Replacer.ReplaceText,{"sup_for_fac"}),
    #"Merged Special Circumstances" = Table.CombineColumns(#"Replaced X with 1",{"special_cir_1", "special_cir_2", "special_cir_3", "special_cir_4", "special_cir_5"},Combiner.CombineTextByDelimiter(",", QuoteStyle.None),"special_circumstances"),
    #"Replaced Multiple Commas on SC" = Table.ReplaceValue(#"Merged Special Circumstances",",,","",Replacer.ReplaceText,{"special_circumstances", "req_intact_stab", "meet_intact_stab", "req_dam_stab", "meet_dam_stab"}),
    #"Merged Flooded Compartments" = Table.CombineColumns(#"Replaced Multiple Commas on SC",{"use_flood_comp_1", "use_flood_comp_2", "use_flood_comp_3", "use_flood_comp_4", "use_flood_comp_5", "use_flood_comp_6", "use_flood_comp_7"},Combiner.CombineTextByDelimiter(",", QuoteStyle.None),"use_flooded_compartments"),
    #"Replaced Multi Commas on Cpmts" = Table.ReplaceValue(#"Merged Flooded Compartments",",,","",Replacer.ReplaceText,{"use_flooded_compartments"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Replaced Multi Commas on Cpmts",{{"page_key", Int64.Type}, {"sup_for_fac", Int64.Type}, {"post_cas_drafts_af_2", Int64.Type}, {"post_cas_drafts_af_1", Int64.Type}, {"post_cas_drafts_fw_2", Int64.Type}, {"post_cas_drafts_fw_1", Int64.Type}, {"pre_cas_drafts_aft_2", Int64.Type}, {"pre_cas_drafts_aft_1", Int64.Type}, {"pre_cas_drafts_fwd_2", Int64.Type}, {"pre_cas_drafts_fwd_1", Int64.Type}, {"sink_hours", Int64.Type}, {"num_comparts_flood", Int64.Type}, {"pers_know_how_info", Int64.Type}, {"spec_stab_info_fol", Int64.Type}, {"spec_stab_info_avail", Int64.Type}, {"meet_dam_stab", Int64.Type}, {"req_dam_stab", Int64.Type}, {"meet_intact_stab", Int64.Type}, {"req_intact_stab", Int64.Type}})
in
    #"Changed Type"