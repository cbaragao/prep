// Author: Chris Aragao
// Date: 9.4.2022
// Purpose: Documentation for Power Query append of mprc70 and and mprc80 after they are prepped

// CHANGELOG
//----------------
// 9.4.2022: Initial documentation provided.


let
    Source = Table.Combine({mprc70, mprc80}),
    #"Merged Queries" = Table.NestedJoin(Source, {"respres"}, mprc_resp_resources, {"code"}, "mprc_resp_resources", JoinKind.LeftOuter),
    #"Expanded mprc_resp_resources" = Table.ExpandTableColumn(#"Merged Queries", "mprc_resp_resources", {"resp_resource_text"}, {"resp_resource_text"}),
    #"Merged resp resources" = Table.NestedJoin(#"Expanded mprc_resp_resources", {"mpfres"}, mprc_mpf_resources, {"code"}, "mprc_mpf_resources", JoinKind.LeftOuter),
    #"Expanded mprc_mpf_resources" = Table.ExpandTableColumn(#"Merged resp resources", "mprc_mpf_resources", {"resource_text"}, {"resource_text"}),
    #"Merged mpf resources" = Table.NestedJoin(#"Expanded mprc_mpf_resources", {"mpflog"}, mprc_mpf_logistics, {"code"}, "mprc_mpf_logistics", JoinKind.LeftOuter),
    #"Expanded mprc_mpf_logistics" = Table.ExpandTableColumn(#"Merged mpf resources", "mprc_mpf_logistics", {"logistics_text"}, {"logistics_text"}),
    #"Merged mpf logistics" = Table.NestedJoin(#"Expanded mprc_mpf_logistics", {"mpfper"}, mprc_mpf_personnel, {"code"}, "mprc_mpf_personnel", JoinKind.LeftOuter),
    #"Expanded mprc_mpf_personnel" = Table.ExpandTableColumn(#"Merged mpf logistics", "mprc_mpf_personnel", {"personnel_text"}, {"personnel_text"}),
    #"Merged mpf personnel" = Table.NestedJoin(#"Expanded mprc_mpf_personnel", {"mpfenv"}, mprc_mpf_environmental, {"code"}, "mprc_mpf_environmental", JoinKind.LeftOuter),
    #"Expanded mprc_mpf_environmental" = Table.ExpandTableColumn(#"Merged mpf personnel", "mprc_mpf_environmental", {"environmental_text"}, {"environmental_text"}),
    #"Reordered Columns" = Table.ReorderColumns(
        #"Expanded mprc_mpf_environmental",
            {
                "racaseno", 
                "cif_suppl_rec_type", 
                "cif_num_sup_rec", 
                "cif_num_pen_mat_resp", 
                "year", 
                "qtr", 
                "dist", 
                "unit", 
                "rcver", 
                "rcndate", 
                "rcntime", 
                "respres", 
                "resp_resource_text", 
                "mpfres", 
                "resource_text",
                "mpflog", 
                "logistics_text",
                "mpfper", 
                "personnel_text",
                "mpfenv", 
                "environmental_text",
                "adm", 
                "rem", 
                "inv", 
                "spv", 
                "mon", 
                "pind"
            }
    )
in
    #"Reordered Columns"