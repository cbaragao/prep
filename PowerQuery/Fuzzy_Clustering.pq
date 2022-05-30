(tbl as table, col as text)=>

Table.AddFuzzyClusterColumn(
    
    tbl, 
    col, 
    "Cluster", 
    [IgnoreCase = true, 
    IgnoreSpace = true, 
    SimilarityColumnName = 
    "Word_Cluster_Similarity"]
)