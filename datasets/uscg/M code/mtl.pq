// Author: Chris Aragao
// Date: 9.6.2022
// Purpose: Documentation for Power Query on append of MTL70 and MT80 files and cleaning


// CHANGELOG
//----------------
// 9.6.2022: Initial documentation provided.


let
    Source = Table.Combine({mtl70, mtl80}),
    #"Replaced B with Boat" = Table.ReplaceValue(Source,"B","Boat",Replacer.ReplaceText,{"cif_suppl_rec_type"}),
    #"Replaced F with Facility" = Table.ReplaceValue(#"Replaced B with Boat","F","Facility",Replacer.ReplaceText,{"cif_suppl_rec_type"}),
    #"Merged chris codes" = Table.NestedJoin(#"Replaced F with Facility", {"chris"}, mtl_chris_codes, {"chris_code"}, "mtl_chris_codes", JoinKind.LeftOuter),
    #"Expanded mtl_chris_codes" = Table.ExpandTableColumn(#"Merged chris codes", "mtl_chris_codes", {"substance_name_1", "substance_name_2", "substance_name_3"}, {"chris_code.substance_name_1", "chris_code.substance_name_2", "chris_code.substance_name_3"}),
    #"Merged chris groups" = Table.NestedJoin(#"Expanded mtl_chris_codes", {"chrisgp"}, mtl_chris_group, {"code"}, "mtl_chris_group", JoinKind.LeftOuter),
    #"Expanded mtl_chris_group" = Table.ExpandTableColumn(#"Merged chris groups", "mtl_chris_group", {"chris_group_text"}, {"chris_group_text"}),
    #"Merged units" = Table.NestedJoin(#"Expanded mtl_chris_group", {"units"}, mtl_units, {"code"}, "mtl_units", JoinKind.LeftOuter),
    #"Expanded mtl_units" = Table.ExpandTableColumn(#"Merged units", "mtl_units", {"unit_text"}, {"unit_text"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Expanded mtl_units",{"mtlcaseno", "cif_suppl_rec_type", "cif_num_sup_rec", "cif_num_pen_mat_resp", "chris", "chris_code.substance_name_3", "chris_code.substance_name_2", "chris_code.substance_name_1", "chrisgp", "chris_group_text", "totpot", "spillout", "recovout", "spiltin", "recovin", "units", "unit_text", "pind"})
in
    #"Reordered Columns"