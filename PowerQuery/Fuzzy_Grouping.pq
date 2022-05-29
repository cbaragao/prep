(tbl as table, col as text, thres as number)=>

let

    Fuzzy_Group = Table.FuzzyGroup(
        tbl,
        col,
        {"Count", each Table.RowCount(_)},
        [IgnoreCase = true, IgnoreSpace = true, Threshold = thres]
    )

in
    Fuzzy_Group
