// Author: Chris Aragao
// Date: 9.6.2022
// Purpose: Documentation for appending the mpsf70 and mpsf80 with cleaning

// CHANGELOG
//----------------
// 9.6.2022: Initial documentation provided.

let
    Source = Table.Combine({mpsf70, mpsf80}),
    #"Replaced B with Boat" = Table.ReplaceValue(Source,"B","Boat",Replacer.ReplaceValue,{"cif_suppl_rec_type"}),
    #"Replaced F with Facility" = Table.ReplaceValue(#"Replaced B with Boat","F","Facility",Replacer.ReplaceValue,{"cif_suppl_rec_type"}),
    #"Merged sources" = Table.NestedJoin(#"Replaced F with Facility", {"srcecode"}, mpsf_source_codes, {"code"}, "mpsf_source_codes", JoinKind.LeftOuter),
    #"Expanded mpsf_source_codes" = Table.ExpandTableColumn(#"Merged sources", "mpsf_source_codes", {"source_code_text"}, {"source_code_text"}),
    #"Merged ownership" = Table.NestedJoin(#"Expanded mpsf_source_codes", {"ownclass"}, mpsf_ownership_classes, {"code"}, "mpsf_ownership_classes", JoinKind.LeftOuter),
    #"Expanded mpsf_ownership_classes" = Table.ExpandTableColumn(#"Merged ownership", "mpsf_ownership_classes", {"ownership_class_text"}, {"ownership_class_text"}),
    #"Merged types" = Table.NestedJoin(#"Expanded mpsf_ownership_classes", {"crcetype"}, mpsf_types, {"code"}, "mpsf_types", JoinKind.LeftOuter),
    #"Expanded mpsf_types" = Table.ExpandTableColumn(#"Merged types", "mpsf_types", {"type_text"}, {"type_text"}),
    #"Merged uses" = Table.NestedJoin(#"Expanded mpsf_types", {"use"}, mpsf_uses, {"code"}, "mpsf_uses", JoinKind.LeftOuter),
    #"Expanded mpsf_uses" = Table.ExpandTableColumn(#"Merged uses", "mpsf_uses", {"use_text"}, {"use_text"}),
    #"Merged operations" = Table.NestedJoin(#"Expanded mpsf_uses", {"oper"}, mpsf_operations, {"code"}, "mpsf_operations", JoinKind.LeftOuter),
    #"Expanded mpsf_operations" = Table.ExpandTableColumn(#"Merged operations", "mpsf_operations", {"operation_text"}, {"operation_text"}),
    #"Merged primary causes" = Table.NestedJoin(#"Expanded mpsf_operations", {"primc"}, mpsf_primary_causes, {"code"}, "mpsf_primary_causes", JoinKind.LeftOuter),
    #"Expanded mpsf_primary_causes" = Table.ExpandTableColumn(#"Merged primary causes", "mpsf_primary_causes", {"primary_cause_text"}, {"primary_cause_text"}),
    #"Merged secondary causes" = Table.NestedJoin(#"Expanded mpsf_primary_causes", {"seconc"}, mpsf_secondary_causes, {"code"}, "mpsf_secondary_causes", JoinKind.LeftOuter),
    #"Expanded mpsf_secondary_causes" = Table.ExpandTableColumn(#"Merged secondary causes", "mpsf_secondary_causes", {"secondary_cause_text"}, {"secondary_cause_text"}),
    #"Merged first contributing factor" = Table.NestedJoin(#"Expanded mpsf_secondary_causes", {"contrib1"}, mpsf_contributing_factors, {"code"}, "mpsf_contributing_factors", JoinKind.LeftOuter),
    #"Expanded mpsf_contributing_factors" = Table.ExpandTableColumn(#"Merged first contributing factor", "mpsf_contributing_factors", {"contributing_factor_text"}, {"factor1.contributing_factor_text"}),
    #"Merged second contributing factor" = Table.NestedJoin(#"Expanded mpsf_contributing_factors", {"contrib2"}, mpsf_contributing_factors, {"code"}, "mpsf_contributing_factors", JoinKind.LeftOuter),
    #"Expanded mpsf_contributing_factors1" = Table.ExpandTableColumn(#"Merged second contributing factor", "mpsf_contributing_factors", {"contributing_factor_text"}, {"factor2.contributing_factor_text"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Expanded mpsf_contributing_factors1",{"scaseno", "cif_suppl_rec_type", "cif_num_sup_rec", "sver", "srcename", "srcied", "srcecode", "source_code_text", "ownclass", "ownership_class_text", "crcetype", "type_text", "use", "use_text", "oper", "operation_text", "penact", "primc", "primary_cause_text", "seconc", "secondary_cause_text", "contrib1", "factor1.contributing_factor_text", "contrib2", "factor2.contributing_factor_text", "pind"})
in
    #"Reordered Columns"