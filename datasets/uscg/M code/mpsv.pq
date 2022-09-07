// Author: Chris Aragao
// Date: 9.6.2022
// Purpose: Documentation for appending the mpsv70 and mpsv80 with cleaning

// CHANGELOG
//----------------
// 9.6.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Table.Combine({mpsv70, mpsv80}),
    #"Merged verification" = Table.NestedJoin(Source, {"sver"}, mpsv_verification_codes, {"code"}, "mpsv_verification_codes", JoinKind.LeftOuter),
    #"Expanded mpsv_verification_codes" = Table.ExpandTableColumn(#"Merged verification", "mpsv_verification_codes", {"verification_text"}, {"verification_text"}),
    #"Merged vessel service type" = Table.NestedJoin(#"Expanded mpsv_verification_codes", {"vstype"}, mpsv_vessel_service_type, {"code"}, "mpsv_vessel_service_type", JoinKind.LeftOuter),
    #"Expanded mpsv_vessel_service_type" = Table.ExpandTableColumn(#"Merged vessel service type", "mpsv_vessel_service_type", {"vessel_service_text"}, {"vessel_service_text"}),
    #"Merged operations" = Table.NestedJoin(#"Expanded mpsv_vessel_service_type", {"oper"}, mpsv_operations, {"code"}, "mpsv_operations", JoinKind.LeftOuter),
    #"Expanded mpsv_operations" = Table.ExpandTableColumn(#"Merged operations", "mpsv_operations", {"operation_text"}, {"operation_text"}),
    #"Merged primary causes" = Table.NestedJoin(#"Expanded mpsv_operations", {"primc"}, mpsv_primary_causes, {"code"}, "mpsv_primary_causes", JoinKind.LeftOuter),
    #"Expanded mpsv_primary_causes" = Table.ExpandTableColumn(#"Merged primary causes", "mpsv_primary_causes", {"primary_cause_text"}, {"primary_cause_text"}),
    #"Merged secondary causes" = Table.NestedJoin(#"Expanded mpsv_primary_causes", {"seconc"}, mpsv_secondary_causes, {"code"}, "mpsv_secondary_causes", JoinKind.LeftOuter),
    #"Expanded mpsv_secondary_causes" = Table.ExpandTableColumn(#"Merged secondary causes", "mpsv_secondary_causes", {"secondary_cause_text"}, {"secondary_cause_text"}),
    #"Merged contributing factors 1" = Table.NestedJoin(#"Expanded mpsv_secondary_causes", {"contrib1"}, mpsv_contributing_factors, {"code"}, "mpsv_contributing_factors", JoinKind.LeftOuter),
    #"Expanded mpsv_contributing_factors" = Table.ExpandTableColumn(#"Merged contributing factors 1", "mpsv_contributing_factors", {"contributing_factor_text"}, {"factor1.contributing_factor_text"}),
    #"Merged contributing factors 2" = Table.NestedJoin(#"Expanded mpsv_contributing_factors", {"contrib2"}, mpsv_contributing_factors, {"code"}, "mpsv_contributing_factors", JoinKind.LeftOuter),
    #"Expanded mpsv_contributing_factors1" = Table.ExpandTableColumn(#"Merged contributing factors 2", "mpsv_contributing_factors", {"contributing_factor_text"}, {"factor2.contributing_factor_text"}),
    #"Reordered Columns" = 
        Table.ReorderColumns(
            #"Expanded mpsv_contributing_factors1",
            {
                "scaseno", 
                "cif_suppl_rec_type", 
                "cif_num_sup_rec", 
                "sver", 
                "verification_text",
                "vsname", 
                "vstype", 
                "vessel_service_text", 
                "vsstyp", 
                "vin1", 
                "vin2", 
                "vin3", 
                "vin4", 
                "vin5", 
                "csign", 
                "flag", 
                "oper", 
                "operation_text",
                "penact", 
                "primc", 
                "primary_cause_text", 
                "seconc", 
                "secondary_cause_text", 
                "contrib1", 
                "factor1.contributing_factor_text",
                "contrib2", 
                "factor2.contributing_factor_text", 
                "pind"  
            }
    )
in
    #"Reordered Columns"