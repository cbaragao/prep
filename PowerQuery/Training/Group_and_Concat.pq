(tbl as table, col as text, new_col as text)=>

let
    Grouped = Table.Group(
        tbl, 
        col, 
        {{new_col, each Text.Combine(col, ", "), type nullable text}}
    )
in
    Grouped