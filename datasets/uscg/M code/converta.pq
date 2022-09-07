// Author: Chris Aragao
// Date: 9.2.2022
// Purpose: Documentation for Power Query on converta.txt file
// Notes: Filepath is just a placeholder for the file path for the text field

// CHANGELOG
//----------------
// 8.31.2022: Initial documentation provided.

(FILEPATH as text)=>

let
    Source = Csv.Document(File.Contents(FILEPATH & "converta.txt"),[Delimiter="	", Columns=16, Encoding=1252, QuoteStyle=QuoteStyle.None]),
    #"Renamed Columns" = Table.RenameColumns(Source,{{"Column1", "year"}, {"Column2", "chem_code"}, {"Column4", "cases"}, {"Column5", "total_potential"}, {"Column6", "in_water_qty_spilled"}, {"Column7", "in_water_qty_rec"}, {"Column8", "out_water_qty_spilled"}, {"Column9", "out_water_qty_rec"}, {"Column10", "unit_of_measure"}, {"Column11", "substance_name"}, {"Column12", "spilled_date"}, {"Column13", "district"}, {"Column14", "unit"}, {"Column15", "supplement_id"}, {"Column16", "sp"}}),
    #"Added Custom" = Table.AddColumn(#"Renamed Columns", "type", each if [Column3] = "C" then "Chemical" else if [Column3] = "P" then "Petroleum" else if [Column3] = "O" then "Other oil products" else if [Column3] = "G" then "Garbage" else if [Column3] = "U" then "Unknown" else if [Column3] = "M" then "Multiple substances" else if [Column3] = "N" then "Natural substances" else "No Value"),
    #"Removed Other Columns" = Table.SelectColumns(#"Added Custom",{"year", "chem_code", "type", "cases", "total_potential", "in_water_qty_spilled", "in_water_qty_rec", "out_water_qty_spilled", "out_water_qty_rec", "unit_of_measure", "substance_name", "spilled_date", "district", "unit", "supplement_id", "sp"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Removed Other Columns",{{"total_potential", type number}, {"in_water_qty_spilled", type number}, {"in_water_qty_rec", type number}, {"out_water_qty_spilled", type number}, {"out_water_qty_rec", type number}, {"spilled_date", type date}, {"district", Int64.Type}})
in
    #"Changed Type"