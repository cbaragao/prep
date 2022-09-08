// Author: Chris Aragao
// Date: 9.7.2022
// Purpose: Documentation for appending the mv70 and mv80 with cleaning

// CHANGELOG
//----------------
// 9.7.2022: Initial documentation provided.

let
    Source = Table.Combine({mv70, mv80}),
    #"Replaced B with Boat" = Table.ReplaceValue(Source,"B","Boat",Replacer.ReplaceValue,{"cif_suppl_rec_type"}),
    #"Replaced F with Facility" = Table.ReplaceValue(#"Replaced B with Boat","F","Facility",Replacer.ReplaceValue,{"cif_suppl_rec_type"}),
    #"Merged r status" = Table.NestedJoin(#"Replaced F with Facility", {"resstat"}, mv_resolution_status, {"code"}, "mv_resolution_status", JoinKind.LeftOuter),
    #"Expanded mv_resolution_status" = Table.ExpandTableColumn(#"Merged r status", "mv_resolution_status", {"resolution_status_text"}, {"resolution_status_text"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Expanded mv_resolution_status",{"mpcaseno", "cif_suppl_rec_type", "cif_num_sup_rec", "cif_num_pen_mat_resp", "mvcn", "cfrusc", "statpen", "penasses", "penpaid", "resstat", "resolution_status_text", "vcdate", "pind"})
in
    #"Reordered Columns"