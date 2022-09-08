// Author: Chris Aragao
// Date: 9.7.2022
// Purpose: Documentation for Power Query append of mprn70 and and mprn80 after they are prepped

// CHANGELOG
//----------------
// 9.4.2022: Initial documentation provided.

let
    Source = Table.Combine({mprn70, mprn80}),
    #"Replaced N with NCGR" = Table.ReplaceValue(Source,"N","Non Coast Guard Response",Replacer.ReplaceValue,{"cif_suppl_rec_type"}),
    #"Merged Queries" = Table.NestedJoin(#"Replaced N with NCGR", {"rnclass"}, mprn_class, {"code"}, "mprn_class", JoinKind.LeftOuter),
    #"Expanded mprn_class" = Table.ExpandTableColumn(#"Merged Queries", "mprn_class", {"class_text"}, {"class_text"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Expanded mprn_class",{"rncaseno", "cif_suppl_rec_type", "cif_num_sup_rec", "rnver", "rnclass", "class_text", "rnndate", "runtime", "rnadm", "rnrem", "rninv", "rnspv", "rnmon", "pind"})
in
    #"Reordered Columns"