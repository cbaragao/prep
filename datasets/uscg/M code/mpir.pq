// Author: Chris Aragao
// Date: 9.4.2022
// Purpose: Documentation for Power Query append of mpir70 and and mpir80 after they are prepped

// CHANGELOG
//----------------
// 9.4.2022: Initial documentation provided.


let
    Source = Table.Combine({mpir70, mpir80}),
    #"Replaced K" = Table.ReplaceValue(Source,"K","KNOWN",Replacer.ReplaceValue,{"dtime"}),
    #"Replaced E" = Table.ReplaceValue(#"Replaced K","E","ESTIMATED",Replacer.ReplaceValue,{"dtime"}),
    #"Replaced U" = Table.ReplaceValue(#"Replaced E","U","UNKNOWN",Replacer.ReplaceText,{"dtime"}),
    #"Merged Waterbody Definitions" = Table.NestedJoin(#"Replaced U", {"port_code"}, mpir_waterbody_codes, {"CODE"}, "waterbody_codes", JoinKind.LeftOuter),
    #"Expanded waterbody_codes" = Table.ExpandTableColumn(#"Merged Waterbody Definitions", "waterbody_codes", {"waterbody"}, {"waterbody"}),
    #"Merged reported by" = Table.NestedJoin(#"Expanded waterbody_codes", {"reported_by"}, mpir_reported_by, {"code"}, "mpir_reported_by", JoinKind.LeftOuter),
    #"Expanded mpir_reported_by" = Table.ExpandTableColumn(#"Merged reported by", "mpir_reported_by", {"reported_by_text"}, {"reported_by_text"}),
    #"Merged states" = Table.NestedJoin(#"Expanded mpir_reported_by", {"state"}, mpir_states_territories, {"code"}, "mpir_states_territories", JoinKind.LeftOuter),
    #"Expanded mpir_states_territories" = Table.ExpandTableColumn(#"Merged states", "mpir_states_territories", {"state_text"}, {"state_text"}),
    #"Merged cleanup actions" = Table.NestedJoin(#"Expanded mpir_states_territories", {"act"}, mpir_cleanup_actions, {"code"}, "mpir_cleanup_actions", JoinKind.LeftOuter),
    #"Expanded mpir_cleanup_actions" = Table.ExpandTableColumn(#"Merged cleanup actions", "mpir_cleanup_actions", {"clean_up_action"}, {"clean_up_action"}),
    #"Merged removal parties" = Table.NestedJoin(#"Expanded mpir_cleanup_actions", {"removal_party"}, mpir_removal_parties, {"code"}, "mpir_removal_parties", JoinKind.LeftOuter),
    #"Expanded mpir_removal_parties" = Table.ExpandTableColumn(#"Merged removal parties", "mpir_removal_parties", {"removal_party_text"}, {"removal_party_text"}),
    #"Merged port codes" = Table.NestedJoin(#"Expanded mpir_removal_parties", {"port_code"}, mpir_port_codes, {"unit"}, "mpir_port_codes", JoinKind.LeftOuter),
    #"Expanded mpir_port_codes" = Table.ExpandTableColumn(#"Merged port codes", "mpir_port_codes", {"district", "type", "description", "state", "opfac"}, {"port.district", "port.type", "port.description", "port.state", "port.opfac"}),
    #"Reordered Columns" = Table.ReorderColumns(#"Expanded mpir_port_codes",{"caseno", "cg_district", "cg_unit", "pcn", "incident_year", "pind", "port_code", "osc", "epa", "cdate", "valid", "reported_by", "reported_by_text", "rdate", "rtime", "dtime", "sdate", "stime", "casref", "wtrbd", "waterbody", "rmile", "city", "state", "state_text", "act", "clean_up_action", "removal_party", "removal_party_text", "pnum", "ptype", "ceiling", "expend", "tcost", "notification", "nrcnumber", "year", "qtr", "latitude", "longitude"})
in
    #"Reordered Columns"